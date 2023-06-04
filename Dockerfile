FROM bitnami/java:1.8
WORKDIR /app
COPY target/project-${BUILD_NUMBER}.war app.jar
EXPOSE 8082
CMD ["java", "-jar", "app.jar"]
