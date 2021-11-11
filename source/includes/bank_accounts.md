# Bank Accounts

## Add bank account

```shell
curl -X POST https://api.highline.co/users/c8e1f36e-c4.../bank_accounts \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "account_number": "874038933",
    "routing_number": "111000614",
    "account_type": "checking",
    "bank_name": "J.P. Morgan Chase"
  }'
```

> <div class="code-block-title">Response</div>

```json
{
  "id": "c8e1f36e-c4...",
  "user_id": "07662260-b7...",
  "user": {
    "id": "d134c.....",
    "first_name": "John",
    "last_name": "Smith",
    "ssn": "1234...",
    "email": "john.smith143@highline.co",
    "created_at": 1634744601,
    "updated_at": 1634744601,
  },
  "account_number": "***2345",
  "routing_number": "6514321",
  "account_type": "Checking",
  "bank_name": "CRB",
  "kind": "external",
  "created_at": 1629916884,
  "updated_at": 1629916884
}
```

This API adds a bank account to an user.

### HTTP Request

`POST https://api.highline.co/users/{id}/bank_accounts`

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
`id` | string | Bank account ID
`user_id` | string | User ID
`user` | json | User object
`account_number` | string | Account number (masked)
`routing_number` | string | Routing number
`account_type` | string | Account Type ("checking" "savings" "other")
`bank_name` | string | Bank name
`kind` | string | Kind of account ("internal" "virtual" "external")
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update





## Get user's bank accounts

```shell
curl -X GET https://api.highline.co/users/c8e1f36e-c4.../bank_accounts \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> <div class="code-block-title">Response</div>

```json
[{
  "id": "c8e1f36e-c4...",
  "user_id": "07662260-b7...",
  "user": {
    "id": "d134c.....",
    "first_name": "John",
    "last_name": "Smith",
    "ssn": "1234...",
    "email": "john.smith143@highline.co",
    "created_at": 1634744601,
    "updated_at": 1634744601,
  },
  "account_number": "***2345",
  "routing_number": "111000614",
  "account_type": "Checking",
  "bank_name": "CRB",
  "kind": "external",
  "created_at": 1629916884,
  "updated_at": 1629916884
}]
```

This API returns a user's bank accounts.

### HTTP Request

`GET https://api.highline.co/users/{id}/bank_accounts`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Bank account ID
`user_id` | string | User ID
`user` | json | User object
`account_number` | string | Account number (masked)
`routing_number` | string | Routing number (masked)
`account_type` | string | Account Type ("checking" "savings" "other")
`bank_name` | string | Bank name
`kind` | string | Kind of account ("internal" "virtual" "external")
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update





## Get user's bank account

```shell
curl -X GET https://api.highline.co/users/c8e1f36e-c4.../bank_accounts/d938f36e-c4... \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> <div class="code-block-title">Response</div>

```json
{
  "id": "d938f36e-c4...",
  "user_id": "c8e1f36e-c4...",
  "user": {
    "id": "d134c.....",
    "first_name": "John",
    "last_name": "Smith",
    "ssn": "1234...",
    "email": "john.smith143@highline.co",
    "created_at": 1634744601,
    "updated_at": 1634744601,
  },
  "account_number": "***2345",
  "routing_number": "111000614",
  "account_type": "Checking",
  "bank_name": "CRB",
  "kind": "external",
  "created_at": 1629916884,
  "updated_at": 1629916884
}
```

This API returns a user's specified bank account based on the user id and bank account id.

### HTTP Request

`GET https://api.highline.co/users/{id}/bank_accounts/{bank_account_id}`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User ID
`bank_account_id` *required* | string | path | Bank Account ID

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Bank account ID
`user_id` | string | User ID
`user` | json | User object
`account_number` | string | Account number (masked)
`routing_number` | string | Routing number (masked)
`account_type` | string | Account Type ("checking" "savings" "other")
`bank_name` | string | Bank name
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update





## Update Bank account

```shell
curl -X PUT https://api.highline.co/users/c8e1f36e-c4.../bank_accounts/f6e1645-fc56... \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "account_number": "874038933",
    "routing_number": "111000614",
    "account_type": "checking",
    "bank_name": "J.P. Morgan Chase"
  }'
```

> <div class="code-block-title">Response</div>

```json
{
  "sucess": true
}
```

This API updates a user bank account.

### HTTP Request

`PUT https://api.highline.co/users/{id}/bank_accounts/{bank_account_id}`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id
`bank_account_id` *required* | string | path | Bank account id
`account_number` *optional* |string | body | Account number
`routing_number` *optional* | string | body | Routing number
`account_type` *optional* | string | body | Type of account (checking, savings, etc)
`bank_name` *optional* | string | body | Name of bank






## Get Account number

```shell
curl -X GET https://api.highline.co/users/c8e1f36e-c4.../bank_accounts/f6e1645-fc56.../account_number \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
```

> <div class="code-block-title">Response</div>

```json
{
  "account_number": "54615646"
}
```

This API displays an account number of a user's bank account.

### HTTP Request

`GET https://api.highline.co/users/{id}/bank_accounts/{bank_account_id}/account_number`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id
`bank_account_id` *required* | string | path | Bank account id



## Get Account balance

```shell
curl -X GET https://api.highline.co/users/c8e1f36e-c4.../bank_accounts/f6e1645-fc56.../balance \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
```

> <div class="code-block-title">Response</div>

```json
{
  "bank_account_id": "f1566dss56-516s...",
  "amount": 50000,
  "time": 1629916884,
}
```

This API displays the balance of a user’s bank account. Highline will return the balance available within the associated account

### HTTP Request

`GET https://api.highline.co/users/{id}/bank_accounts/{bank_account_id}/balance`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id
`bank_account_id` *required* | string | path | Bank account id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`bank_account_id` | string | Bank account ID
`amount` | int | Account balance (in cents)
`time` | timestamp | Data time when this query was made






## DELETE Account number

```shell
curl -X DELETE https://api.highline.co/users/c8e1f36e-c4.../bank_accounts/f6e1645-fc56... \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
```

> <div class="code-block-title">Response</div>

```json
{
  "success": true
}
```

This API will delete a user's bank account.

### HTTP Request

`DELETE https://api.highline.co/users/{id}/bank_accounts/{bank_account_id}/account_number`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id
`bank_account_id` *required* | string | path | Bank account id
