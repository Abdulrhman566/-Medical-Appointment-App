# 🩺 Medical Appointment App

A Flutter application designed to connect doctors and patients through a simple, user-friendly medical platform. Built with Flutter and Firebase, the app provides account selection, authentication, and profile management for both doctors and patients.

## ✨ Features

- 👨‍⚕️ **Doctor & Patient Selection** — Choose the appropriate account type.
- 🔐 **Firebase Authentication** — Register and log in using email and password.
- 📝 **User Registration** — Create accounts with form validation.
- 🏥 **Doctor Profiles** — Store name, email, and medical specialty.
- 👤 **Patient Profiles** — Store name and email.
- ☁️ **Cloud Firestore** — Save user profile information in separate collections.
- 🔑 **Password Recovery** — Request a password reset email.
- 👁️ **Password Visibility** — Show or hide passwords.
- ⏳ **Loading Indicators** — Display progress during authentication.
- 💬 **Error Handling** — Show helpful messages for authentication errors.
- 🇪🇬 **Arabic UI** — Arabic text and an RTL-friendly login interface.
- 🎨 **Modern UI** — Styled forms, rounded buttons, and a healthcare-themed design.

## 🛠️ Technologies Used

- **Flutter** — Cross-platform application development.
- **Dart** — Programming language.
- **Firebase Authentication** — User authentication.
- **Cloud Firestore** — User profile storage.
- **Material Design** — UI components and styling.

## 📱 Application Flow

1. Open the app and select Doctor or Patient.
2. Navigate to the login screen.
3. Log in with an existing account or create a new one.
4. During registration, provide the required information.
5. Save the profile in Cloud Firestore according to the selected role.
6. Use the password recovery option if needed.

## 🗂️ Firestore Database Structure

### Doctors Collection

```text
doctors/
  {uid}/
    uid
    name
    specialist
    email
    createdAt
```

### Patients Collection

```text
patients/
  {uid}/
    uid
    name
    email
    createdAt
```

Each profile document uses the user's Firebase Authentication UID as its document ID.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Visual Studio Code or Android Studio
- A Firebase project
- An Android emulator or compatible device

### 1. Clone the repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd session_26_9
```

Replace `<YOUR_GITHUB_REPOSITORY_URL>` with your actual GitHub repository URL.

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. Register your Flutter application with Firebase.
3. Configure Firebase for your target platform.
4. Initialize Firebase in `main.dart` before calling `runApp()`.
5. Enable **Email/Password** under Firebase Authentication sign-in providers.
6. Create a Cloud Firestore database.
7. Configure Firestore security rules to protect user information.

If you use FlutterFire CLI, generate your Firebase configuration with:

```bash
flutterfire configure
```

### 4. Add application assets

Make sure these image assets exist in your project:

```text
assets/
└── images/
    ├── Glossy Blue Healthcare Cross Emblem.png
    └── istockphoto-1179610553-1024x1024.jpg
```

Register the assets in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

### 5. Run the application

```bash
flutter run
```

## 🔒 Security Considerations

- Configure Firestore rules to prevent unauthorized access to patient and doctor information.
- Verify the user's stored role before navigating to role-specific pages.
- Do not rely solely on the role selected in the UI for authorization.
- Handle situations where account creation succeeds but saving the Firestore profile fails.
- Never commit Firebase service-account private keys to GitHub.

## 🔮 Future Improvements

- Doctor and patient dashboards.
- Doctor search by name and specialty.
- Appointment scheduling and booking.
- Appointment management and cancellation.
- Doctor availability calendars.
- User profile editing.
- Appointment reminders and notifications.

## 👨‍💻 Author

Developed as a Flutter and Firebase learning project.

## ⭐ Support

If you find this project useful, consider giving the repository a star!
