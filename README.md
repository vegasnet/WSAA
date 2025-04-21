# AFIP authentication

# Description
This Java service allows you to generate a token based on a configurable time range. It uses a time window for token validity, ensuring that if the service is invoked within the validity period, the same token is returned. However, if the time window expires, a new token must be generated.

# Clone the Repository
First, clone the repository to your local machine:
git clone https://github.com/vegasnet/WSAA

# Run Containers with Docker Composer
Download, install, and run Docker (https://docs.docker.com/desktop/setup/install/windows-install/)
This project is configured to run with Docker and Docker Compose.
This command will build Docker container images and start them:
docker-compose up --build

# Parameters
Each of these parameters can be configured when building the Docker image:
- **time_expiration_token**: Defines the token expiration time in hours, for example: 35min -> 35/60=0.5833
- **service_**: The service identifier.
- **endpoint_**: The endpoint URL or configuration.
- **keystore_**: Path to the keystore file.
- **keystore_signer**: The signer used for keystore operations.
- **pathCache**: Directory where cached files are stored.

# Docker constructor example for parameters:
builder

docker buildx build --no-cache --build-arg time_expiration_token=5 --build-arg service_=wsfe --build-arg endpoint_="https://wsaahomo.afip.gov.ar/ws/services/LoginCms?wsdl" --build-arg keystore_="certs/private/ARStore.p12" --build-arg keystore_signer="sapqa" --build-arg pathCache="cacheToken/tokenCache.db" -t wsaa . 
# after
docker run --name wsaa_container -p 8080:8080 -d wsaa

# API GET: http://localhost:8080/api/arca/wssa

# Example response
"token": "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n<loginTicketResponse version=\"1.0\">\n    <header>\n        <source>CN=wsaahomo, O=AFIP, C=AR, SERIALNUMBER=CUIT 33693450239</source>\n        <destination>SERIALNUMBER=CUIT 20255676793, CN=sapqa</destination>\n        <uniqueId>4186733962</uniqueId>\n        <generationTime>2025-04-08T15:02:57.444-03:00</generationTime>\n        <expirationTime>2025-04-09T03:02:57.444-03:00</expirationTime>\n    </header>\n    <credentials>\n        <token>PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8c3NvIHZlcnNpb249IjIuMCI+CiAgICA8aWQgc3JjPSJDTj13c2FhaG9tbywgTz1BRklQLCBDPUFSLCBTRVJJQUxOVU1CRVI9Q1VJVCAzMzY5MzQ1MDIzOSIgZHN0PSJDTj13c2ZlLCBPPUFGSVAsIEM9QVIiIHVuaXF1ZV9pZD0iNDEzNzQwMDc2MSIgZ2VuX3RpbWU9IjE3NDQxMzUzMTciIGV4cF90aW1lPSIxNzQ0MTc4NTc3Ii8+CiAgICA8b3BlcmF0aW9uIHR5cGU9ImxvZ2luIiB2YWx1ZT0iZ3JhbnRlZCI+CiAgICAgICAgPGxvZ2luIGVudGl0eT0iMzM2OTM0NTAyMzkiIHNlcnZpY2U9IndzZmUiIHVpZD0iU0VSSUFMTlVNQkVSPUNVSVQgMjAyNTU2NzY3OTMsIENOPXNhcHFhIiBhdXRobWV0aG9kPSJjbXMiIHJlZ21ldGhvZD0iMjIiPgogICAgICAgICAgICA8cmVsYXRpb25zPgogICAgICAgICAgICAgICAgPHJlbGF0aW9uIGtleT0iMzA2ODgzNTkxMjciIHJlbHR5cGU9IjQiLz4KICAgICAgICAgICAgPC9yZWxhdGlvbnM+CiAgICAgICAgPC9sb2dpbj4KICAgIDwvb3BlcmF0aW9uPgo8L3Nzbz4K</token>\n        <sign>M4pRM+DukiRBWrX5KpXcCSnyxjLhEPd4c4Uf/+lJbazsoD5VWMotNoHlHd0hU7WDG2jy5FfaYRlmz7FZcU9yY7xd5ZGrJfpQCHBWUS5fmnzKxNbRdkEDgCdFSpBYv9JplmetOy4N5I9E0AEwqH+ef+oTxNa0AVvT/OY2fUv61hA=</sign>\n    </credentials>\n</loginTicketResponse>\n"
}
