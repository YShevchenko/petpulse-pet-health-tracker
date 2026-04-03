#!/bin/bash
# Script to generate PetPulse UI designs using Google Stitch

set -e
WORK_DIR="/Users/yts/lab/planned/pet-health-tracker/docs/stitch-designs"
mkdir -p "$WORK_DIR"
LOG_FILE="$WORK_DIR/generation.log"

echo "Starting Stitch Generation for PetPulse..." > "$LOG_FILE"
TOKEN=$(gcloud auth application-default print-access-token)
export STITCH_ACCESS_TOKEN=$TOKEN
export GOOGLE_CLOUD_PROJECT=lab-apps-490222
export PATH="/opt/homebrew/bin:$PATH"

echo "Creating project..." | tee -a "$LOG_FILE"
PROJECT_JSON=$(stitch-mcp tool create_project -d '{"title": "PetPulse - Vibecodable"}' -o json)
PROJECT_ID=$(echo "$PROJECT_JSON" | grep -o '"name":"projects/[^"]*' | cut -d'/' -f2 | head -1)

if [ -z "$PROJECT_ID" ]; then
  echo "Failed to create project." | tee -a "$LOG_FILE"
  exit 1
fi

declare -a PROMPTS=(
  "Mobile app dashboard for a pet health tracker. Light theme. Top card shows 'Luna' with a dog photo. Below are three rectangular status cards: 'Vaccines' (Green, Up to date), 'Medications' (Yellow, 1 Due Soon), and 'Weight' (Line chart preview). Bottom tab bar navigation."
  "Mobile app list screen for pet records. Clean white background. A vertical list of vaccines like 'Rabies' and 'Bordetella'. Each row has a date and a status icon (green checkmark or red exclamation). A floating action '+' button to add a new record."
  "Mobile app modal for adding a pet medication. Soft rounded inputs. Fields for 'Medication Name', 'Dosage', and a dropdown for 'Frequency' (Monthly). A large primary orange button to 'Save Reminder'."
  "Mobile app PDF preview screen for a 'Pet Passport'. A white page showing a clean, structured table of vaccination records and a microchip ID at the top. A massive blue 'Share / Print Passport' button pinned to the bottom of the screen."
  "Mobile app settings screen for a pet app. Light theme. A profile switcher to select between multiple pets. Buttons for 'Export Data' and 'Import Data'. A prominent section highlighting a $14.99 Premium Unlock for 'Multiple Pets & PDF Passport'."
)

declare -a FILENAMES=(
  "01_Dashboard"
  "02_RecordsList"
  "03_AddMedication"
  "04_PDFPreview"
  "05_Settings"
)

for i in "${!PROMPTS[@]}"; do
  export STITCH_ACCESS_TOKEN=$(gcloud auth application-default print-access-token)
  PROMPT="${PROMPTS[$i]}"
  FILENAME="${FILENAMES[$i]}"
  
  echo "Generating Screen $((i+1))/5: $FILENAME..." | tee -a "$LOG_FILE"
  SCREEN_JSON=$(stitch-mcp tool generate_screen_from_text -d "{\"projectId\": \"$PROJECT_ID\", \"prompt\": \"$PROMPT\"}" -o json || true)
  SCREEN_ID=$(echo "$SCREEN_JSON" | grep -o '"name":"projects/[^"]*/screens/[^"]*' | cut -d'/' -f4 | head -1)
  
  if [ -n "$SCREEN_ID" ]; then
    echo "  Success! Screen ID: $SCREEN_ID" | tee -a "$LOG_FILE"
    CODE_JSON=$(stitch-mcp tool get_screen_code -d "{\"projectId\": \"$PROJECT_ID\", \"screenId\": \"$SCREEN_ID\"}" -o json || true)
    echo "$CODE_JSON" > "$WORK_DIR/$FILENAME.json"
    echo "  Saved to $FILENAME.json" | tee -a "$LOG_FILE"
  else
    echo "  Failed to generate screen. Response: $SCREEN_JSON" | tee -a "$LOG_FILE"
  fi
done
echo "All tasks completed!" | tee -a "$LOG_FILE"