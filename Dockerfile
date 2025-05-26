FROM node:20-slim AS builder
WORKDIR /app

# 1. 安装依赖
COPY package.json yarn.lock* ./
RUN --mount=type=cache,target=/usr/local/share/.cache/yarn/v6 \
    yarn install --frozen-lockfile

# 2. 拷贝源码
COPY . .

# 3. 使用npx构建
RUN --mount=type=cache,target=/app/node_modules/.cache \
    npx medusa build

# 生产阶段
FROM node:20-slim
WORKDIR /app

# 只复制生产所需文件
COPY --from=builder /app/package.json ./
COPY --from=builder /app/yarn.lock ./
RUN --mount=type=cache,target=/usr/local/share/.cache/yarn/v6 \
    yarn install --production --frozen-lockfile

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules/.bin ./node_modules/.bin

EXPOSE 9000
CMD ["npx", "medusa", "start"] 