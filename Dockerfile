# Use Eclipse Temurin 11 as the base image
FROM eclipse-temurin:11

# Install necessary utilities: curl, unzip, zip, and inotify-tools
RUN apt-get update && apt-get install -y curl unzip zip inotify-tools

# Install SDKMAN (Software Development Kit Manager)
RUN curl -s "https://get.sdkman.io" | bash

# Install Kotlin using SDKMAN and add to PATH
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install kotlin"
ENV PATH="/root/.sdkman/candidates/kotlin/current/bin:${PATH}"

RUN mkdir /app
COPY ./kotlin-hello-world /app
WORKDIR /app

# Compile Kotlin application during image build
RUN kotlinc HelloWorld.kt -include-runtime -d HelloWorld.jar
RUN chmod +x HelloWorld.jar

# Set the CMD to execute the compiled JAR
CMD ["java", "-jar", "HelloWorld.jar"]

