# Use base Ubuntu image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_VERSION=20

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl wget gnupg ca-certificates git \
    fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 \
    libcups2 libdbus-1-3 libgdk-pixbuf2.0-0 libnspr4 libnss3 \
    libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 \
    libgbm1 libgtk-3-0 libxss1 libxshmfence1 libxext6 libxfixes3 \
    libglib2.0-0 libudev1 libwebp6 libjpeg8 libffi7 \
    xvfb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the project
COPY . .

# Install Playwright browsers (headless dependencies)
RUN npx playwright install --with-deps

# Optional: expose test report if needed
EXPOSE 9323

# Default test command (can be overridden)
CMD ["npx", "playwright", "test"]

