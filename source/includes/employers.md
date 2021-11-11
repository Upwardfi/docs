# Employers

## Check if employer is supported

```shell
curl -X GET https://api.highline.co/employers?q=Kroger \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> <div class="code-block-title">Response</div>

```json
[
  {
    "id": "25de3...",
    "name": "Kroger",
    "type": "retail",
    "payroll_data_supported": true,
    "payroll_payments_supported": false,
    "created_at": 1633824000,
    "updated_at": 1634428800
  }
]

```
Highline supports over half of the US working population, but not everyone. You may optionally query using `https://api.highline.co/employers?q={employer_name}` to ensure if an employer is supported.

Support is often unknown for small businesses, which the customer may still be able to log in by identifying their payroll platform (ADP, Paychex, etc.).

`GET https://api.highline.co/employers`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`q` *required* | string | query | Employer name

### Response

Array of Employers Data that match query

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Employer ID
`name` | string | Employer Name (e.g., Walmart, Uber)
`type` | string | Type of employer (e.g., retail, services, technology)
`payroll_data_supported` | boolean | Employer supports payroll data with Highline APIs
`payroll_payments_supported` | boolean | Employer supports payroll payment method with Highline APIs
