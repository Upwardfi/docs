# Direct Deposits

## Get User's direct deposits

```shell
curl -X GET https://api.highline.co/users/6516515-651.../payout_allocations \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "ca71927a-c5...",
  "user_id": "ae16efec-d1...",
  "employment_id": "d6b10b60-55...",
  "bank_account": {
    "id": "4fb1c5dd-5d...",
    "account_number": "***2345",
    "routing_number": "***4321",
    "account_type": "Checking",
    "bank_name": "Wells Fargo",
    "kind": "external"
  },
  "status": "active",
  "created_at": 1633633510,
  "updated_at": 1633633510
}]
```

This API endpoint returns the user's paycheck allocations, that represents direct deposits, based on the provided user id.

`GET https://api.highline.co/users/{id}/payout_allocations`

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
`bank_account` | object | Bank account object
`status` | string | Status of payout allocation ("active" "pending")
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
