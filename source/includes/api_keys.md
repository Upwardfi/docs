# API Keys

Highline's API uses JWT Token authentication. All API calls must include a bearer token.

<aside class="warning">
    An invalid, missing or expired token will result in HTTP `401` Unauthorized responses.
</aside>

The API key should be kept confidential and only stored on your own servers.

Each account has a total of two keys: a key pair for test mode and live mode.