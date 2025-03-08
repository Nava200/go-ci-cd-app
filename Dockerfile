# Use the official Go image from Docker Hub as the builder image
FROM golang:1.20-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Modules file and download dependencies
COPY go.mod go.sum ./
RUN go mod tidy

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o go-ci-cd-app main.go

# Start a new stage from a smaller image to reduce image size
FROM alpine:latest

# Install necessary dependencies (for example: ca-certificates)
RUN apk --no-cache add ca-certificates

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the pre-built binary from the builder image
COPY --from=builder /app/go-ci-cd-app .

# Expose port (if necessary)
EXPOSE 8080

# Command to run the application
CMD ["./go-ci-cd-app"]
