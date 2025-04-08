ARG time_expiration_token=4
ARG service_=wsfe
ARG endpoint_="https://wsaahomo.afip.gov.ar/ws/services/LoginCms?wsdl"
ARG keystore_="certs/private/ARStore.p12"
ARG keystore_signer=sapqa
ARG pathCache=cacheToken/tokenCache.db

FROM maven:3.8.6-jdk-11-slim AS builder
# FROM maven:3.8.8-eclipse-temurin-8 AS builder
WORKDIR /WSAA

COPY pom.xml .
COPY src ./src

COPY cacheToken ./cacheToken
COPY certs ./certs

RUN mvn clean package -DskipTests

#FROM eclipse-temurin:8-jdk
FROM amazoncorretto:11-alpine-jdk
WORKDIR /appWSAA

ENV TZ=America/Santiago

ARG time_expiration_token
ARG service_
ARG endpoint_
ARG keystore_
ARG keystore_signer
ARG pathCache

COPY --from=builder /WSAA/target/*.jar WSAA.jar
COPY --from=builder /WSAA/cacheToken /appWSAA/cacheToken
COPY --from=builder /WSAA/certs /appWSAA/certs

ENV TIME_EXPIRATION_TOKEN=${time_expiration_token}
ENV SERVICE=${service_}
ENV ENDPOINT=${endpoint_}
ENV KEYSTORE=${keystore_}
ENV KEYSTORE_SIGNER=${keystore_signer}
ENV PATH_CACHE=${pathCache}

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "WSAA.jar"]
