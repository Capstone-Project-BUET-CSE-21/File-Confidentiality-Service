# Multi-Stage Build for Spring Boot Application on Render
# Stage 1: Build Stage
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /build

# Copy pom.xml first to leverage Docker layer caching for dependencies
COPY file-sharing/pom.xml .

# Download dependencies (this layer will be cached if pom.xml doesn't change)
RUN mvn dependency:go-offline -B

# Copy the entire source code after dependencies are cached
COPY file-sharing/src src

# Build the application, skipping tests to speed up the process
RUN mvn clean package -DskipTests -q

# Stage 2: Runtime Stage
FROM eclipse-temurin:21-jre

# Set working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /build/target/file-sharing-1.0.0.jar app.jar

# Set environment variables
ENV PORT=8082
EXPOSE 8082

# Run the application with memory optimization and dynamic port binding
ENTRYPOINT ["sh", "-c", "java -Xmx512m -Dserver.port=${PORT:-8082} -jar app.jar"]
