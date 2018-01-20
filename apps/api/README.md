# Linkin API

**Shortening URL**
----
  Pass the URL to receive the short version.

* **URL**

  /api/shorten

* **Method:**

  `POST`

* **URL Params**

  None

* **Data Params**

  ```javascript
  {
    "url": [String]
  }
  ```

* **Success Response:**

  * **Code:** 201 <br />
    **Content:** <br />
    ```javascript
      {
        "id": 12,
        "long_url": "https://google.com",
        "short_url": "https://linkin-hanami.herokuapp.com/my/b"
      }
    ```

* **Error Response:**

  * **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:** <br />
    ```javascript
      {
        "errors": {
          "url": "Not a valid URL"
        }
      }
    ```

* **Sample Call:**

  ```javascript
    fetch('/api/shorten', {
      headers: new Headers({
        Accept: 'application/json',
        'Content-Type': 'application/json'
      }),
      method: 'POST',
      body: JSON.stringify({ url: url })
    }).then(res => res.json()).
      then(data => {
        // your code here
      });
  ```

**Get a URL stats (and details)**
----
Pass the URL ID to receive its details and stats.

* **URL**

  /api/urls/:id

* **Method:**

  `GET`

* **URL Params**

   **Required:**

   `id=[integer]`

* **Data Params**

  None

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** <br />
    ```javascript
      {
        "id": 12,
        "long_url": "https://google.com",
        "short_url": "https://linkin-hanami.herokuapp.com/my/b",
        "clicks": [
          {
            // all timestamps are in UTC
            "timestamp": "2018-01-20 08:00:30 UTC",
            // ::1 usually indicates localhost
            "ip": "219.75.53.61" || "::1",
            "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) ...",
            // Referer can be null if the user just type the shortened URL
            // or open in another tab/window
            "referer": null || "https://linkin-hanami.herokuapp.com",
          },
          // the rest of the click data
          ...
        ]
      }
    ```

* **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** <br />
    ```javascript
      {
        "errors": "Could not find the URL"
      }
    ```

* **Sample Call:**

  ```javascript
    fetch('/api/urls/1', {
      headers: new Headers({
        Accept: 'application/json',
        'Content-Type': 'application/json'
      }),
      method: 'GET',
    }).then(res => res.json()).
      then(data => {
        // your code here
      });
  ```
