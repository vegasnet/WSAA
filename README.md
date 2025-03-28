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
time_expiration_token
service_
endpoint_
keystore_
keystore_signer
pathCache
# Example:
docker buildx build --build-arg time_expiration_token=4 --build-arg service_=wsfe --build-arg endpoint_="https://wsaahomo.afip.gov.ar/ws/services/LoginCms?wsdl" --build-arg keystore_="certs/private/ARStore.p12" --build-arg keystore_signer="sapqa" --build-arg pathCache="cacheToken/tokenCache.db" -t wsaa .

# API: http://localhost:8080/api/arca/wssa
