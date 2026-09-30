# Audio script — Collaborative Document Editor (Google Docs / Notion / Quip)

## §0 Introduction

Collaborative Document Editor (Google Docs / Notion / Quip)

## §1 Overview

Designing a collaborative document editor involves complex distributed systems concepts applied to mobile clients. It tests a candidate's grasp of conflict resolution, optimistic UI updates, and synchronization mechanisms when multiple users edit the same text simultaneously.

## §2 Target Companies & Frequency

| Company | Why They Ask | Frequency | |---------|--------------|-----------| | Google | Google Docs is the pioneer; rigorous testing on concurrency. | ★★★★☆ | | Notion | Heavy mobile usage; local-first offline capabilities. | ★★★★☆ | | Microsoft | Office 365 / Loop rely on these exact principles. | ★★★★☆ | | Dropbox | Dropbox Paper requires deep understanding of sync engines. | ★★★☆☆ |

## §3 Scope Definition

In Scope - Real-time text editing by multiple concurrent users. - Conflict resolution mechanisms. - Offline editing capabilities and background sync. - Optimistic UI updates. - Cursor and presence sharing. Out of Scope - Rich text formatting (bold, italic, embedded images) - limit to plain text / simple blocks. - Document permissions and ACLs. - Folder hierarchies and search. - Version history UI.

## §4 Requirements

Functional Requirements 1. Users can open and edit a document concurrently with others. 2. Changes appear in real-time to other users. 3. Edits made while offline are saved and synced upon reconnection without overwriting others' work. 4. Users can see where others are currently typing (presence). Non-Functional Requirements | Requirement | Target | Source | |-------------|--------|--------| | Sync Latency | < 100ms | Collaborative Editing HCI Studies | | Local Input Latency | < 16ms (60fps) | iOS HIG | | Concurrent Editors | Up to 100 | Google Docs Limits | | Presence Broadcast | Every 500ms | Standard UI Debounce |

## §5 High-Level Architecture (HLD)

Component Diagram text [iOS Client] │ ├─► UI Layer (TextKit / CoreText ViewModels) │ ├─► Domain Layer (OT Engine / CRDT, Optimistic Applier) │ ├─► Repository Layer (Local OpLog, Snapshot Cache) │ │ │ └─► SQLite (Append-only Op Log) │ └─► Network Layer │ ├─► WebSocketManager (Real-time Ops & Presence) └─► REST API (Initial Snapshot Fetch) [Backend Infrastructure] │ ├─► WebSocket Gateway ├─► OT Server (Single Source of Truth, Sequence Assigner) ├─► Redis (Pub/Sub for Presence) └─► Document Database (MongoDB / DynamoDB for Snapshots & Op History) Component Responsibilities | Component | Responsibility | iOS Implementation | |-----------|----------------|--------------------| | OperationTransformer | Handles OT math (transforming client ops against server ops). | Pure Swift struct/class | | OpLogRepository | Persists local pending ops and server applied ops. | SQLite | | DocumentViewModel | Manages Text view state, handles local inputs. | ObservableObject | | SyncEngine | Coordinates between OpLog, OT Engine, and Network. | Actor / Background Queue | Data Flow 1. Local Edit : User types character - Generated Op - Applied locally immediately (Optimistic UI) - Saved to pending queue. 2. Sync : Send pending Op + baseRevision to server via WebSocket. 3. Server Transform : Server receives Op. If server revision baseRevision , server transforms Op against intermediate history, applies, broadcasts to others, and ACKs client with newRevision . 4. Client ACK : Client receives ACK, removes Op from pending, updates local revision. 5. Remote Edit : Client receives remote Op - Transforms against local pending ops - Applies to UI.

## §6 Data Models

