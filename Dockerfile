FROM bitnami/java:1.8
WORKDIR /app
COPY target/project-1.0.1.war app.jar
EXPOSE 8082
CMD ["java", "-jar", "app.jar"]
