# Stage 1: Build
FROM node:16 AS build

# Create and set the working directory
WORKDIR /app

# Copy the package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project files
COPY . .

# Build the project
RUN npm run build

# Stage 2: Run
FROM node:16

# Create and set the working directory
WORKDIR /app

# Copy only the build output from the previous stage
COPY --from=build /app/build /app/build

# Install production dependencies
COPY package.json package-lock.json ./
RUN npm install --only=production

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
