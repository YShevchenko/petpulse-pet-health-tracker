# PetPulse Detailed Test Cases

**Document:** TEST-CASES.md  

## 1. Reminder Scheduling (TC-100)
### TC-101: Monthly Recurrence
1. Add a medication "Heartgard" scheduled for Monthly on the 1st.
2. Tap "Mark as Given".
3. **Expected:** A local notification is scheduled for exactly 1 month from today at the default reminder time (e.g., 9:00 AM). The UI updates the "Next Due" date.

## 2. Status Calculation (TC-200)
### TC-201: Expired Vaccination Status
1. Add a Rabies vaccination with an expiration date set to Yesterday.
2. Go to the Dashboard.
3. **Expected:** The "Vaccines" status card is tinted Red and reads "1 Overdue".

## 3. Data Portability (TC-300)
### TC-301: JSON Export/Import
1. Create 2 Pets and 5 vaccinations.
2. Export JSON to the local filesystem.
3. Clear all app data.
4. Import the JSON file.
5. **Expected:** All 2 pets and 5 vaccinations are restored perfectly.

---

## 4. Pet Profiles (TC-100 continued)

### TC-103: Add New Pet Profile with All Fields
1. Tap "Add Pet".
2. Fill in all fields: Name ("Biscuit"), Species ("Dog"), Breed ("Golden Retriever"), Date of Birth (2021-03-15), Photo (select from gallery), Microchip ID ("985112010345678").
3. Tap "Save".
4. **Expected:** The pet profile is created and appears on the dashboard. Tapping the profile shows all entered data including the photo, and the Microchip ID is displayed in the details section.

---

## 5. Vaccination Status Logic (TC-100 continued)

### TC-104: Vaccination "Due Soon" Status Within 30 Days
1. Add a vaccination "Bordetella" with an expiration date set to 15 days from today.
2. Go to the Dashboard.
3. **Expected:** The "Vaccines" status card is tinted Yellow and reads "1 Due Soon". The vaccination entry shows a yellow warning indicator with the number of days remaining.

### TC-115: Vaccination with Past Expiry Shows "Expired" in Red
1. Add a vaccination "DHPP" with an expiration date set to 10 days ago.
2. Go to the Dashboard.
3. **Expected:** The "Vaccines" status card is tinted Red and reads "1 Overdue". The vaccination entry itself displays a red "Expired" badge with the date it expired.

---

## 6. Medication Management (TC-100 continued)

### TC-105: Mark Medication as "Given Today" and Verify Rescheduling
1. Add a medication "Heartgard" scheduled for Monthly on the 15th with a reminder at 9:00 AM.
2. Tap "Mark as Given" on the current due date.
3. **Expected:** The "Last Given" timestamp updates to today's date and time. The "Next Due" date advances to exactly one month forward (e.g., from March 15 to April 15). A new local notification is scheduled for the next due date at 9:00 AM.

### TC-106: Multiple Medications — Dashboard Active Count
1. Add 3 medications: "Heartgard" (Monthly), "Apoquel" (Daily), "Bravecto" (Every 3 months).
2. Go to the Dashboard.
3. **Expected:** The "Medications" summary card displays "3 Active" with the soonest due medication highlighted at the top. Each medication shows its individual next due date.

### TC-107: Discontinue Medication — Moves to History
1. Add a medication "Prednisone" (Daily).
2. Open the medication detail and tap "Discontinue".
3. Confirm the discontinuation dialog.
4. **Expected:** "Prednisone" disappears from the Active Medications list on the dashboard. Navigating to the Medication History section shows "Prednisone" with a "Discontinued" label and the date it was stopped. No future notifications are scheduled for this medication.

---

## 7. Weight Tracking (TC-100 continued)

### TC-108: Log Weight and Verify Chart Update
1. Navigate to the active pet's Weight section.
2. Tap "Log Weight". Enter 25.5 kg for today's date.
3. Tap "Save".
4. **Expected:** The weight log is saved. The line chart updates to display the new data point at today's date with the value 25.5 kg. If previous data points exist, the chart draws a line connecting them.

---

## 8. Premium Features (TC-100 continued)

### TC-109: Generate PDF Pet Passport
1. (Premium user) Create a pet with Microchip ID "985112010345678".
2. Add 3 active vaccinations (Rabies, DHPP, Bordetella) and 2 active medications (Heartgard, Apoquel).
3. Tap "Generate Pet Passport".
4. **Expected:** A PDF preview appears. The PDF header contains the pet's name and Microchip ID. All 3 vaccinations are listed with their administered and expiry dates. All 2 medications are listed with dosage and frequency. The PDF can be shared via the system share sheet.

### TC-110: Premium Gate — Add 2nd Pet on Free Tier
1. (Free user) Create one pet profile successfully.
2. Tap "Add Pet" to create a second pet.
3. **Expected:** The Premium paywall modal appears presenting the $14.99 one-time purchase option. The second pet is not created until the purchase completes. Dismissing the paywall returns the user to the existing single pet dashboard.

---

## 9. Data Portability (TC-300 continued)

### TC-111: Export Data as JSON — Verify Completeness
1. Create 2 pets, each with 3 vaccinations, 2 medications, and 5 weight log entries.
2. Tap "Export Data".
3. Open the exported JSON file on a computer.
4. **Expected:** The JSON file contains an array of 2 pet objects. Each pet object includes all profile fields (name, species, breed, DOB, microchip ID), a vaccinations array (3 entries each with name, dates, clinic), a medications array (2 entries each with name, dosage, frequency, status), and a weightLogs array (5 entries each with date and value).

### TC-112: Import JSON Backup — Verify Data Integrity
1. Export data from a device with 2 pets, 4 vaccinations, 3 medications, and 8 weight logs.
2. On a fresh app install (empty state), tap "Import Data".
3. Select the previously exported JSON file.
4. **Expected:** All 2 pets are restored with correct profile data. All 4 vaccinations appear with correct dates and status coloring. All 3 medications appear with correct scheduling. All 8 weight log entries appear and the chart renders correctly. The dashboard summary counts match the original data.

### TC-113: Delete All Data — Verify Clean Wipe
1. Create a pet with vaccinations, medications, and weight logs.
2. Navigate to Settings > "Delete All Data". Confirm the destructive action dialog.
3. **Expected:** The app returns to the empty/onboarding state. No pets, vaccinations, medications, or weight logs exist. The SQLite database tables are empty. No pending local notifications remain scheduled.

---

## 10. Notifications & Permissions (TC-100 continued)

### TC-114: Notification Permission Denied — Banner Prompt
1. On first launch, deny the notification permission prompt.
2. Add a medication with a reminder.
3. **Expected:** A persistent banner or inline warning appears on the dashboard stating "Notifications are disabled. Enable them in Settings to receive medication reminders." Tapping the banner opens the device's app notification settings. The medication is still saved correctly even without notification permission.