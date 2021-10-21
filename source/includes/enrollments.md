# Enrollments

## Create user enrollment

```shell
curl -X POST http://api.highline.co/enrollments \
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
    "application_reference_number": "16576",
    "days_until_expires": 30
  }'
```

> Response

```json
{
  "id": "DVNA4...",
  "users": [
    {
      "id": "d134c.....",
      "provider_user_id": "Argyle",
      "first_name": "John",
      "last_name": "Smith",
      "ssn": "1234...",
      "email": "john.smith143@highline.co",
      "role": "member",
      "ofac_validated": false,
      "created_at": 1634744601,
      "updated_at": 1634744601,
      "social_security_number_hash": "08e3...."
    }
  ],
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "application_reference_number": "16576",
  "days_until_expires": 30,
  "fully_synced": false,
  "status": "new",
  "status_description": "",
  "created_at": 1634741667,
  "updated_at": 1634741667
}
```

This API initiates user enrollment via Highline. By passing basic enrollment information Highline will return an object to the enrollment.

### HTTP Request

`POST http://api.highline.co/enrollments`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`users` | array | body | Array of user objects that contain the member user ID
`product_id` | string | body | Product ID
`payment_amount` | int | body | Recurring amount to be paid to you by the user (in cents)
`payment_frequency` | string | body | Frequency interval that user will make payments ("unknown" "bi-weekly even" "bi-weekly odd" "weekly" "monthly" "semi-monthly")
`first_payment_date` | timestamp | body | Date of first payment as Unix timestamp
`application_reference_number` *optional* | string | body | Loan application number
`days_until_expires` | int | body | Number of days before this enrollment request expires

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns enrollment id.
`users` | array | Returns array of users.
`product_id` | string | product id.
`payment_amount` | int | Recurring amount to be paid to you by the user (in cents)
`payment_frequency` | string | Frequency interval that user will make payments
`first_payment_date` | timestamp | Date of first payment as Unix timestamp
`application_reference_number` | string | Loan application number
`days_until_expires` | int | Number of days before this enrollment request expires
`fully_synced` | bool | 
`status` | string | Enrollment status
`status_description` | string | Description of status
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update


## Add users to enrollments

```shell
curl -X POST http://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "first_name" : "John",
    "last_name" : "Smith",
    "email" : "john.smith13@highline.co",
    "ssn" : "12345...",
    "role" : "member",
    "address" : {
      "id" : 83,
      "line_1" : "4194 Autry Lane",
      "line_2" : "",
      "city" : "Dallas",
      "state" : "TX",
      "zip_code" : "75001",
      "country":"US"
    }
  }'
```

> Response

```json
{
  "id": "d134c.....",
  "provider_user_id": "Argyle",
  "first_name": "John",
  "last_name": "Smith",
  "ssn": "1234...",
  "address": {
    "id": 27,
    "user_id": "d134c.....",
    "company_id": null,
    "line_1": "4194 Autry Lane",
    "line_2": "",
    "city": "Dallas",
    "state": "TX",
    "zip_code": "75001",
    "country": "US"
  },
  "email": "john.smith143@highline.co",
  "role": "member",
  "ofac_validated": false,
  "created_at": 1634744601,
  "updated_at": 1634744601,
  "social_security_number_hash": "08e3...."
}
```

This API endpoint adds a user to the enrollment via Highline. By passing basic user information Highline will return an user object based on the provided enrollment.

### HTTP Request

`POST http://api.highline.co/enrollments/{id}/users`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`email` *required* | string | body | Email id of user
`first_name` *required* |string | body | First Name
`last_name` *required* | string | body | Last Name
`ssn` *required* | string | body | Social Security Number
`address` *required* | json | body | Nested JSON object containing user's address data
`phone` *optional* | string | body | Phone number
`date_of_birth` *optional* | timestamp | body | Date of birth as Unix timestamp

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns user id.
`provider_user_id` | string | ID of employer
`first_name` | string | First Name
`last_name` | string | Last Name
`ssn` | string | Social security number
`address` | json | Address structure  
`role` | string | Member's role 
`ofac_validated` | bool | Ofac validation
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
`social_security_number_hash` | string | SSN hashed


## Get enrollment

```shell
curl -X GET http://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC \
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
      "provider_user_id": "",
      "first_name": "John",
      "last_name": "Smith",
      "ssn": "123456516",
      "email": "john.smith143@highline.co",
      "role": "member",
      "ofac_validated": false,
      "created_at": 1634744601,
      "updated_at": 1634744601,
      "social_security_number_hash": "08e3..."
    }
  ],
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "application_reference_number": "16576",
  "days_until_expires": 30,
  "fully_synced": false,
  "status": "new",
  "status_description": "",
  "created_at": 1634741667,
  "updated_at": 1634744602
}
```

This API endpoint returns enrollment based on the provided enrollment ID.

### HTTP Request

`GET http://api.highline.co/enrollments/{id}`

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
`application_reference_number` | string | Loan application number
`days_until_expires` | int | Number of days before this enrollment request expires
`fully_synced` | bool | 
`status` | string | Enrollment status
`status_description` | string | Description of status
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update

## Get enrolled users

```shell
curl -X GET http://api.highline.co/enrollments/YtMXJzGzJcht38SCJuMhzC/users \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json"
```

> Response

```json
[{
  "id": "d134c.....",
  "provider_user_id": "Argyle",
  "first_name": "John",
  "last_name": "Smith",
  "ssn": "1234...",
  "address": {
    "id": 27,
    "user_id": "d134c.....",
    "company_id": null,
    "line_1": "4194 Autry Lane",
    "line_2": "",
    "city": "Dallas",
    "state": "TX",
    "zip_code": "75001",
    "country": "US"
  },
  "email": "john.smith143@highline.co",
  "role": "member",
  "ofac_validated": false,
  "created_at": 1634744601,
  "updated_at": 1634744601,
  "social_security_number_hash": "08e3...."
}]
```


This API endpoint returns users that are enrolled based on the provided enrollment id.

### HTTP Request

`GET http://api.highline.co/enrollments/{id}/users`

### Parameters

Name | Type | In | Description
--------- | ------- | ------ | --------
`id` *required* | string | path | Enrollment id

### Response

Parameter | Type | Description
--------- | ------- | -----------
`id` | string | Returns user id.
`provider_user_id` | string | ID of employer
`first_name` | string | First Name
`last_name` | string | Last Name
`ssn` | string | Social security number
`address` | json | Address structure  
`role` | string | Member's role 
`ofac_validated` | bool | Ofac validation
`created_at` | timestamp | Date of creation
`updated_at` | timestamp | Date of update
`social_security_number_hash` | string | SSN hashed

