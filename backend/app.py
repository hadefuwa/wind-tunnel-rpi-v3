#!/usr/bin/env python3
"""
Minimal Wind Tunnel Demo Backend
Quick demo for management presentation
"""

from flask import Flask, jsonify, render_template_string, request, send_from_directory
from flask_cors import CORS
import random
import time
import math
import threading
import json
import os

app = Flask(__name__)
CORS(app)

# Global state for demo
demo_state = {
    'mode': 'simulation',  # 'simulation' or 'hardware'
    'running': False,
    'data_buffer': [],
    'config': {
        'sample_rate': 10,  # Hz
        'max_buffer_size': 100
    }
}

def generate_realistic_data():
    """Generate realistic wind tunnel data for demo with minimal processing"""
    timestamp = time.time()
    
    # Use simple calculations for minimal CPU usage
    # Base velocity varies slowly over time
    base_velocity = 15.0 + 5.0 * math.sin(timestamp * 0.1)
    velocity = base_velocity + random.uniform(-2.0, 2.0)
    
    # All other parameters are simple linear functions of velocity for efficiency
    # This avoids complex calculations while maintaining realistic relationships
    
    return {
        'timestamp': timestamp,
        'velocity': round(velocity, 2),
        'flowRate': round(velocity * 60.0 + random.uniform(-50, 50), 1),  # l/min
        'diffPressure': round(velocity * 12.0 + random.uniform(-20, 20), 1),  # Pa
        'staticPressure': round(101325 + velocity * 50 + random.uniform(-100, 100), 1),  # Pa
        'fanSpeed': round(velocity * 150 + random.uniform(-200, 200), 0),  # RPM
        'power': round(velocity * 8.0 + random.uniform(-10, 10), 1),  # W
        'valvePosition': round(60 + velocity * 2 + random.uniform(-20, 20), 1),  # %
        'dragForce': round(velocity * 0.8 + random.uniform(-0.5, 0.5), 2),  # N
        'pressure': round(101.3 + velocity * 0.5 + random.uniform(-0.5, 0.5), 2),  # kPa
        'temperature': round(23.0 + velocity * 0.1 + random.uniform(-1.0, 1.0), 2),  # °C
        'turbulence': round(abs(velocity - 15.0) * 10 + random.uniform(0, 20), 1)  # %
    }

def data_collection_thread():
    """Background thread for continuous data collection"""
    while True:
        if demo_state['running']:
            if demo_state['mode'] == 'simulation':
                data = generate_realistic_data()
            else:
                # In real mode, you would read from SPI here
                data = {
                    'timestamp': time.time(),
                    'velocity': 0,
                    'pressure': 0,
                    'temperature': 0,
                    'turbulence': 0,
                    'error': 'Hardware not connected'
                }
            
            # Add to buffer
            demo_state['data_buffer'].append(data)
            
            # Limit buffer size
            if len(demo_state['data_buffer']) > demo_state['config']['max_buffer_size']:
                demo_state['data_buffer'].pop(0)
        
        time.sleep(1.0 / demo_state['config']['sample_rate'])

# Start background thread
data_thread = threading.Thread(target=data_collection_thread, daemon=True)
data_thread.start()

@app.route('/')
def index():
    """Serve the demo frontend"""
    # Get the directory where this script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    frontend_dir = os.path.join(script_dir, '..', 'frontend')
    html_file = os.path.join(frontend_dir, 'index.html')
    
    try:
        with open(html_file, 'r') as f:
            return render_template_string(f.read())
    except FileNotFoundError:
        return f"Error: Could not find {html_file}", 404

@app.route('/logo.png')
def serve_logo():
    """Serve the logo file"""
    # Get the directory where this script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    frontend_dir = os.path.join(script_dir, '..', 'frontend')
    return send_from_directory(frontend_dir, 'logo.png')

@app.route('/tunnel.png')
def serve_tunnel():
    """Serve the tunnel image file"""
    # Get the directory where this script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    frontend_dir = os.path.join(script_dir, '..', 'frontend')
    return send_from_directory(frontend_dir, 'tunnel.png')

@app.route('/favicon.ico')
def serve_favicon():
    """Serve favicon (or return 404)"""
    return '', 404

@app.route('/api/start', methods=['POST'])
def start_collection():
    """Start data collection"""
    demo_state['running'] = True
    return jsonify({'status': 'started', 'message': 'Data collection started'})

@app.route('/api/stop', methods=['POST'])
def stop_collection():
    """Stop data collection"""
    demo_state['running'] = False
    return jsonify({'status': 'stopped', 'message': 'Data collection stopped'})

@app.route('/api/data')
def get_data():
    """Get current data buffer"""
    return jsonify({
        'data': demo_state['data_buffer'],
        'running': demo_state['running'],
        'mode': demo_state['mode'],
        'count': len(demo_state['data_buffer'])
    })

@app.route('/api/latest')
def get_latest():
    """Get latest data point"""
    if demo_state['data_buffer']:
        latest_data = demo_state['data_buffer'][-1]
        print(f"[DEBUG] Serving latest data: {latest_data}")
        return jsonify(latest_data)
    print("[DEBUG] No data available in buffer")
    return jsonify({'error': 'No data available'})

@app.route('/api/config', methods=['GET', 'POST'])
def config():
    """Get/set configuration"""
    if request.method == 'POST':
        data = request.json
        if 'mode' in data:
            demo_state['mode'] = data['mode']
        if 'sample_rate' in data:
            demo_state['config']['sample_rate'] = data['sample_rate']
        return jsonify({'status': 'updated', 'config': demo_state['config']})
    
    return jsonify({
        'mode': demo_state['mode'],
        'config': demo_state['config']
    })

@app.route('/api/status')
def status():
    """Get system status"""
    return jsonify({
        'running': demo_state['running'],
        'mode': demo_state['mode'],
        'data_points': len(demo_state['data_buffer']),
        'sample_rate': demo_state['config']['sample_rate']
    })

if __name__ == '__main__':
    print("🌪️  Wind Tunnel Demo Starting...")
    print("📊 Management Demo Mode")
    print("🔗 Open: http://localhost:5000")
    print("🚀 Starting in simulation mode...")
    
    # Debug path information
    script_dir = os.path.dirname(os.path.abspath(__file__))
    frontend_dir = os.path.join(script_dir, '..', 'frontend')
    html_file = os.path.join(frontend_dir, 'index.html')
    logo_file = os.path.join(frontend_dir, 'logo.png')
    
    print(f"📁 Script directory: {script_dir}")
    print(f"📁 Frontend directory: {frontend_dir}")
    print(f"📄 HTML file: {html_file}")
    print(f"🖼️  Logo file: {logo_file}")
    print(f"✅ HTML exists: {os.path.exists(html_file)}")
    print(f"✅ Logo exists: {os.path.exists(logo_file)}")
    
    # Auto-start for demo
    demo_state['running'] = True
    
    app.run(host='0.0.0.0', port=5000, debug=True)
