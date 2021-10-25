# Client SDK

## Widget Installation

```javascript
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
</head>
<body>
  <highline-link></highline-link>
  <script src="https://link.highline.co/v1/highline-link.js"></script>
  <script type="text/javascript">
    highlineLink.connect({
        access_token: 'value_from_auth_token_api',
        feature: 'direct_deposit_switch'
        payload: 'value_from_link_encrypt_api',
        on_close: () => {
          console.log('on_close!');
        },
        on_error: () => {
          console.log('on_error!');
        },
        on_success: ({ user_id }) => {
          console.log('on_success! ' + user_id);
        }
    });
    highlineLink.open();
  </script>
</body>
</html>
```

In order to ensure a simple and delightful experience for customers, we offer an integrated widget.

Highline's widget is a front-end UI element that allows users to grant your application access to their work accounts, set up automated payments, and switch deposits directly from their paychecks.

To use Highline-Link, pass in an object with the parameters described below to the  
`highlineLink.connect()` function:

Parameter | Type | Description
--------- | ------- | -----------
`access_token` *required* | string | Value from the '/auth/token' endpoint
`feature` *required* | string | 'employment_data', 'direct_deposit_payment', or 'direct_deposit_switch'
`enrollment_id` *optional* | string | Value from the '/enrollments' endpoint - *required* for 'direct_deposit_payment' feature
`payload` *optional* | string | Encrypted value from the '/link/encrypt' endpoint - *required* for 'direct_deposit_switch' feature
`on_success` *optional* | function | Callback function for success events.  Returns 'user_id' which can be used to fetch users' payroll information.
`on_error` *optional* | function | Callback function for error events.  Returns error 'message' when applicable and can be used to handle errors.
`on_close` *optional* | function | Callback function for close events.  Can be used to detect when a user closes the widget.


And then open with highlineLink.open()
