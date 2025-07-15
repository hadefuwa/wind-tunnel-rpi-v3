# Wind Tunnel RPi v3 - Management Demo

A lightweight web-based wind tunnel data acquisition system for Raspberry Pi with real-time visualization and SPI sensor integration.

## 🚀 Quick Demo Setup 

### Prerequisites on Raspberry Pi
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Python and pip
sudo apt install python3 python3-pip git -y

# Install SPI tools (for hardware mode)
sudo apt install python3-spidev -y
```

### 1. Clone Repository to Raspberry Pi
```bash
# Clone the repository
git clone https://github.com/hadefuwa/wind-tunnel-rpi-v3.git

# Navigate to project folder
cd wind-tunnel-rpi-v3
```

### 2. Install Dependencies
```bash
# Install Python requirements
cd backend
pip3 install -r requirements.txt
```

### 3. Run the Demo
```bash
# Start the demo (from backend folder)
python3 app.py
```

### 4. Access the Dashboard
- **Local access:** Open browser to `http://localhost:5000`
- **Remote access:** From any device on same network: `http://[PI_IP_ADDRESS]:5000`
- **Find Pi IP:** Run `hostname -I` on the Pi

## 🎯 Management Demo Script

### Demo Flow (5-10 minutes)
1. **Introduction** - "This is our wind tunnel data acquisition system"
2. **Show Dashboard** - Live metrics updating in real-time
3. **Demonstrate Controls** - Start/Stop data collection
4. **Show Real-time Chart** - Live velocity visualization
5. **Toggle Modes** - Switch between simulation and hardware modes
6. **Highlight Benefits** - Remote access, lightweight, web-based

### Key Talking Points
- ✅ **Real-time data collection** - Updates every second
- ✅ **Modern web interface** - No desktop app installation needed
- ✅ **Remote accessible** - Use any device on network
- ✅ **Lightweight** - Perfect for Raspberry Pi
- ✅ **Scalable** - Easy to add features and sensors
- ✅ **Professional UI** - Production-ready appearance

## 📱 Demo Features

### Current Working Features
- **Real-time Dashboard** with live metrics
- **Interactive Controls** (Start/Stop, Mode switching)
- **Live Chart** showing velocity over time
- **Data Logging** with recent readings
- **Responsive Design** works on any device
- **Simulation Mode** with realistic data patterns

### Metrics Displayed
- **Velocity** (m/s) - Airflow speed
- **Pressure** (kPa) - Pressure differential
- **Temperature** (°C) - Environmental temperature
- **Turbulence** (%) - Airflow turbulence level

## 🔧 Technical Architecture

### Backend (Python + Flask)
- **Flask** web framework for API endpoints
- **Threading** for continuous data collection
- **SPI Integration** ready for hardware sensors
- **Simulation Mode** for development and demos

### Frontend (HTML/CSS/JavaScript)
- **Vanilla JavaScript** - No frameworks, lightweight
- **Canvas Charts** - Custom real-time visualization
- **Responsive Design** - Works on desktop, tablet, mobile
- **Modern UI** - Professional gradient design

### API Endpoints
- `POST /api/start` - Start data collection
- `POST /api/stop` - Stop data collection
- `GET /api/latest` - Get latest data point
- `GET /api/data` - Get all buffered data
- `GET/POST /api/config` - Configuration management
- `GET /api/status` - System status

## 🔌 Hardware Integration (Next Phase)

### SPI Sensor Setup
```python
# Example SPI sensor integration
import spidev

def read_spi_sensor():
    spi = spidev.SpiDev()
    spi.open(0, 0)  # Bus 0, Device 0
    spi.max_speed_hz = 1000000
    
    # Read sensor data
    response = spi.xfer2([0x00, 0x00, 0x00])
    spi.close()
    
    return parse_sensor_data(response)
```

### Enable SPI on Raspberry Pi
```bash
# Enable SPI interface
sudo raspi-config
# Navigate to: Interface Options -> SPI -> Enable

# Verify SPI is enabled
ls -la /dev/spi*
```

## 🌐 Network Configuration

