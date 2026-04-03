# PetPulse Requirements

**Document:** REQUIREMENTS.md  
**Product:** PetPulse  
**Publisher:** Heldig Lab  

---

## 1. Functional Requirements

### 1.1 Pet Profiles & Dashboard (FR-001 to FR-010)
| ID | Requirement | Priority |
|---|---|---|
| FR-001 | The system shall allow the creation of a Pet Profile (Name, Species, Breed, Birthday, Microchip ID). | High |
| FR-002 | The system shall display a dashboard summarizing the active pet's upcoming vaccinations and due medications. | High |

### 1.2 Vaccinations & Records (FR-011 to FR-020)
| ID | Requirement | Priority |
|---|---|---|
| FR-011 | The system shall allow users to log vaccinations (Name, Administered Date, Expiration Date, Vet Clinic). | High |
| FR-012 | The system shall visually highlight vaccinations that expire within the next 30 days (Yellow) or have already expired (Red). | High |

### 1.3 Medications & Reminders (FR-021 to FR-030)
| ID | Requirement | Priority |
|---|---|---|
| FR-021 | The system shall allow users to log recurring medications (e.g., Monthly on the 1st). | High |
| FR-022 | The system shall schedule local OS push notifications for due medications. | High |
| FR-023 | The system shall provide a 1-tap "Mark as Given" button that logs the timestamp and reschedules the next occurrence. | High |

### 1.4 Weight Tracking (FR-031 to FR-040)
| ID | Requirement | Priority |
|---|---|---|
| FR-031 | The system shall allow users to log their pet's weight (lbs/kg) on a specific date. | High |
| FR-032 | The system shall display a line chart of the weight history. | Medium |

### 1.5 Premium Features (FR-041 to FR-050)
| ID | Requirement | Priority |
|---|---|---|
| FR-041 | The system shall lock the creation of >1 Pet Profile behind a $14.99 one-time Premium unlock. | High |
| FR-042 | The system shall lock unlimited recurring medications behind Premium. | High |
| FR-043 | The system shall allow Premium users to generate a "Pet Passport" PDF containing the microchip ID and all active vaccination records. | Critical |

## 2. Non-Functional Requirements
- **Privacy:** Zero backend. All pet data must remain strictly on-device.
- **Offline:** 100% functionality (including PDF generation and scheduled reminders) must work without an internet connection.
- **Accessibility:** Support dynamic text sizing and screen readers.