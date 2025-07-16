# Wind Tunnel RPi v3 – Technical Overview

## Tech Stack

**Backend:**
- **Language:** Python 3
- **Framework:** Flask (REST API, web server)
- **Libraries:** flask_cors, threading, spidev (for SPI sensor integration)
- **Deployment Target:** Raspberry Pi (Linux)
- **Data Handling:** In-memory buffer, simulation or hardware mode

**Frontend:**
- **Languages:** HTML, CSS, JavaScript (Vanilla)
- **Visualization:** 
  - **Chart.js** (Real-time line charts for sensor data)
  - **HTML5 Canvas** (2D wind tunnel simulation with particle effects)
  - **Three.js** (WebGL 3D wind tunnel visualization)
- **UI:** Responsive, modern design, works on desktop/tablet/mobile

---

## How the App Works

### Architecture

- **Backend (Flask):**
  - Serves the frontend ([`frontend/index.html`](frontend/index.html)) and static assets.
  - Provides REST API endpoints for:
    - Starting/stopping data collection (`/api/start`, `/api/stop`)
    - Fetching latest or buffered data (`/api/latest`, `/api/data`)
    - Configuration management (`/api/config`)
    - System status (`/api/status`)
  - Runs a background thread for continuous data collection (simulation or hardware via SPI).
  - Supports two modes:
    - **Simulation:** Generates realistic wind tunnel data for demo/testing.
    - **Hardware:** Reads data from SPI sensors (Raspberry Pi).

- **Frontend (HTML/JS):**
  - Connects to backend API for real-time data.
  - Displays dashboard with live metrics (velocity, pressure, flow rate, etc.).
  - Interactive controls for starting/stopping collection and switching modes.
  - **Real-time charts (Chart.js)** showing sensor data over time with multiple datasets.
  - **2D Canvas simulation** with animated particles showing airflow patterns around objects.
  - **3D visualization (Three.js)** of airflow and car model interaction.
  - Data log and settings for buffer size, sample rate, and troubleshooting.
  - Responsive design for all devices.

### Visualization Components

- **Chart.js Integration:**
  - Real-time line charts for velocity, pressure, and flow rate
  - Multiple datasets with different colors and styling
  - Smooth animations and responsive design
  - Time-based x-axis with rolling data window

- **2D Canvas Simulation:**
  - HTML5 Canvas-based particle system
  - Animated airflow visualization with velocity-based particle movement
  - Interactive object placement (car models, obstacles)
  - Real-time rendering of flow patterns and turbulence

### Data Flow

1. **User starts data collection** via frontend controls.
2. **Backend thread** collects data (simulated or from SPI sensor).
3. **Frontend polls API** for latest data every second.
4. **Dashboard and charts** update in real-time using Chart.js.
5. **2D Canvas simulation** renders particle-based airflow animation.
6. **3D Visualization tab** shows Three.js airflow and car interaction.
7. **Settings tab** allows configuration of sample rate, buffer size, and mode.

### Key Features

- Real-time dashboard with Chart.js line charts
- 2D HTML5 Canvas particle simulation
- 3D wind tunnel visualization
- Simulation and hardware sensor support
- RESTful API for data/control
- Responsive, modern UI

---

This document provides a technical overview of the Wind Tunnel RPi v3 application architecture and functionality.