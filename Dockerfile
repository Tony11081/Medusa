FROM node:20-slim AS builder
WORKDIR /app

# 1. 安装依赖
COPY package.json yarn.lock* ./
RUN yarn install --frozen-lockfile

# 2. 拷贝源码
COPY . .

# 3. 修复权限问题
RUN chmod +x /app/node_modules/.bin/medusa \
    && ln -s /app/node_modules/.bin/medusa /usr/local/bin/medusa

# 4. 构建
RUN yarn build

# 生产阶段
FROM node:20-slim
WORKDIR /app

# 只复制生产所需文件
COPY --from=builder /app/package.json ./
COPY --from=builder /app/yarn.lock ./
RUN yarn install --production --frozen-lockfile

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules/.bin ./node_modules/.bin

# 确保medusa命令有执行权限并添加到PATH
RUN chmod +x ./node_modules/.bin/medusa \
    && ln -s /app/node_modules/.bin/medusa /usr/local/bin/medusa

EXPOSE 9000
CMD ["yarn", "start"] 