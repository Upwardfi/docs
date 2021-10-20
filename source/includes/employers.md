# Employers

## Check if employer is supported

```shell
curl -X GET http://api.highline.co/employers?q=Kroger \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[
  {
    "id": "25de3...",
    "name_hash": "bd545...",
    "name": "Kroger",
    "type": "retail",
    "has_two_fa": false,
    "api_supported": true,
    "can_edit_allocations": false,
    "max_number_of_allocations": 5,
    "exclude_employer_enabled": false,
    "created_at": 1633824000,
    "updated_at": 1634428800
  }
]
```

This API checks if user's employer is supported through Highline and will return success or failure based on eligibility.

`GET http://api.highline.co/employers`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`q` *required* | string | query | Employer name

### Response

Array of Employers Data that match query