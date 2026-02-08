FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY target/spring-devops-app-1.0.1.jar app.jar
EXPOSE 8888
ENTRYPOINT ["java", "-jar", "app.jar"]
