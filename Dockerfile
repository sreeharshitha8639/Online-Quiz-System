# Stage 1: Build
FROM maven:3.9.0-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run with Tomcat (Servlet project needs Tomcat)
FROM tomcat:10.1-jdk17-temurin-alpine
WORKDIR /usr/local/tomcat/webapps/
COPY --from=build /app/target/QuizOnlineSystem-0.0.1-SNAPSHOT.war ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]