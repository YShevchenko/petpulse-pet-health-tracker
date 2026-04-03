# PetPulse Non-Functional Requirements

**Document:** NON-FUNCTIONAL-REQUIREMENTS.md  
**Product:** PetPulse  

## 1. Privacy & Security (NFR-100)
- **NFR-101 (Zero-Knowledge):** No pet profiles, microchip IDs, or health data shall leave the device.
- **NFR-102 (No Accounts):** The app must function fully anonymously without email login.

## 2. Performance (NFR-200)
- **NFR-201 (PDF Export Latency):** The PDF generation must complete in < 2 seconds.
- **NFR-202 (Local Image Compression):** Profile photos must be compressed to < 200KB before saving to the local filesystem to preserve storage space over time.

## 3. Reliability (NFR-300)
- **NFR-301 (Offline):** 100% functionality must be available without Wi-Fi.
- **NFR-302 (Alarm Resilience):** Scheduled medication reminders must utilize native OS local notifications so they trigger even if the app is force-closed.