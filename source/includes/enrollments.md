# Enrollments

An Enrollment is created to initiate the set up of a recurring bill payment on Highline's payments network. Enrollment is only required for pay via payroll use cases and is not needed for deposit switch or payroll data access use cases.

You first create an enrollment with the recurring amount, bill payment date, payment frequency, along with other optional fields. Multiple users should be submitted if your account has multiple primary owners.

## Create user enrollment

```shell
curl -X POST https://api.highline.co/enrollments \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "users": [{
      "id": "1324defc-a8e..."
    }],
    "product_id": "6351fsd6fs-sdfs...",
    "payment_amount": 20000,
    "payment_frequency": "monthly",
    "first_payment_date": 1634740754,
    "client_reference_id": "XUZ456ERT",
    "end_date": 1634840654
  }'
```

> Response

```json
{
  "id": "DVNA4...",
  "users": [
    {
      "id": "d134c.....",
      "first_name": "John",
      "last_name": "Smith",
      "email": "john.smith143@highline.co",
      "created_at": 1634744601,
      "updated_at": 1634744601,
    }
  ],
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "client_reference_id": "XUZ456ERT",
  "status": "new",
  "created_at": 1634741667,
  "updated_at": 1634741667
}
```

This API initiates user enrollment via Highline. By passing basic enrollment information Highline will return an object to the enrollment.

### HTTP Request

`POST https://api.highline.co/enrollments`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`product_id` | string | body | Product ID, available in the product settings page
`payment_amount` | int | body | Recurring amount to be paid to you by the user (in cents)
`payment_frequency` | string | body | Frequency interval that user will make payments ("weekly" "bi-weekly" "semi-monthly" "bi-weekly")
`first_payment_date` | timestamp | body | Date of first payment as Unix timestamp
`client_reference_id` *optional* | string | body | The application ID or account ID on your system.
`end_date` *optional* | int | Date when we stop accepting payments for this enrollment

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns enrollment id.
`users` | array | Returns array of users.
`product_id` | string | product id.
`payment_amount` | int | Recurring amount to be paid to you by the user (in cents)
`payment_frequency` | string | Frequency interval that user will make payments
`first_payment_date` | timestamp | Date of first payment as Unix timestamp
`client_reference_id`| string | The application ID or account ID on your system.
`end_date` *optional* | int | Date when we stop accepting payments for this enrollment
`status` | string | Enrollment status
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update

## Get enrollment

```shell
curl -X GET https://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
{
  "id": "DVNA...",
  "users": [
    {
      "id": "d134c608-5a...",
      "first_name": "John",
      "last_name": "Smith",
      "ssn": "123456516",
      "email": "john.smith143@highline.co",
      "created_at": 1634744601,
      "updated_at": 1634744601,
    }
  ],
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "client_reference_id": "XUZ456ERT",
  "end_date": 1634840654,
  "status": "new",
  "status_description": "",
  "created_at": 1634741667,
  "updated_at": 1634744602
}
```

This API endpoint returns an enrollment based on the provided enrollment ID.

### HTTP Request

`GET https://api.highline.co/enrollments/{id}`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | path | Enrollment id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns enrollment id.
`users` | array | Returns array of users.
`product_id` | string | product id.
`payment_amount` | int | Recurring amount to be paid to you by the user (in cents)
`payment_frequency` | string | Frequency interval that user will make payments
`first_payment_date` | timestamp | Date of first payment as Unix timestamp
`client_reference_id`| string | The application ID or account ID on your system
`end_date` *optional* | int | Date when we stop accepting payments for this enrollment
`status` | string | Enrollment status
`status_description` | string | Description of status
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update

## Get enrolled users

```shell
curl -X GET https://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
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
}]
```


This API endpoint returns users that are enrolled based on the provided enrollment id.

### HTTP Request

`GET https://api.highline.co/enrollments/{id}/users`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | path | Enrollment id

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