Core Entities swift import Foundation enum OpType: String, Codable { case insert case delete case retain // For rich text, but useful for basic OT to skip chars } struct Operation: Codable, Equatable { let id: String // UUID let type: OpType let position: Int let text: String // Generates a reverse operation for local undo func inverse() - Operation { switch type { case .insert: return Operation(id: UUID().uuidString, type: .delete, position: position, text: text) case .delete: return Operation(id: UUID().uuidString, type: .insert, position: position, text: text) case .retain: return self } } } struct DocumentSnapshot: Codable { let id: String let content: String let revision: Int } Database Schema sql CREATE TABLE document snapshots ( doc id TEXT PRIMARY KEY, content TEXT NOT NULL, revision INTEGER NOT NULL ); -- Append-only log of operations CREATE TABLE operation log ( id TEXT PRIMARY KEY, doc id TEXT NOT NULL, revision INTEGER, -- Null if pending locally op type TEXT NOT NULL, position INTEGER NOT NULL, text content TEXT, state INTEGER NOT NULL, -- 0: pending, 1: synced created at REAL NOT NULL, FOREIGN KEY(doc id) REFERENCES document snapshots(doc id) ); CREATE INDEX idx oplog state ON operation log(doc id, state);

## §7 API Design

Endpoints 1. GET /v1/docs/{id}/snapshot - Response : json { "doc id": "doc-123", "content": "Hello World", "revision": 42 } 2. WebSocket Sync Channel - Payloads : json // Client - Server (Submit Ops) { "action": "submit ops", "base revision": 42, "ops": [ { "type": "insert", "position": 5, "text": "!" } ] } // Server - Client (Broadcast/ACK) { "action": "apply ops", "new revision": 43, "ops": [ { "type": "insert", "position": 5, "text": "!" } ] } // Client - Server (Presence) { "action": "presence", "user id": "user-1", "cursor position": 6 }

## §8 Client Architecture Deep-Dives

1. Operational Transformation (OT) Engine OT is the core algorithm. If two clients edit at the same time, their operations must be mathematically transformed so the final document state matches regardless of application order. swift class OperationTransformer { /// Transforms Op A against Op B. /// Assumes both ops were generated at the same base revision. static func transform(clientOp: Operation, serverOp: Operation) - Operation { // Simplified OT logic for single character insert/delete var transformedPosition = clientOp.position if serverOp.type == .insert { if serverOp.position < clientOp.position { // Server inserted before client, shift client right transformedPosition += serverOp.text.count } else if serverOp.position == clientOp.position { // Tie breaker: standard is server wins, or rely on site/user ID // Let's assume server op comes first transformedPosition += serverOp.text.count } } else if serverOp.type == .delete { if serverOp.position < clientOp.position { // Server deleted before client, shift client left let shift = min(clientOp.position - serverOp.position, serverOp.text.count) transformedPosition -= shift } } return Operation( id: clientOp.id, type: clientOp.type, position: transformedPosition, text: clientOp.text ) } } 2. Synchronization & Pending Queue The client must maintain a localRevision and a queue of pendingOps . swift actor SyncEngine { private var localRevision: Int private var pendingOps: [Operation] = [] private var documentContent: String init(snapshot: DocumentSnapshot) { self.localRevision = snapshot.revision self.documentContent = snapshot.content } // 1. User types - Optimistic application func applyLocalEdit(op: Operation) { documentContent = apply(op: op, to: documentContent) pendingOps.append(op) // Trigger network send: send(ops: pendingOps, baseRevision: localRevision) } // 2. Network receives server ops func receiveServerOps(serverOps: [Operation], newRevision: Int) { // We must transform pending ops against incoming server ops var transformedServerOps = serverOps for serverOp in serverOps { var currentServerOp = serverOp for (index, pendingOp) in pendingOps.enumerated() { // Transform pending op against server op let transformedPending = OperationTransformer.transform(clientOp: pendingOp, serverOp: currentServerOp) // Transform server op against pending op (for local application) currentServerOp = OperationTransformer.transform(clientOp: currentServerOp, serverOp: pendingOp) pendingOps[index] = transformedPendin End of section.

## §9 Performance & Optimizations

| Optimization | Technique | Benchmark/Impact | |--------------|-----------|------------------| | Text Rendering | Use TextKit / NSAttributedString directly instead of SwiftUI TextEditor for large docs. | Avoids main thread lockups on 10k words. | | Batching Ops | Group multiple character inserts within 500ms into a single string insert Op. | Reduces WebSocket traffic by 80%. | | Snapshotting | Server periodically (every 100 ops) saves a hard snapshot. | Client load time O(1) instead of replaying thousands of ops. |

## §10 Failure Modes & Fallbacks

| Failure Scenario | Detection | Fallback Strategy | |------------------|-----------|-------------------| | Desync / Bad OT | Client hash mismatch with Server hash | Client forces a full snapshot reload, discarding invalid local ops. | | Prolonged Offline | Local ops 1000 | Warn user; auto-compact local ops where possible (e.g. insert+delete same char = no-op). |

## §11 Trade-off Analysis

| Decision | Option A | Option B | Chosen | Why | |----------|----------|----------|--------|-----| | Algorithm | CRDTs | OT (Op Transformation) | OT | OT is standard for centralized servers (Google Docs). CRDTs (Figma) use more memory and metadata (tombstones) per character, which can bloat mobile memory. | | Text Input | SwiftUI TextEditor | UITextView / TextKit | UITextView | Standard UI components don't expose character-level precise offsets and mutations easily; TextKit allows granular control. | | Sync Protocol | REST Polling | WebSockets | WebSockets | 100ms latency requirement makes polling unviable. |

## §12 Observability & Metrics

- Sync Latency : Time from local edit to server ACK. - Desync Rate : Number of times client hashes mismatch server hashes (critical metric for OT correctness). - Conflict Resolution Time : CPU time spent in OperationTransformer per loop.

## §13 Production Benchmarks Reference

| Metric | Value | Source | |--------|-------|--------| | Tech Stack | OT via central server | Google Docs Engineering | | Alternative Stack| CRDTs via peer-to-peer | Figma / Automerge | | Op Batching | 500ms or word-boundary | Common practice |

## §14 Interview Tips

- CRDT vs OT : You WILL be asked this. Know that CRDTs resolve conflicts mathematically without a central server by assigning unique IDs to every character. OT relies on a central server to dictate order. - Optimistic UI : Emphasize that the user should NEVER feel blocked by the network. - Text Frameworks : Acknowledge that standard SwiftUI bindings ( @State var text ) break down here; you need precise offset control via UITextViewDelegate .

## §15 Architecture Diagram

mermaid flowchart TD UserEdit[User Edit] -- DocumentViewModel DocumentViewModel -- OperationTransformer OperationTransformer -- OpLogRepository[(OpLogRepository SQLite)] OperationTransformer -- WebSocket WebSocket <-- Server[Server - OT Authority] Server -- Merge[Merge] Merge -- Broadcast[Broadcast to Peers]

## §16 Common Mistakes

- Using last-write-wins for text (data loss). - Not maintaining pendingOps queue (out-of-order application). - Applying remote ops before transforming against pending local ops. - Not storing op log locally (can't reconstruct state offline). - Using CRDT when server authority is available (unnecessary complexity).

## §17 Mock Interview Q&A

Q: Two users type in the same paragraph at the same time. Walk me through exactly what happens. A: Both clients optimistically apply their edits locally. Client A sends Insert(pos:5, "X") and Client B sends Insert(pos:5, "Y") . The server receives A first, broadcasts it. B receives A's edit, transforms its pending "Y" against "X" (shifting position to 6), and applies it. Q: Why would you choose OT over CRDTs for this? A: We already have a central server. CRDTs carry a lot of metadata overhead (tombstones for every deleted character), which can bloat mobile memory. OT keeps the payload small and leverages the server as the source of truth. Q: How do you handle offline editing for 20 minutes then reconnect? A: Edits are appended to a local SQLite operation log. Upon reconnect, we batch these pending ops and send them to the server with our last known baseRevision . The server transforms them against the 20 minutes of history and broadcasts the result. Q: What if the OT transformation fails or state diverges? A: We implement a hash check. Periodically, the client sends a hash of its document state. If it mismatches the server, the client halts, discards pending ops, and forces a full snapshot reload. Q: How do you handle cursor positions of other users? A: Cursor positions are ephemeral state broadcast via a separate Redis Pub/Sub channel over WebSocket. They are transformed similarly to text edits so they don't drift as the document changes.

## §18 Related Specs

| Spec | Reason | |------|--------| | Offline Sync Engine | Details local DB structure and conflict resolution paradigms. |
