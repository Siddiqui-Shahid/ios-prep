# Audio script — Drill — HTTP request model vs download

## §0 Introduction

Drill — HTTP request model vs download From: 21 Aug machine-style round. They asked the difference between a generic request model and a download request . You kept answering “the downloading part.” They wanted the type’s job .

## §1 Keywords

- URLRequest (method, URL, headers, body — the HTTP envelope). - URLSessionDownloadTask (streams to a file; resume data; not a JSON DTO). - DTO (Data Transfer Object: Codable struct for JSON). - Protocol ( HTTPClient.send(URLRequest) so tests fake it).

## §2 Target answer (45s)

“A request model describes what to send — URL, method, headers, maybe a body encoder. A download task is how bytes land on disk — file URL, progress, resume. I would not overload one struct to be both a GET /users DTO and a 200MB asset download. Shared session, separate APIs.” If they say “generic structure”: “Yes, Endpoint + URLRequest . Download is a different task type on the same session.”

## §3 Parallel downloads (they asked this next)

Two book taps at once. Do not say “callback.” Speak: one URLSession with two downloadTask s, keyed by book id, progress on the main actor, cancel per id, resume data if the file is large. A download manager (object that owns tasks) is the design; a single completion handler is not.
