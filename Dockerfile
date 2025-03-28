# Etapa de compilación con Maven y Java 8
FROM maven:3.8.8-eclipse-temurin-8 AS builder
WORKDIR /WSAA

# Copiar archivos del proyecto (pom.xml y src)
COPY pom.xml .
COPY src ./src

# Copiar otras carpetas necesarias (cacheToken y certs)
COPY cacheToken ./cacheToken
COPY certs ./certs

# Construir la aplicación (sin tests)
RUN mvn clean package -DskipTests

# Etapa de producción con Java 8
FROM eclipse-temurin:8-jdk
WORKDIR /appWSAA

# Configurar zona horaria
ENV TZ=America/Santiago

# Copiar el archivo JAR desde la etapa de compilación
COPY --from=builder /WSAA/target/*.jar WSAA.jar

# Copiar las carpetas necesarias para la aplicación
COPY --from=builder /WSAA/cacheToken /appWSAA/cacheToken
COPY --from=builder /WSAA/certs /appWSAA/certs

# Exponer el puerto 8080
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "WSAA.jar"]
