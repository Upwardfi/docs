# Employers

## Check if employer is supported

```shell
curl -X GET https://api.highline.co/employers?q=Kroger \
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
To be eligible, customers must be gainfully employed with a trusted employer.

We also require these employers, and their subsequent payroll providers, to be integrated with Highline. This allow us to properly allocate a portion of the paycheck towards bill payments.

This API checks if user's employer is supported through Highline and will return success or failure based on eligibility.

`GET https://api.highline.co/employers`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`q` *required* | string | query | Employer name

### Response

Array of Employers Data that match query
