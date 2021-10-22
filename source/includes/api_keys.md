# API Keys

Highlines's API uses OAuth 2.0 Bearer Token to authenticate requests.

<aside class="notice">
    An invalid, missing or expired token will result in HTTP `401` Unauthorized responses.
</aside>

* All API calls must include a bearer token.
* The API key should be kept confidential and only stored on your own servers.
