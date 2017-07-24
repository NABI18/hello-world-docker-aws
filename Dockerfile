FROM openjdk:8-jre
VOLUME /tmp
EXPOSE 8080
ADD /target/hello-world-docker-aws-1.0-SNAPSHOT.jar hello-world-docker-aws.jar
ENTRYPOINT ["java", "-jar", "hello-world-docker-aws.jar"]