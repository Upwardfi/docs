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
        feature: 'direct_deposit_switch',
        payload: 'encrypted_value'
    });
    highlineLink.open();
```

### Step 3 - Connect and open Highline-Link

## Direct Deposit Payment Steps

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
curl -X POST http://api.highline.co/enrollments \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "product_id": "6351fsd6fs-sdfs...",
    "payment_amount": 20000,
    "payment_frequency": "monthly",
    "first_payment_date": 1634740754,
    "application_reference_number": "16576",
    "days_until_expires": 30
  }'
```

> Response

```json
{
  "id": "DVNA4...",
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "application_reference_number": "16576AB",
  "status": "new",
  "created_at": 1634741667,
  "updated_at": 1634741667
}
```

### Step 2 - Create an enrollment


> Step 3

```javascript
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        feature: 'direct_deposit_payment',
        enrollment_id: 'id_from_enrollments_api'
    });
    highlineLink.open();
```

### Step 3 - Connect and open Highline-Link

## Employment Data Steps

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

```javascript
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        feature: 'employment_data'
    });
    highlineLink.open();
```

### Step 2 - Connect and open Highline-Link
