FROM node:18-slim
WORKDIR /app

# Install build essentials
RUN apt-get update && apt-get install -y \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY package.json yarn.lock ./
RUN --mount=type=cache,target=/usr/local/share/.cache/yarn/v6 \
    yarn install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN --mount=type=cache,target=/app/node_modules/.cache \
    yarn build

# Expose port
EXPOSE 9000

# Start the application
CMD ["yarn", "start"] 