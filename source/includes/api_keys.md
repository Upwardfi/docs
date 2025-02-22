# API Keys

Highlines's API uses OAuth 2.0 Bearer Token to authenticate requests.

<aside class="notice-container-aside">
    <div class="notice-container">
        <div class="notice-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                <path d="M12 22.5625C6.16649 22.5625 1.4375 17.8335 1.4375 12C1.4375 6.16649 6.16649 1.4375 12 1.4375C17.8335 1.4375 22.5625 6.16649 22.5625 12C22.5625 15.6622 20.6988 18.889 17.8681 20.7838M12 18.8047V9.86719M12 8.03906V6.82031" stroke="#22382E" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
        <div>
            An invalid, missing or expired token will result in HTTP `401` Unauthorized responses.
        </div>
    </div>
</aside>

* All API calls must include a bearer token.
* The API key should be kept confidential and only stored on your own servers.
