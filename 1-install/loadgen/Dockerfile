# build stage
FROM golang as builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o loadgen .



# final stage - DO NOT USE SCRATCH. CLIENT CERT ISSUES!!!
FROM golang
COPY --from=builder /app/loadgen /app/
ENTRYPOINT ["/app/loadgen"]