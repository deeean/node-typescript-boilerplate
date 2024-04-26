FROM node:20 as builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --production --frozen-lockfile

COPY . .

FROM gcr.io/distroless/nodejs20-debian12

COPY --from=builder /app /app

WORKDIR /app

CMD ["./node_modules/.bin/tsx", "--no-warnings", "./src/index.ts"]
