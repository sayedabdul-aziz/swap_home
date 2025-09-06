# Notification Badge Animation in Flutter

## 📌 Project Overview
This project demonstrates a **custom notification counter badge** implementation in Flutter with smooth animations.  
The badge appears with an intro animation, swings slightly, and finally disappears with a scale-down & fade-out effect towards the top triangle pointer.  

It is designed to be reusable and can be easily integrated into any app (e.g., above a notification icon).

---


---

## ✨ Features Implemented
- **Intro Animation**:
  - Scale from 0 → 1
  - Smooth Y-axis rotation
- **Swing Animation**:
  - Gentle swing motion to grab user attention
- **Fade Out Animation**:
  - Badge smoothly shrinks and disappears into the small top triangle
- **Custom Painter**:
  - Badge drawn with rounded rectangle + top pointer
- **Configurable Properties**:
  - Intro duration
  - Swing duration
  - Fade-out duration
  - Start & end angles
  - Scale factors

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>= 3.32.0 recommended)
- Dart SDK
- Android Studio / VS Code

### Installation
1. Clone the repo:
   ```bash
   git clone https://github.com/sayedabdul-aziz/swap_home.git
   cd notification-badge
   flutter pub get
   flutter run


## 🛠️ Tech Stack

Flutter (UI framework)

CustomPainter (for badge shape)

AnimationController + TweenSequence (for animations)
