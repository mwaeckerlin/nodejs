# Changelog

- 2026-07-17 **1.1.1**
    - Documentation now states the image's role explicitly: production runtime base for the final stage — building happens in the build-only image that must never run in production
    - Image build no longer emits warnings (modernized instruction format)

- 2026-07-14 **1.1.0**
    - The shipped image is now automatically verified to contain no shell and no scripting language — an attacker who reaches code execution in the container finds no tool to pivot with
