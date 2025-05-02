# Use official Playwright image (no system dependencies needed)
FROM mcr.microsoft.com/playwright:v1.42.1-jammy

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["npx", "playwright", "test"]