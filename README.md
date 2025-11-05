# Dockerized React App (Multi-Stage Build)

This project demonstrates how to take a standard [Create React App](https://github.com/facebook/create-react-app) and create a production-ready, optimized Docker image using a multi-stage build.

## What We Built
* **A simple React App:** The default starter app.
* **A Multi-Stage Dockerfile:** A two-stage build process to create a small, secure final image.
* **An Nginx Server Config:** To serve the static React files inside the final container, correctly configured for a Single Page Application (SPA).

## Demo
Here is the app running successfully from the Docker container, served by Nginx.

![React App running in Docker](https://github.com/ravishankar1810/docker-react-app/blob/989ecc96f92bf0e9ebd092ce6dbde14657ed2ca5/Screenshot%202025-11-06%20010930.png)
![React App running in Docker](https://github.com/ravishankar1810/docker-react-app/blob/989ecc96f92bf0e9ebd092ce6dbde14657ed2ca5/Screenshot%202025-11-06%20010948.png)
## What This Project Teaches (The "Why")

This multi-stage build is a best practice for containerizing front-end applications.

1.  **Stage 1 (The "Builder"):** Uses a full Node.js image to install all dependencies (`node_modules`) and run `npm run build`. This stage is large but temporary.
2.  **Stage 2 (The "Production"):** Uses a tiny, lightweight Nginx image. We *only* copy the `build` folder (the static HTML/CSS/JS files) from Stage 1.

The result is a final image that is **tiny and secure** (often under 50MB) because it doesn't contain Node.js, `node_modules`, or any of your source code—only the final static files Nginx needs to serve.

---

## How to Run This Project (with Docker)
This is the primary way to run the production build.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/YourUsername/docker-react-app.git](https://github.com/YourUsername/docker-react-app.git)
    cd docker-react-app
    ```

2.  **Build the Docker image:**
    ```bash
    docker build -t react-prod-app .
    ```

3.  **Run the container:**
    ```bash
    docker run -d -p 80:80 --name my-app react-prod-app
    ```

4.  **View in browser:**
    Open [http://localhost](http://localhost)

---

## Local Development (Without Docker)
These are the original Create React App scripts for developing and testing locally (before you're ready to build the container).

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.
