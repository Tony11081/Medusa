const { resolve } = require("path");

module.exports = {
  projectConfig: {
    redis_url: process.env.REDIS_URL || "redis://redis:6379",
    database_url: process.env.DATABASE_URL,
    database_type: "postgres",
    store_cors: process.env.STORE_CORS ? process.env.STORE_CORS.split(",") : ["*"],
    admin_cors: process.env.ADMIN_CORS ? process.env.ADMIN_CORS.split(",") : ["*"],
    jwt_secret: process.env.JWT_SECRET || "super-secret-jwt",
    cookie_secret: process.env.COOKIE_SECRET || "super-secret-cookie",
  },
  plugins: [],
  modules: {
    // 默认模块配置
    eventBus: {
      resolve: "@medusajs/event-bus-redis",
      options: {
        redisUrl: process.env.REDIS_URL || "redis://redis:6379"
      }
    },
    cacheService: {
      resolve: "@medusajs/cache-redis",
      options: {
        redisUrl: process.env.REDIS_URL || "redis://redis:6379"
      }
    }
  }
}; 