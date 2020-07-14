This is two in one docker image so it runs open source virus scanner ClamAV
(https://www.clamav.net/), automatic virus definition updates as background
process and REST api interface to interact with ClamAV process.

## Configuration

- `API_USERNAME`: The username of the api in plaintext
- `API_PASSWORD`: The password of the api in plaintext

## Usage:

#### Run clamav-rest docker image:

```bash
docker run -p 3000:3000 -e API_USERNAME=username -e API_PASSWORD=password verumex/clamav-microservice
```

#### Test that service detects common test virus signature:

```bash
$ curl -i -u username:password -F "file=@eicar.txt" http://localhost:9000/scan
HTTP/1.1 200 OK
Content-Type: application/json
Server: WEBrick/1.6.0 (Ruby/2.7.1/2020-03-31)
Date: Wed, 1 Jul 2020 08:04:33 GMT
Content-Length: 14
Connection: Keep-Alive

{"safe":false}
```

The EICAR files can be downloaded [here](https://www.eicar.org/?page_id=3950)

#### Test that service returns 200 for clean file:

```bash
$ curl -i -u username:password -F "file=@safe_file.txt" http://localhost:9000/scan
HTTP/1.1 200 OK
Content-Type: application/json
Server: WEBrick/1.6.0 (Ruby/2.7.1/2020-03-31)
Date: Tue, 14 Jul 2020 08:06:13 GMT
Content-Length: 13
Connection: Keep-Alive

{"safe":true}
```

#### **Status codes:**

- 200 - Scan complete. See [Usage](#usage) for details of scan result
- 401 - Unauthorized. Invalid username or password
- 422 - Scan error due to malformed POST data

## Developing:

```bash
docker build . -t verumex/clamav-microservice
docker run -p 3000:3000 --rm -it -e API_USERNAME=username -e API_PASSWORD=password verumex/clamav-microservice
```
