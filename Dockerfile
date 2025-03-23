# Usa una imagen con Maven para construir el JAR
FROM maven:3.8.6-amazoncorretto-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Usa la imagen ligera para ejecutar el JAR
FROM amazoncorretto:17-alpine-jdk
WORKDIR /app
COPY --from=build /app/target/tablas-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]