FROM eclipse-temurin:11-jre-alpine

# Here is the path of a jar file on created on jenkins agent. 
ARG artifact=target/spring-boot-web.jar

WORKDIR /opt/app

COPY ${artifact} app.jar

ENTRYPOINT ["java","-jar","app.jar"]
