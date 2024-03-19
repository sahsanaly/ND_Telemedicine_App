FROM maven:3.6.3-jdk-11-openj9

WORKDIR /booking

COPY . .

RUN mvn clean compile

CMD mvn spring-boot:run