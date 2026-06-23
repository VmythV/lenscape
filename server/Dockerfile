# 多阶段构建：编译 TypeScript → 仅带生产依赖运行
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY tsconfig.json ./
COPY src ./src
RUN npm run build

FROM node:20-alpine AS runtime
ENV NODE_ENV=production
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force
COPY --from=build /app/dist ./dist

# 无状态服务，默认监听 8787（见 docs/architecture.md §9）
EXPOSE 8787
USER node
CMD ["node", "dist/index.js"]
