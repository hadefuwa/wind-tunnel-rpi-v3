#!/usr/bin/env python3
"""
Minimal Flask test to debug the white screen issue
"""
from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def index():
    return """
    <!DOCTYPE html>
    <html>
    <head>
        <title>Flask Test</title>
    </head>
    <body>
        <h1>Flask Test Working!</h1>
        <p>If you see this, Flask is working correctly.</p>
        <p>Current directory: {}</p>
    </body>
    </html>
    """.format(os.getcwd())

if __name__ == '__main__':
    print("🧪 Minimal Flask Test Starting...")
    print("🔗 Open: http://localhost:5000")
    app.run(host='0.0.0.0', port=5000, debug=True)
