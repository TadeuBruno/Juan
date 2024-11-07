# Usa uma imagem do JDK 17 para compilar e executar a aplicação
FROM openjdk:21-jdk-slim as build

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Instala o Git e clona o repositório específico
RUN apt-get update && apt-get install -y git maven
RUN git clone https://github.com/lab-invest/back-end-java.git . && git checkout ENTREGA-FINAL && git pull origin ENTREGA-FINAL

# Compila a aplicação Spring Boot com Maven
RUN mvn clean package -DskipTests

# Cria uma nova imagem para execução
FROM openjdk:21-jdk-slim

# Define o diretório de trabalho e copia o JAR da fase de build
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta padrão do Spring Boot (8080)
EXPOSE 8080

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
