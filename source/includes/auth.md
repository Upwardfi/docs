# Authentication

## Access Token

> Example Request:

```shell
curl -X POST http://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET"
  }'
```

> Response

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

The endpoints uses OAuth 2.0 Bearer Token to authenticate requests.

You can request tokens with `/auth/token` endpoint. The `API Key` and `API secret` are available in the account settings page. Your API keys carry many privileges, so be sure to keep them secure! Do not share your secret API keys in publicly accessible areas such as GitHub, client-side code, and so forth.

### HTTP Request

`POST http://api.highline.co/auth/token`

### Response

Attribute | Type | Description
--------- | ------- | ------ | --------
`access_token` | string | Token used to perform requests
`refresh_token` | string | Token used to request new tokens
`subject` | string | Your API Key
`expires_in` | int | Timestamp of token expire time


Authentication to the APIs is performed via Bearer token. Pass the `access_token` as the Bearer auth value.

All API requests must be made over HTTPS. Calls made over plain HTTP will fail.

## Refresh Token

> Example Request:

```shell
curl -X POST http://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "refresh_token" : "eyJhbGciOiJIUz...",
    "subject":"123e4567-e89b-12d3-a456-426614174000",
    "grant_type": "refresh_token"
  }'
```

> Response

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

All tokens have a expiration time of 15 minutes. The refresh token is used to generate a new access token.

Once the `access_token` has expired, you’ll be required to generate a new access token using the `refresh_token`

### HTTP request

`POST http://api.highline.co/auth/token`

To ask for a new access token, the following fields are required

Attribute | Type | Description
--------- | ------- | ------ | --------
`refresh_token` *required* | string | Token used to request new tokens
`subject` *required* | string | Your API Key
`grant_type` *required* | string | Default string "refresh_token"
