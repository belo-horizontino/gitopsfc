# Etapa de build
FROM golang:1.19 AS build
WORKDIR /app
COPY go.mod ./
COPY main.go ./
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server

# Etapa final
FROM scratch
WORKDIR /app
COPY --from=build /app/server .
#EXPOSE 8080
ENTRYPOINT ["./server"]


