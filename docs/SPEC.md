# PetPulse Product Spec

## 1. Product Identity

### 1.1 Working Product Name
PetPulse (Digital Pet Passport)

### 1.2 Product Category
Mobile utility for managing a pet's medical and routine health data.

### 1.3 Product Type
Privacy-first, offline iOS and Android app built with React Native and Expo.

### 1.4 Core Identity Statement
Managing a pet's vaccinations, weight trends, and flea/tick medication schedules is often done via messy physical paper cards or complex, cloud-dependent vet portals that are impossible to use. PetPulse is a beautiful, offline-first digital passport. You input your pet's data once, and you always have the exact date of their last Rabies shot or their current weight in your pocket. 

## 2. Vision Statement

The pet care app market is full of overly complex social networks or subscription services that charge $5/month just to remind you to give your dog their heartworm pill. PetPulse is the definitive "buy it once, own it forever" utility. It relies on local storage and native OS reminders, completely bypassing the need for a server.

## 3. Core Concept

The user opens the app and sees a "Pet Profile" dashboard (e.g., "Luna").
The dashboard features three primary tabs:
1. **Records:** A chronological list of vaccinations (Rabies, DHPP, Bordetella) and their expiration dates.
2. **Medications:** A list of active/recurring meds (Heartworm, Flea/Tick) with a toggle to mark "Given Today."
3. **Vitals:** A simple line chart tracking the pet's weight over time.

When it's time for a medication, a local push notification fires. When visiting a new vet or boarding facility, the user taps "Generate Passport," creating a clean PDF summary of all active records.

## 4. Target Audience
- New pet owners overwhelmed by vaccination schedules.
- Multi-pet households struggling to remember which dog got which pill.
- People who frequently travel with or board their pets and need instant access to health records.

## 5. Monetization Strategy

**Freemium (One-Time IAP)**
- **Free Tier:** 1 Pet Profile. Basic weight tracking. Good for single-pet owners wanting to test the app.
- **Premium Tier ($14.99 One-Time):** Multiple Pet Profiles. Unlimited recurring medication reminders. The "PDF Passport" export engine.
- **Why this maximizes revenue:** Multi-pet owners feel the pain of disorganization acutely. A one-time $15 charge is a no-brainer compared to the anxiety of missing a heartworm dose or losing a paper vaccination record. Zero server costs = 100% margin.

## 6. Marketing & User Acquisition Strategy
**Classification:** Tier 2 Smart Utility (High Emotional Attachment)
**Primary Ad Platforms:** Pinterest & Instagram.
**Targeting:** Dog/Cat owners, frequent travelers.
**Core Hook:** "Stop losing your paper vaccine records before boarding. Never miss a heartworm pill again."
**Geographic Strategy:** High adoption in US/UK/AUS. 

