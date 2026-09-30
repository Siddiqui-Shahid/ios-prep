# Audio script — Sample design — payment checkout

## §0 Introduction

Sample design — payment checkout They say: “Design checkout.” Money. Idempotency. No PAN on your servers.

## §1 Problem

User pays for tickets or a cart. The app can be killed mid- 3-DS (3-D Secure: bank challenge). Double tap must not double charge. This is the sample you speak if tomorrow is commerce.

## §2 Requirements (2 minutes — ask, then lock)

No PAN (Primary Account Number: full card) on our backend — tokenize via the payment SDK. Persist a local order id before POST /charges . Idempotency-Key on the charge. 3-DS can background us; reconcile with GET /orders/{id} . Tokens in Keychain , never UserDefaults. Disable the Pay button after first tap. Price is server-authoritative; the client does not invent ₹ amounts. Confirm: “Tokenize, local order first, idempotent charge, reconcile after 3-DS, no PAN in logs. Good?”

## §3 API and data

POST /v1/orders → { order id, amount, currency } POST /v1/charges Idempotency-Key: local UUID { order id, payment token } GET /v1/orders/{id} → { status: creating|requires action|succeeded|failed }

## §4 iOS LLD (types and sequence)

CheckoutViewModel → PaymentService → TokenSDK + OrdersAPI + OrderStore . User taps Pay. Disable the button. Insert local Order(status: .creating, id: uuid) . Tokenize in the SDK UI so PAN never hits your logger. POST /charges with that uuid as Idempotency-Key. If requires action , present 3-DS. The app may suspend. On next launch or scenePhase active: GET /orders/{id} until terminal. Never charge again. Show receipt. Clear the local creating row. App killed mid-pay is the deep dive. Disk is why you survive. PCI: you stay out of scope if the SDK owns the PAN field. Say that sentence. Failure: network drop after tap — the GET on resume is the source of truth, not a second POST. 4xx from the PSP: re-enable Pay only if the order is failed, not if it is still requires action .

## §5 HLD (scale, cache, consistency)

iOS → API → Orders service → Redis short-TTL hold if inventory (seats: 2 minutes, not forever) → PSP (payment service provider). Webhook from PSP updates order status. Push is a hint; GET is truth. Idempotency store keyed by key + user, TTL longer than a confused retry (24h is a common story; label it). Payment is not eventual in the UI. You poll or wait for a known status. Stale “success” from cache is how you get support tickets.

## §6 Tradeoffs

Wallet (Apple Pay) vs card: Apple Pay still needs a server payment intent. The button is not the system. Client-side amount display is OK for UX, never for charge. Webview checkout is last resort; you lose native kill-and-resume unless you keep the order id.

## §7 60-second close

“If they ask me to wrap: tokenize, never store PAN, write the order locally first, charge with an idempotency key, reconcile on resume after 3-DS, Keychain for tokens. Double tap is a disabled button plus the key.”
