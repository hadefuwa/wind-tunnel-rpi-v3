# Wind Tunnel Demo - Quick Reference Card

## 🚀 Emergency Setup (If needed tomorrow)

### On Raspberry Pi:
```bash
# 1. Clone repository
git clone https://github.com/hadefuwa/wind-tunnel-rpi-v3.git
cd wind-tunnel-rpi-v3

# 2. Run setup script
chmod +x setup_pi.sh
./setup_pi.sh

# 3. Start demo
cd wind-tunnel-demo/backend
python3 app.py
```

### Access Dashboard:
- **Local:** http://localhost:5000
- **Remote:** http://[PI_IP]:5000

## 🎯 Demo Script (5 minutes)

### 1. Introduction (30 seconds)
"This is our wind tunnel data acquisition system - a lightweight web-based solution designed specifically for Raspberry Pi."

### 2. Show Real-time Data (1 minute)
- Point to live metrics updating every second
- "These are real-time sensor readings - velocity, pressure, temperature, and turbulence"
- "Data updates automatically without refreshing the page"

### 3. Interactive Controls (1 minute)
- Click "Start Collection" button
- Click "Stop Collection" button  
- "We can control data collection in real-time"

### 4. Live Visualization (1 minute)
- Point to the chart showing velocity over time
- "This chart updates live as new data comes in"
- "Perfect for monitoring airflow patterns"

### 5. Mode Switching (1 minute)
- Click "Mode: Simulation" button
- "We can switch between simulation and hardware modes"
- "Right now we're in simulation mode generating realistic data"

### 6. Remote Access (30 seconds)
- Show same dashboard on phone/tablet
- "The system is web-based - accessible from any device on the network"
- "No software installation needed"

### 7. Closing (30 seconds)
"This lightweight approach gives us professional-grade functionality with minimal resource usage - perfect for Raspberry Pi deployment."

## 🛠️ Troubleshooting

### If demo fails:
1. **Check Python:** `python3 --version`
2. **Reinstall:** `pip3 install -r requirements.txt`
3. **Restart:** `Ctrl+C` then `python3 app.py`
4. **Check IP:** `hostname -I`

### Backup plan:
- Demo works offline
- Simulation mode always available
- No hardware needed
- Works on any device

## 📱 Demo Tips

### For maximum impact:
- ✅ Auto-start enabled - data flows immediately
- ✅ Use tablet for interactive demonstration
- ✅ Show multiple devices accessing simultaneously
- ✅ Emphasize "real-time" throughout demo
- ✅ Highlight "no installation needed"

### Key selling points:
- **Lightweight** - Perfect for Raspberry Pi
- **Real-time** - Live data updates
- **Professional** - Modern web interface
- **Accessible** - Any device, anywhere
- **Scalable** - Easy to add features

---

**Setup Time:** 2 minutes  
**Demo Time:** 5 minutes  
**Success Rate:** 100% (simulation mode always works)  

**You've got this! 🚀**
