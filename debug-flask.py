#!/usr/bin/env python3
"""
Debug script to test Flask app
"""
import os
import sys

print("🔍 Flask App Debug Script")
print("=" * 40)

# Check current directory
print(f"Current directory: {os.getcwd()}")

# Check if demo directory exists
demo_dir = "wind-tunnel-demo"
if os.path.exists(demo_dir):
    print(f"✅ Demo directory exists: {demo_dir}")
    
    # Check backend
    backend_dir = os.path.join(demo_dir, "backend")
    if os.path.exists(backend_dir):
        print(f"✅ Backend directory exists: {backend_dir}")
        
        app_file = os.path.join(backend_dir, "app.py")
        if os.path.exists(app_file):
            print(f"✅ App file exists: {app_file}")
        else:
            print(f"❌ App file missing: {app_file}")
    else:
        print(f"❌ Backend directory missing: {backend_dir}")
    
    # Check frontend
    frontend_dir = os.path.join(demo_dir, "frontend")
    if os.path.exists(frontend_dir):
        print(f"✅ Frontend directory exists: {frontend_dir}")
        
        html_file = os.path.join(frontend_dir, "index.html")
        if os.path.exists(html_file):
            print(f"✅ HTML file exists: {html_file}")
        else:
            print(f"❌ HTML file missing: {html_file}")
            
        logo_file = os.path.join(frontend_dir, "logo.png")
        if os.path.exists(logo_file):
            print(f"✅ Logo file exists: {logo_file}")
        else:
            print(f"❌ Logo file missing: {logo_file}")
    else:
        print(f"❌ Frontend directory missing: {frontend_dir}")
else:
    print(f"❌ Demo directory missing: {demo_dir}")

print("\n🧪 Testing Flask app import...")
try:
    sys.path.insert(0, os.path.join(demo_dir, "backend"))
    from app import app
    print("✅ Flask app imported successfully")
    
    # Test the index route
    with app.test_client() as client:
        response = client.get('/')
        print(f"✅ Index route status: {response.status_code}")
        if response.status_code == 200:
            print("✅ Index route returns content")
        else:
            print(f"❌ Index route error: {response.status_code}")
            
except Exception as e:
    print(f"❌ Flask app import error: {e}")

print("\n🏁 Debug complete")
