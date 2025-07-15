# Wind Tunnel Application - Lightweight Web App Alternative

## Overview

This document describes an alternative approach to building the wind tunnel data acquisition and visualization app for Raspberry Pi, focusing on simplicity, performance, and direct hardware access. Instead of using Electron, this method uses a native backend (Python or Node.js) for SPI communication and a web-based frontend for the user interface.

---

## Why Use a Web App Instead of Electron?

- **Lower Resource Usage:** Electron apps are heavy for Raspberry Pi; a web app is much lighter and faster.
- **Direct SPI Access:** Native backends (Python or Node.js) can access SPI hardware directly, without Electron's sandbox limitations.
- **Remote Access:** The dashboard can be accessed from any device on the same network.
- **Simpler Deployment:** No need to package a desktop app; just run the backend and open a browser.

---

## Architecture

### 1. Backend (Python or Node.js)

- **Handles SPI communication** using libraries like `spidev` (Python) or `spi-device` (Node.js).
- **Exposes a REST API or WebSocket** for the frontend to fetch real-time data.
- **Manages simulation mode** by generating synthetic data when hardware is not connected.
- **Performs data validation, logging, and error handling.**

### 2. Frontend (Web App)

- **Built with React, Vue, or plain HTML/JS.**
- **Displays real-time data, charts, and 3D visualization** (using Three.js or similar).
- **Provides a settings panel** for SPI configuration and mode switching.
- **Runs in any modern browser** on the Raspberry Pi or remotely.

---

## Example Stack

- **Backend:**  
  - Python (Flask + spidev)  
  - or Node.js (Express + spi-device)
- **Frontend:**  
  - React (served as static files)
- **Communication:**  
  - REST API for configuration and data fetching  
  - WebSocket for real-time data streaming

---

## Example Workflow

1. **Start the backend** on the Raspberry Pi (`python app.py` or `node server.js`).
2. **Open the frontend** in a browser (`http://raspberrypi.local:5000`).
3. **Configure SPI settings** and select simulation or real mode.
4. **View real-time data, charts, and 3D visualization** in the browser.
5. **Export data** or adjust settings as needed.

---

## Benefits

- **Performance:** Fast and responsive, even on low-powered Raspberry Pi models.
- **Flexibility:** Access the dashboard from any device.
- **Maintainability:** Easier to update and debug.
- **Direct Hardware Access:** No Electron limitations.

---

## Sample Project Structure

```
wind-tunnel-webapp/
├── backend/
│   ├── app.py           # Flask app (Python) or server.js (Node.js)
│   ├── spi.py           # SPI communication logic
│   ├── simulation.py    # Simulation data generator
│   └── requirements.txt # Python dependencies
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── services/
│   │   └── App.jsx
│   └── package.json
└── README.md
```

---

## Next Steps

- Choose your backend language (Python is recommended for Raspberry Pi).
- Scaffold the backend with SPI and simulation endpoints.
- Build the frontend dashboard and connect it to the backend API.
- Test on your Raspberry Pi with real hardware.

---

Let me know if you want a sample code template or further details on any part of this