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

The endpoints uses JWT token authentication.

You can have you token via the `API key` which you can find in your accounts settings endpoint. Your API keys carry many privileges, so be sure to keep them secure! Do not share your secret API keys in publicly accessible areas such as GitHub, client-side code, and so forth.

### Parameters

Attribute | Type | Description
--------- | ------- | ------ | --------
`access_token` | string | Token used to perform requests
`refresh_token` | string | Token used to request new tokens
`subject` | string | Your API Key
`expires_in` | int | Timestamp of token expire time

Authentication to the API is performed via Bearer token. Provide your `access_token` as the Bearer auth value. You do not need to provide the secret again.

### HTTP Request

```shell
curl -X GET https://api.highline.co/enrollments/123e4567-e89b-12d3-a456-426614174000 \
  -H "Authorization: Bearer eyJhbGciOiJIUzI..."
  ```

`GET http://api.highline.co/enrollments/{id}`

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

All tokens have a expiration time of 15 minutes.

Once you have your token expired, you can ask a new one using the previous `refresh_token`, that have 30 days of expiration time.

To ask brand new tokens you can do like so:

<br />
Request:

Attribute | Type | Description
--------- | ------- | ------ | --------
`refresh_token` *required* | string | Token used to request new tokens
`subject` *required* | string | Your API Key
`grant_type` *required* | string | Default string "refresh_token"

