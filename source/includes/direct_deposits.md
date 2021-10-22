# Direct Deposits

In order to create a deposit configuration we need to encrypt the payload that will be sent by Highline Link.

## Create a Deposit Payment (Virtual Account)

```shell
curl -X POST http://api.highline.co/deposit_payments/request \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
  -d '{
    "user_id": "6351fsd6fs-sdfs...",
    "provider_name": "argyle"
  }'
```

> Response
```json
{
  "encrypted_config": "0123456789abcdef..."
}
```

Deposit payments are target to a virtual bank account created internally for the member.
Therefore there is no need to inform bank account details here.

### HTTP Request

`POST http://api.highline.co/deposit_payments/request`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`user_id` *required* | string | body | User ID
`provider_name` *required* | string | body | Payroll data provider name

### Response

Parameter | Type | Description
--------- | ------- | -----------
`encrypted_config` | string | Encrypted config

## Create a Deposit Switch (External Account)

```shell
curl -X POST http://api.highline.co/deposit_switch/request \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
  -d '{
    "user_id": "6351fsd6fs-sdfs...",
    "provider_name": "argyle",
    "encrypted_payload": "0123456789abcdef..."
  }'
```

> Response
```json
{
  "encrypted_config": "0123456789abcdef..."
}
```

When creating a deposit switch the bank account details must be informed.
The `encrypted_payload` field contains this data, previously encrypted by `POST /link/encrypt`.

### HTTP Request

`POST http://api.highline.co/deposit_switch/request`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`user_id` *required* | string | body | User ID
`provider_name` *required* | string | body | Payroll data provider name
`encrypted_payload` *required* | string | body | Encrypted bank account details

### Response

Parameter | Type | Description
--------- | ------- | -----------
`encrypted_config` | string | Encrypted config

## Get User's direct deposits

```shell
curl -X GET http://api.highline.co/users/6516515-651.../payout_allocations \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "ca71927a-c5...",
  "user_id": "ae16efec-d1...",
  "employment_id": "d6b10b60-55...",
  "bank_account_id": "4fb1c5dd-5d...",
  "status": "active",
  "created_at": 1633633510,
  "updated_at": 1633633510
}]
```

This API endpoint returns the user's payout allocations, that represents direct deposits, based on the provided user id.

`GET http://api.highline.co/users/{id}/payout_allocations`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User ID

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Payout Allocation ID
`user_id` | string | User ID
`employment_id` | string | Employment ID
`employment` | json | Employment structure
`bank_account_id` | string | Bank account ID
`status` | string | Status of payout allocation ("active" "pending")
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update