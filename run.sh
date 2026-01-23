#!/bin/bash

# Digital Facial Recognition Attendance System
# Startup script

echo "Starting Digital Facial Recognition Attendance System..."
echo "Using Python 3.11 virtual environment for compatibility with MediaPipe"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Error: Virtual environment not found. Please run setup first:"
    echo "python3.11 -m venv venv"
    echo "source venv/bin/activate"
    echo "pip install -r requirements.txt"
    exit 1
fi

# Activate virtual environment and start the application
echo "Activating virtual environment..."
source venv/bin/activate

echo "Starting Flask application on http://localhost:5001"
echo "Press Ctrl+C to stop the server"
./venv/bin/python app.py
