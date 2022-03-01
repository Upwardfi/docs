# Guides

## Direct Deposit Switch

Direct Deposit Switch functionality allows individual users to change the primary destination of their paycheck distribution to a bank account specified by your application. After a successful direct deposit switch, all future paychecks on behalf of the employer will push directly into the new listed bank account.

Our significant footprint of API connections provides immediate access to this functionality for a majority of the workforce through Highline.

The deposit switch functionality is packaged as a simple, streamlined experience for developers and users. For your users, it’s practically as simple. With just a few clicks and without leaving your platform, they can authorize a direct deposit switch to your bank account.

Direct deposit switch implementation steps to get you up and running.

### Step 1 - Get an access token

> <div class="code-block-title">Access Token Request</div>

```shell
curl -X POST https://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET"
  }'
```

> <div class="code-block-title">Response</div>

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

To initiate a payroll connection session, you will need your API Key and Secret from the Highline Dashboard to request an `access_token.` An AccessToken for the end user is required to initialize Highline link `Connect`. To retrieve the AccessToken, make the following HTTP request on your server.

`POST https://api.highline.co/auth/token`

### Step 2 - Encrypt the bank details

> <div class="code-block-title margin-top-25">Encrypt Bank Details Request</div>

```shell
curl -X POST https://api.highline.co/link/encrypt \
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

> <div class="code-block-title">Response</div>

```json
{
 "payload": "encrypted_value",
}
```

The encryption is necessary to ensure your bank account details are never exposed on the front-end. To encrypt your bank account details, make the following HTTP request from your server.

`POST https://api.highline.co/link/encrypt`

### Step 3 - Get a public access token

> <div class="code-block-title margin-top-25">Access Token Request</div>

```shell
curl -X POST https://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET",
    "scopes" : ["public"]
  }'
```

> <div class="code-block-title">Response</div>

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

To connect and open Highline-Link, you will need to request a public `access_token.` A public AccessToken is required to initialize Highline link `Connect`. To retrieve the public AccessToken, make the following HTTP request on your server.

`POST https://api.highline.co/auth/token`

### Step 4 - Connect and open Highline-link

> <div class="code-block-title margin-top-25">Highline-Link Snippet</div>

```javascript
highlineLink.connect({
  access_token: 'public_access_token',
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

Highline’s Payment via Payroll functionality automates and simplifies your customers' bill payments by allowing them to make payments directly from payroll. Once the bill payment is set up, the recurring payment amount will be automatically routed from their paychecks to Highline by direct deposit, and then from Highline to you.

This section will help you understand how to implement Highline bill payments in a few simple steps.

### Step 1 - Get an access token

> <div class="code-block-title margin-top-25">Access Token Request</div>

```shell
curl -X POST https://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET"
  }'
```

> <div class="code-block-title">Response</div>

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

To initiate a payroll payment session, you will need your API Key and Secret from the Highline Dashboard to request an `access_token.` An AccessToken for the end user is required to initialize Highline link `Connect`. To retrieve the AccessToken, make the following HTTP request on your server.

`POST https://api.highline.co/auth/token`

### Step 2 - Create an enrollment

> <div class="code-block-title margin-top-25">Create Enrollment Request</div>

To enroll a user for bill payments via payroll, you need to create an enrollment. An enrollment contains the metadata for a given recurring bill processed by Highline payments.

```shell
curl -X POST https://api.highline.co/enrollments \
  -H "Authorization Bearer: AccessToken" \
  -H "Content-Type: application/json" \
  -d $'{
    "product_id": "6351fsd6fs-sdfs...",
    "payment_amount": 20000,
    "payment_frequency": "monthly",
    "first_payment_date": 1634740754,
    "client_reference_id": "16576",
    "end_date": 1634840754
  }'
```

> <div class="code-block-title">Response</div>

```json
{
  "id": "DVNA4...",
  "product_id": "070b8618-7c...",
  "payment_amount": 20000,
  "payment_frequency": "monthly",
  "first_payment_date": 1634740754,
  "client_reference_id": "16576AB",
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
`first_payment_date` *required* | unix timestamp | the first bill payment due date
`end_date` *optional* | int | Date when we stop accepting payments for this enrollment
`client_reference_id` *optional* | string | The application ID or account ID on your system

### Step 3 - Get a public access token

> <div class="code-block-title margin-top-25">Access Token Request</div>

```shell
curl -X POST https://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET",
    "scopes" : ["public"]
  }'
```

> <div class="code-block-title">Response</div>

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

To connect and open Highline-Link, you will need to request a public `access_token.` A public AccessToken is required to initialize Highline link `Connect`. To retrieve the public AccessToken, make the following HTTP request on your server.

`POST https://api.highline.co/auth/token`

### Step 4 - Connect and open Highline-Link

> <div class="code-block-title margin-top-25">Highline-Link Snippet</div>

```javascript
highlineLink.connect({
  access_token: 'public_access_token',
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

> <div class="code-block-title margin-top-25">Access Token Request</div>

```shell
curl -X POST https://api.highline.co/auth/token \
  -H "Content-Type: application/json" \
  -d $'{
    "api_key": "YOUR_API_KEY",
    "secret" : "YOUR_SECRET",
    "scopes" : ["public"]
  }'
```

> <div class="code-block-title">Response</div>

```json
{
  "access_token":"eyJhbGciOiJIUzI...",
  "refresh_token":"eyJhbGciOiJIUz...",
  "subject":"123e4567-e89b-12d3-a456-426614174000",
  "expires_in":1634244444
}
```

A public AccessToken is required to initialize Highline link `Connect`. To retrieve the public AccessToken, make the following HTTP request on your server.

`POST https://api.highline.co/auth/token`

### Step 2 - Connect and open Highline-Link

> <div class="code-block-title margin-top-25">Highline-Link Snippet</div>

```javascript
highlineLink.connect({
  access_token: 'public_access_token',
  feature: 'employment_data'
});
highlineLink.open();
```

Highline's link is a front-end UI element that allows users to grant your application access to their work accounts and share employment data

Parameter | Type | Description
--------- | ------- | -----------
`access_token` *required* | string | Value from the '/auth/token' endpoint
`feature` *required* | string | 'employment_data'
