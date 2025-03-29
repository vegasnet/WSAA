# Definición de los ARG antes de su uso
ARG time_expiration_token=4
ARG service_=wsfe
ARG endpoint_="https://wsaahomo.afip.gov.ar/ws/services/LoginCms?wsdl"
ARG keystore_="certs/private/ARStore.p12"
ARG keystore_signer=sapqa
ARG pathCache=cacheToken/tokenCache.db

# Build Stage
FROM maven:3.8.6-jdk-11-slim AS builder
# FROM maven:3.8.8-eclipse-temurin-8 AS builder
WORKDIR /WSAA
# Copiar archivos del proyecto
COPY pom.xml .
COPY src ./src
# Copiar carpetas necesarias
COPY cacheToken ./cacheToken
COPY certs ./certs
# Construir la aplicación
RUN mvn clean package -DskipTests

# Production Stage
#FROM eclipse-temurin:8-jdk
FROM amazoncorretto:11-alpine-jdk
WORKDIR /appWSAA
# Establecer la zona horaria
ENV TZ=America/Santiago

# Pasar los ARG como variables de entorno antes de usarlas
ARG time_expiration_token
ARG service_
ARG endpoint_
ARG keystore_
ARG keystore_signer
ARG pathCache

# Copiar el JAR desde la etapa de construcción
COPY --from=builder /WSAA/target/*.jar WSAA.jar

# Copiar las carpetas necesarias
COPY --from=builder /WSAA/cacheToken /appWSAA/cacheToken
COPY --from=builder /WSAA/certs /appWSAA/certs

# Pasar los ARG como variables de entorno
ENV TIME_EXPIRATION_TOKEN=${time_expiration_token}
ENV SERVICE=${service_}
ENV ENDPOINT=${endpoint_}
ENV KEYSTORE=${keystore_}
ENV KEYSTORE_SIGNER=${keystore_signer}
ENV PATH_CACHE=${pathCache}

# Exponer el puerto
EXPOSE 8080

# Ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "WSAA.jar"]
