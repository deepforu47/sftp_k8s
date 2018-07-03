FROM maven:3.5.3-jdk-8 as build
WORKDIR /build
COPY . ./
RUN mvn package 

FROM openjdk:8-jdk-alpine
COPY --from=build /build/target/*.jar /app/app.jar
ENTRYPOINT ["java", "-jar","/app/app.jar"]
