# Use Ubuntu 20.04 LTS as base image
FROM ubuntu:20.04

# Set non-interactive frontend (avoid debconf warnings)
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    curl git wget unzip \
    libgconf-2-4 gdb libstdc++6 libglu1-mesa \
    fonts-droid-fallback python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for Flutter
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# Install Flutter
RUN git clone --branch stable https://github.com/flutter/flutter.git /usr/local/flutter

# Add Flutter to PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Create a non-root user and change ownership of relevant directories
RUN useradd -ms /bin/bash flutteruser \
    && chown -R flutteruser:flutteruser /usr/local/flutter

# Switch to non-root user
USER flutteruser

# Set working directory
WORKDIR /app

# Run initial Flutter commands
RUN flutter doctor 

RUN flutter config --enable-web


# Copy application code (assumed to be in the same directory as Dockerfile)
COPY --chown=flutteruser:flutteruser . .

# Build the Flutter web application
RUN flutter build web

# Expose port 9000 for the web server
EXPOSE 9000

# Make the server startup script executable
RUN chmod +x /app/server/server.sh

# Set the entrypoint to run the server
ENTRYPOINT ["/app/server/server.sh"]
