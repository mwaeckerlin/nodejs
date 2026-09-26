# Changelog

- 2026-09-26 **1.1.2**
    - The image is published for amd64 and arm64 under one tag, built and published automatically on every change and every week
    - The README showed a wrong example for a different entry point: `node` is the entrypoint, so the `CMD` names the script only

- 2026-07-17 **1.1.1**
    - Documentation now states the image's role explicitly: production runtime base for the final stage — building happens in the build-only image that must never run in production
    - Image build no longer emits warnings (modernized instruction format)

- 2026-07-14 **1.1.0**
    - The shipped image is now automatically verified to contain no shell and no scripting language — an attacker who reaches code execution in the container finds no tool to pivot with