### Find Raspberry Pi IP Address
```bash
# Method 1: Direct on Pi
hostname -I

# Method 2: From router admin panel
# Look for device named "raspberrypi"

# Method 3: Network scan (from another device)
nmap -sn 192.168.1.0/24
```

### Access from Other Devices
- **Laptop:** `http://192.168.1.XXX:5000`
- **Phone:** `http://192.168.1.XXX:5000`
- **Tablet:** `http://192.168.1.XXX:5000`

## 🚀 Production Deployment

### Auto-start on Boot
```bash
# Create systemd service
sudo nano /etc/systemd/system/wind-tunnel.service
```

```ini
[Unit]
Description=Wind Tunnel Data Acquisition
After=network.target

[Service]
Type=simple
User=pi
WorkingDirectory=/home/pi/wind-tunnel-rpi-v3/backend
ExecStart=/usr/bin/python3 app.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

```bash
# Enable and start service
sudo systemctl enable wind-tunnel.service
sudo systemctl start wind-tunnel.service

# Check status
sudo systemctl status wind-tunnel.service
```

### Security (Optional)
```bash
# Install nginx for reverse proxy
sudo apt install nginx -y

# Configure SSL/HTTPS
sudo apt install certbot python3-certbot-nginx -y
```

## 🛠️ Troubleshooting

### Common Issues

**1. Port 5000 already in use**
```bash
# Kill process using port 5000
sudo lsof -ti:5000 | xargs sudo kill -9
```

**2. Python module not found**
```bash
# Reinstall requirements
pip3 install -r requirements.txt --force-reinstall
```

**3. SPI not working**
```bash
# Check SPI is enabled
sudo raspi-config
# Enable SPI interface
```

**4. Cannot access remotely**
```bash
# Check firewall
sudo ufw status

# Allow port 5000
sudo ufw allow 5000
```

## 📊 Data Export

### Export Data to CSV
```bash
# Access API endpoint
curl http://localhost:5000/api/data > wind_tunnel_data.json

# Convert to CSV (add to future version)
python3 -c "
import json, csv
with open('wind_tunnel_data.json') as f:
    data = json.load(f)
with open('data.csv', 'w') as f:
    writer = csv.DictWriter(f, fieldnames=['timestamp', 'velocity', 'pressure', 'temperature', 'turbulence'])
    writer.writeheader()
    writer.writerows(data['data'])
"
```

## 🔄 Future Enhancements

### Phase 2 Features
- [ ] **Data Export** - CSV/JSON download
- [ ] **User Authentication** - Login system
- [ ] **Data Storage** - SQLite database
- [ ] **Email Alerts** - Threshold notifications
- [ ] **3D Visualization** - Three.js integration
- [ ] **Mobile App** - Progressive Web App

### Phase 3 Features
- [ ] **Multiple Sensors** - Support for sensor arrays
- [ ] **Cloud Integration** - AWS/Azure connectivity
- [ ] **Machine Learning** - Predictive analytics
- [ ] **Report Generation** - PDF reports
- [ ] **User Management** - Multi-user support

## 💡 Demo Tips

### For Best Demo Experience
1. **Pre-load the page** before presentation
2. **Auto-start** is enabled - data will be flowing immediately
3. **Use a tablet** for interactive demonstration
4. **Show multiple devices** accessing simultaneously
5. **Emphasize real-time** nature of the system

### Demo Backup Plan
- **Offline mode** - Works without internet
- **Local simulation** - No hardware needed
- **Mobile responsive** - Works on any device
- **Quick restart** - `Ctrl+C` and `python3 app.py`

## 📞 Support

For technical questions or demo setup issues:
- **Repository:** https://github.com/hadefuwa/wind-tunnel-rpi-v3
- **Quick Start:** Run `python3 app.py` from backend folder
- **Emergency:** Use simulation mode if hardware fails

---

**Demo Ready Time:** 2 minutes setup  
**Demo Duration:** 5-10 minutes  
**Wow Factor:** ⭐⭐⭐⭐⭐  

Good luck with your presentation! 🚀
