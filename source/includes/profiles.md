# Profiles

## Get User's profile

```shell
curl -X GET https://api.highline.co/users/BGMXJzGzJcht38SCJuMhzF \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> <div class="code-block-title">Response</div>

```json
  {
    "id": "d134c.....",
    "first_name": "John",
    "last_name": "Smith",
    "ssn": "1234...",
    "address": {
      "id": 27,
      "user_id": "d134c.....",
      "line_1": "4194 Autry Lane",
      "line_2": "",
      "city": "Dallas",
      "state": "TX",
      "zip_code": "75001",
      "country": "US"
    },
    "email": "john.smith143@highline.co",
    "created_at": 1634744601,
    "updated_at": 1634744601,
  }
```

This API endpoint returns the user's profile based on the provided user id.

`GET https://api.highline.co/users/{id}`

### Parameters

Name | Type | In | Description
--------- | ------- | ------- | ------
`id` *required* | string | path | User id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns user id.
`first_name` | string | First Name
`last_name` | string | Last Name
`ssn` | string | Social security number
`address` | json | Address object  
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update

### Address Object

A user's address is represented by another JSON object nested inside the User's JSON object.

Parameter | Type | Description
----------|----------|---------
`id` | uint | Address id
`user_id` | string | User id associated with address
`line_1` | string | Line 1 Street address
`line_2` | string | Line 2 Street address
`city` | string | City
`state` | string | State
`zip_code` | string | Zip code
`country` | string | Country
