# Client SDK

## Widget Installation

Highline's widget is a front-end UI element that allows users to grant your application access to their work accounts, set up automated payments, and switch deposits directly from their paychecks.

To use Highline-Link, pass in an object with the following parameters to the `highlineLink.connect()` function:

Parameter | Type | Description
--------- | ------- | -----------
`access_token` *required* | string | Value from the '/auth/token' endpoint
`payload` *required* | string | Encrypted value from the '/link/encode' endpoint
`on_success` *optional* | function | Callback function for success events
`on_error` *optional* | function | Callback function for error events
`on_close` *optional* | function | Callback function for close events


And then open with highlineLink.open()

## Direct Deposit Switch Guide

> Step 1

```javascript
curl -X POST 'http://api.highline.co/auth/token'
-H "Authorization Bearer: AccessToken" \
-d $'{
  "api_key": "YOUR_API_KEY",
  "secret" : "YOUR_SECRET"
}'
```

> Response:

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

> Step 2

```javascript
curl -X POST 'http://api.highline.co/link/encode'
Bearer AccessToken
-H "Authorization Bearer: AccessToken" \
-d $'{
 "bank_account": {
   "bank_name": "New Bank",
   "account_type": "checking",
   "routing_number": "XXXXXXXX",
   "account_number": "XXXXXXXXXX"
 },
 "feature": "direct_deposit_switch"
}'
```

> Response:
```json
{
 "payload": "encrypted_value",
}
```

> Step 3

```javascript
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
</head>
<body>
  <highline-link></highline-link>
  <script src="https://link.highline.co/v1/highline-link.js"></script>
  <script type="text/javascript">
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        payload: 'value_from_link_encode_api',
        on_success: ({ user_id }) => {
          console.log('on_success! ' + user_id);
        },
        on_error: () => {
          console.log('on_error!');
        },
        on_close: () => {
          console.log('on_close!');
        }
    });
    highlineLink.open();
  </script>
</body>
</html>
```

### Step 1 - Get an access token from your server

### Step 2 - Build the payload

### Step 3 - Connect and open Highline-Link
