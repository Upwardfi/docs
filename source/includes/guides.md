# Guides

## Direct Deposit Switch

Direct Deposit Switch functionality allows individual users to change the primary destination of their paycheck distribution to a bank account specified by your application. After a successful direct deposit switch, all future paychecks on behalf of the employer will push directly into the new listed bank account.

Our significant footprint of API connections provides immediate access to this functionality for a majority of the workforce through Highline.

The deposit switch functionality is packaged as a simple, streamlined experience for developers and users. For your users, it’s practically as simple. With just a few clicks and without leaving your platform, they can authorize a direct deposit switch to your bank account.

Direct deposit switch implementation steps to get you up and running.

### Step 1 - Get an access token

```shell
curl -X POST http://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET"
  }'
```

> Response:

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

To initiate a payroll connection session, you will need your API Key and Secret from the Highline Dashboard to request an `access_token.` An AccessToken for the end user is required to initialize Highline link `Connect`. To retrieve the AccessToken, make the following HTTP request on your server.

`POST http://api.highline.co/auth/token`

### Step 2 - Encrypt the bank details


```shell
curl -X POST http://api.highline.co/link/encrypt \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "bank_account": {
      "bank_name": "New Bank",
      "account_type": "checking",
      "routing_number": "XXXXXXXXX",
      "account_number": "XXXXXXXXXX"
    }
  }'
```

> Response:

```json
{
 "payload": "encrypted_value",
}
```

The encryption is necessary to ensure your bank account details are never exposed on the front-end. To encrypt your bank account details, make the following HTTP request from your server.

`POST http://api.highline.co/link/encrypt`

### Step 3 - Connect and open Highline-link

> Highlink Link Snippet

```javascript
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        feature: 'direct_deposit_switch',
        payload: 'encrypted_value'
    });
    highlineLink.open();
```

Highline's link is a front-end UI element that allows users to grant your application access to their work accounts and set up direct deposit switch

Parameter | Type | Description
--------- | ------- | -----------
`access_token` *required* | string | Value from the '/auth/token' endpoint
`feature` *required* | string | 'direct_deposit_switch'
`payload` *optional* | string | Encrypted value from the '/link/encrypt' endpoint - *required* for 'direct_deposit_switch' feature

## Payment via Payroll

Highline’s Payment via Payroll functionality automates and simplifies your customers' bill payments by allowing them to make payments directly from payroll. Once the bill payment is setup, the recurring monthly payment amount will be automatically debited from their paychecks.

This section will help you understand how to implement Highline bill payments in a few simple steps.

### Step 1 - Get an access token

```shell
curl -X POST http://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET"
  }'
```

> Response:

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

To initiate a payroll payment session, you will need your API Key and Secret from the Highline Dashboard to request an `access_token.` An AccessToken for the end user is required to initialize Highline link `Connect`. To retrieve the AccessToken, make the following HTTP request on your server.

`POST http://api.highline.co/auth/token`

### Step 2 - Create an enrollment

To enroll a user for bill payments via payroll, you need to create an enrollment. An enrollment contains the metadata for a given recurring bill processed by Highline payments.

```shell
curl -X POST http://api.highline.co/enrollments \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
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
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "application_reference_number": "16576AB",
  "status": "new",
  "created_at": 1634741667,
  "updated_at": 1634741667
}
```

Parameter | Type | Description
--------- | ------- | -----------
`access_token` *required* | string | Value from the '/auth/token' endpoint
`product_id` *required* | string | available in Highline dashboard
`payment_amount` *required* | string | monthly recurring payment amount
`payment_frequency` *required* | string | payment frequency, we only support 'monthly' bill payment frequency
`first_payment_date` *required* | unix timestamp | the bill payment due date
`application_reference_number` *optional* | string | the resource identifier in your application


### Step 3 - Connect and open Highline-Link

> Highlink Link Snippet

```javascript
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        feature: 'direct_deposit_payment',
        enrollment_id: 'id_from_enrollments_api'
    });
    highlineLink.open();
```

Highline's link is a front-end UI element that allows users to grant your application access to their work accounts and set up payment via payroll

Parameter | Type | Description
--------- | ------- | -----------
`access_token` *required* | string | Value from the '/auth/token' endpoint
`feature` *required* | string | 'direct_deposit_payment'
`enrollment_id` *required* | string | The enrollment_id from the previous step

## Employment Data

Highline can also be used to verify the employment data of individual users. Our integrations within the payroll ecosystem helps us provide access to a user’s employment data from a single payroll sign-on.

Using this service allows users to login and confirm data sharing with a single click. These users also never leave your website. This means that as opposed to traditional methods like uploading paystubs or a copy of photo identification, your users will have a simple single login and be able to complete their journey with less friction and confusion.

### Step 1 - Get an access token

```shell
curl -X POST http://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET"
  }'
```

> Response:

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

To initiate a employment data session, you will need your API Key and Secret from the Highline Dashboard to request an `access_token.` An AccessToken for the end user is required to initialize Highline link `Connect`. To retrieve the AccessToken, make the following HTTP request on your server.

`POST http://api.highline.co/auth/token`

### Step 2 - Connect and open Highline-Link

> Highlink Link Snippet

```javascript
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        feature: 'employment_data'
    });
    highlineLink.open();
```

Highline's link is a front-end UI element that allows users to grant your application access to their work accounts and share employment data

Parameter | Type | Description
--------- | ------- | -----------
`access_token` *required* | string | Value from the '/auth/token' endpoint
`feature` *required* | string | 'employment_data'
