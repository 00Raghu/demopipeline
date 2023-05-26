FROM maven as biuld
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=biuld /app/target/Uber.jar /app/
EXPOSE 9090
CMD [ "java", "-jar", "Uber.jar" ]
 
