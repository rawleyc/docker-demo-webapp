FROM golang:1.24-alpine AS build

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o webapp .

FROM alpine:3.8

WORKDIR /web

COPY --from=build /app/webapp /usr/bin/webapp
COPY index.html /web/static/index.html

EXPOSE 3000

ENTRYPOINT ["/usr/bin/webapp"]
