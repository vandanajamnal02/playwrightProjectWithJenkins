# Use official Playwright image v1.52.0
FROM mcr.microsoft.com/playwright:v1.52.0

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Install Playwright browsers
RUN npx playwright install

# Default command to run tests
CMD ["npx", "playwright", "test"]