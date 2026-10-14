# AIttendance: Face Recognition Attendance System

A web app that marks student attendance automatically using face recognition. Register a student, capture their face through the webcam, train the model, and attendance is recorded the moment the student's face is recognized.

## Features

- **Student registration:** add a student's name, roll number, class, section and registration number
- **Face capture:** collect face images through the webcam for each student
- **One-click training:** the model trains in the background with a live progress bar
- **Automatic attendance:** recognizes a face and saves the student's name with a timestamp
- **Dashboard:** chart of attendance counts for the last 30 days
- **Attendance records:** filter by daily, weekly or monthly
- **CSV export:** download all attendance records as a spreadsheet
- **Student management:** list students and delete them along with their data

## How it works

1. **Face detection:** MediaPipe finds the face in each image.
2. **Feature extraction:** the face is cropped, converted to grayscale and resized to 32x32 pixels, giving a 1024-number vector for each face.
3. **Classification:** a Random Forest classifier (150 trees, scikit-learn) learns to match these vectors to student IDs.
4. **Recognition:** for a new image, the model predicts a student and a confidence score. Attendance is saved only if confidence is 50% or higher.
5. **Storage:** students and attendance records are stored in SQLite.

## Tech stack

| Area | Tools |
|---|---|
| Backend | Python 3.11, Flask |
| Computer vision | OpenCV, MediaPipe |
| Machine learning | scikit-learn (Random Forest), NumPy |
| Data | SQLite, pandas |
| Frontend | HTML templates (Flask/Jinja) |

## Project structure

```
AIttendance/
├── app.py              # Flask app: routes, database, API endpoints
├── model.py            # Face detection, feature extraction, training, prediction
├── run.sh              # Startup script
├── requirements.txt    # Python dependencies
├── templates/          # HTML pages
├── static/             # CSS / JS
└── dataset/            # Captured face images (created at runtime)
```

## Setup and run

Python 3.11 is recommended for MediaPipe compatibility.

```bash
# 1. Clone the repo
git clone https://github.com/digvijayguptaworks/AIttendance.git
cd AIttendance

# 2. Create and activate a virtual environment
python3.11 -m venv venv
source venv/bin/activate        # Windows: venv\Scripts\activate

# 3. Install dependencies
pip install -r requirements.txt

# 4. Start the app
./run.sh                        # or: python app.py
```

Open **http://localhost:5001** in your browser.

## Usage

1. Go to **Add Student**, fill in the details and capture face images (more images and varied angles give better accuracy).
2. Click **Train Model** and wait for the progress bar to reach 100%.
3. Go to **Mark Attendance** and look at the camera. Recognized students are logged automatically.
4. View **Attendance Records** or download the CSV.

## API endpoints

| Endpoint | Method | Purpose |
|---|---|---|
| `/add_student` | GET, POST | Register a student |
| `/upload_face` | POST | Upload captured face images |
| `/train_model` | GET | Start background training |
| `/train_status` | GET | Check training progress |
| `/recognize_face` | POST | Recognize a face and mark attendance |
| `/attendance_record` | GET | View records (`?period=daily/weekly/monthly`) |
| `/attendance_stats` | GET | 30-day attendance data for the chart |
| `/download_csv` | GET | Export attendance as CSV |
| `/students` | GET | List students |
| `/students/<id>` | DELETE | Delete a student and their data |

## Limitations and future improvements

- Features are raw 32x32 grayscale pixels, so accuracy depends on lighting and camera angle. Using deep face embeddings (FaceNet or ArcFace) would be more robust.
- No liveness detection, so a photo of a student could fool the system.
- No login or admin authentication yet.
- A student can be marked multiple times a day. Adding a once-per-day check would fix this.

## Author

**Digvijay Gupta**
GitHub: [digvijayguptaworks](https://github.com/digvijayguptaworks)
Email: digvijaygworks@gmail.com
