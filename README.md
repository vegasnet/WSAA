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
- **time_expiration_token**: Defines the token expiration time.
- **service_**: The service identifier.
- **endpoint_**: The endpoint URL or configuration.
- **keystore_**: Path to the keystore file.
- **keystore_signer**: The signer used for keystore operations.
- **pathCache**: Directory where cached files are stored.

# Example:
docker buildx build --no-cache --build-arg time_expiration_token=4 --build-arg service_=wsfe --build-arg endpoint_="https://wsaahomo.afip.gov.ar/ws/services/LoginCms?wsdl" --build-arg keystore_="certs/private/ARStore.p12" --build-arg keystore_signer="sapqa" --build-arg pathCache="cacheToken/tokenCache.db" -t wsaa . && docker run --name wsaa_container -p 8080:8080 -d wsaa

# API: http://localhost:8080/api/arca/wssa

