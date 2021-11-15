# Welcome

```shell
https://api.highline.co
```

Welcome to Highline - a seamless integration to setting up automated payments directly from your user's income. You can initiate enrollment by calling Highline's API endpoints and displaying the widget.

This API reference provides information on available endpoints and how to interact with it.

Highline's API is organized around REST. Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. All requests should be over SSL. All request and response bodies, including errors are encoded in JSON.

## Sandbox

Our sandbox environment at `https://sandbox-api.highline.co` provides all the functionality of `https://api.highline.co` with test account credentials. The sandbox API credentials is also available in the product settings page at `https://app.highline.co/manage-product`.

Highline-Link's sandbox url at https://sandbox-link.highline.co/highline-link.js provides all the functionality of https://link.highline.co/v1/highline-link.js with these credentials:

<aside class="notice-container-aside">
    <div class="notice-container">
        <div class="notice-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                <path d="M12 22.5625C6.16649 22.5625 1.4375 17.8335 1.4375 12C1.4375 6.16649 6.16649 1.4375 12 1.4375C17.8335 1.4375 22.5625 6.16649 22.5625 12C22.5625 15.6622 20.6988 18.889 17.8681 20.7838M12 18.8047V9.86719M12 8.03906V6.82031" stroke="#22382E" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
        <div>
           Username is also valid as User ID, Employee ID, etc.
        </div>
    </div>
</aside>

Sandbox User 1 | <span></span>
--------- | -------
Username | test1
Phone number | (800) 900-0001
Password | passgood
SMS Code | 8081
Driver's licence | D1230001

Sandbox User 2 | <span></span>
--------- | -------
Username | test2
Phone number | (800) 900-0002
Password | passgood
SMS Code | 8082
Driver's licence | D1230002

Sandbox User 3 | <span></span>
--------- | -------
Username | test3
Phone number | (800) 900-0003
Password | passgood
SMS Code | 8083
Driver's licence | D1230003
