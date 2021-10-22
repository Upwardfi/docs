# Link

In order to create a deposit configuration we need to encrypt the payload that will be sent by Highline Link.

## Create a Deposit Payment (Virtual Account)

```shell
curl -X POST http://api.highline.co/link/encrypt \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
  -d '{
    "bank_account": {
      "bank_name": "Townbank",
      "account_type": "checking",
      "routing_number": "100000000",
      "account_number": "000000001",
    }
  }'
```

> Response
```json
{
  "encrypted_payload": "0123456789abcdef..."
}
```

Deposit payments are target to a virtual bank account created internally for the member.
Therefore there is no need to inform bank account details here.

### HTTP Request

`POST http://api.highline.co/link/encrypt`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`bank_account` | json | Bank Account

### Response

Parameter | Type | Description
--------- | ------- | -----------
`encrypted_payload` | string | Encrypted payload


### Bank Account Object

Parameter | Type | Description
----------|----------|---------
`bank_name` | string | Bank Name
`account_type` | string | Account Type
`routing_number` | string | Routing Number
`account_number` | string | Account Number

