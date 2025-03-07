# Use the official Golang image from Docker Hub
FROM golang:1.18-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Modules file
COPY go.mod ./
COPY go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum haven't changed
RUN go mod tidy

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o go-ci-cd-app main.go

# Start a new stage from a smaller image to reduce image size
FROM alpine:latest  

# Install necessary dependencies (for example: bash)
RUN apk --no-cache add ca-certificates

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/go-ci-cd-app .

# Expose port if needed (example)
EXPOSE 8080

# Command to run the application
CMD ["./go-ci-cd-app"]
