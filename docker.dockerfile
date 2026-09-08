FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    ca-certificates \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# Download Godot Headless Server
ENV GODOT_VERSION=4.2.2
RUN wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && mv Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot \
    && rm Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip

WORKDIR /app
COPY . .

# Run Godot in headless mode
CMD ["godot", "--headless", "--main-pack", "project.godot"]