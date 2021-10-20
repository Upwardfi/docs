# Bank Accounts

## Add bank account

```shell
curl -X POST http://api.highline.co/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "account_number": "874038933",
    "routing_number": "111000614",
    "account_type": "checking",
    "bank_name": "J.P. Morgan Chase"
  }'
```

> Response

```json
{
  "id": "GzJcht38SCJuMhzCYtMXJz"
}
```

This API adds a bank account to an enrollment via Highline. By passing basic bank account information Highline will return a key unique to the user based on the user id.

### HTTP Request

`POST http://api.highline.co/users/{id}/bank_accounts`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id
`account_number` *required* |string | body | Account number
`routing_number` *required* | string | body | Routing number
`account_type` *required* | string | body | Type of account (checking, savings, etc)
`bank_name` *required* | string | body | Name of bank

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns bank account id.

## Get bank accounts

```shell
curl -X GET http://api.highline.co/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "GtMXJzGzJcht38SCJuMhvG",
  "account_number": "909000614",
  "routing_number": "111000614",
  "account_type": "checking",
  "is_virtual": false,
  "bank_name": "J.P. Morgan Chase"
}]
```

This API returns user's bank accounts based on the specified user id.

### HTTP Request

`GET http://api.highline.co/users/{id}/bank_accounts`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Account id
`account_number` |string | Account number
`routing_number` | string | Routing number
`account_type` | string | Type of account (checking, savings, etc)
`bank_name` | string | Name of bank
`is_virtual` | boolean | Specifies whether this account is a virtual account or not
`created_at` | timestamp | Timestamp bank account was created
`updated_at` | timestamp | Timestamp bank account was updated

<!-- ## Get bank account

This API returns bank account details based on the specified user and bank account id.

### HTTP Request

`GET http://api.highline.co/users/{id}/bank_accounts/{bank_account_id}`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id
`bank_account_id` *required* | string | path | Bank account id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`account_number` |string | Account number
`routing_number` | string | Routing number
`account_ype` | string | Type of account (checking, savings, etc)
`bank_name` | string | Name of bank
`created_at` | timestamp | Timestamp bank account was created
`updated_at` | timestamp | Timestamp bank account was updated

```shell
curl -X GET http://api.highline.co/users/38SCJuMhzCYtMXJzGzJcht/bank_accounts/GtMXJzGzJcht38SCJuMhvG \
  -H "Authorization Bearer: base64(app_id:app_secret)" \
  -H "Content-Type: application/json"
```

> The above command returns JSON structured like this:

```json
{
  "account_number": "909000614",
  "routing_number": "111000614",
  "account_type": "checking",
  "bank_name": "J.P. Morgan Chase"
}
``` -->
