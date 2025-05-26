const { resolve } = require("path");

module.exports = {
  projectConfig: {
    database_url: process.env.DATABASE_URL,
    database_type: "postgres",
    redis_url: process.env.REDIS_URL,
    store_cors: process.env.STORE_CORS ? process.env.STORE_CORS.split(",") : [],
    admin_cors: process.env.ADMIN_CORS ? process.env.ADMIN_CORS.split(",") : [],
    jwt_secret: process.env.JWT_SECRET,
    cookie_secret: process.env.COOKIE_SECRET,
  },
  plugins: [],
  modules: {
    // 默认模块配置
    eventBus: {
      resolve: "@medusajs/event-bus-redis",
      options: {
        redisUrl: process.env.REDIS_URL
      }
    },
    cacheService: {
      resolve: "@medusajs/cache-redis",
      options: {
        redisUrl: process.env.REDIS_URL
      }
    }
  }
}; 