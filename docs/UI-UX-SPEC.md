# PetPulse UI/UX Specification

**Document:** UI-UX-SPEC.md  
**Product:** PetPulse  

## 1. Design Philosophy
- **Friendly but Utility-First:** The UI should be welcoming (using soft colors and rounded corners) but not overly cartoonish. It is a serious tool for tracking medical data.
- **Status at a Glance:** The user should instantly know if their pet is "Up to Date" (Green), "Needs Attention" (Yellow), or "Overdue" (Red).

## 2. Color Palette
- **Background (Light Mode):** `#F9FAFC` (Soft off-white).
- **Primary:** `#FCA311` (Energetic Orange).
- **Secondary:** `#2A9D8F` (Vet Blue).
- **Status (Good):** `#2ECC71` (Green).
- **Status (Bad):** `#E74C3C` (Red).

## 3. Screens (Vibecodable)
1. **The Dashboard:** A top card showing the active pet's name, profile photo, and microchip ID. Below are three status cards: "Vaccines", "Medications", and "Weight".
2. **Records List:** A vertical list of vaccines. A green checkmark for current, a red exclamation mark for expired.
3. **Add Medication Modal:** Simple form for Name, Frequency (Daily, Weekly, Monthly), and Dosage.
4. **PDF Preview Screen:** A visual preview of the "Pet Passport" document with a large "Share / Print" button.
5. **Settings:** Pet profile switcher. Export/Import JSON data. $14.99 Premium Unlock button.