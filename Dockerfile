FROM openjdk:17-slim
WORKDIR /app
COPY target/spring-devops-app-1.0.0.jar app.jar
EXPOSE 8888
ENTRYPOINT ["java", "-jar", "app.jar"]
