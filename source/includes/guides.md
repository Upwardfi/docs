# Guides

## Direct Deposit Switch Steps

> Step 1

```shell
curl -X POST http://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
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

### Step 1 - Get an access token


> Step 2

```shell
curl -X POST http://api.highline.co/link/encrypt \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "bank_account": {
      "bank_name": "New Bank",
      "account_type": "checking",
      "routing_number": "XXXXXXXXX",
      "account_number": "XXXXXXXXXX"
    }
  }'
```

> Response:

```json
{
 "payload": "encrypted_value",
}
```

### Step 2 - Encrypt the bank details


> Step 3

```javascript
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        feature: 'direct_deposit_switch'
        payload: 'encrypted_value',
    });
    highlineLink.open();
```

### Step 3 - Connect and open Highline-Link
