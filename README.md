# 📱 Flutter Social App

This is a **Mini Social App** built using **Flutter** and **Firebase**. It offers core features of a social networking platform including user authentication, post creation, real-time chat, and profile management. The app demonstrates effective use of Flutter widgets, Firebase integration, and clean architectural practices.

---

## 📌 Table of Contents

* [Features](#features)
* [Screens](#screens)
* [Architecture](#architecture)
* [Technologies Used](#technologies-used)
* [Setup and Installation](#setup-and-installation)
* [Demo](#demo)
* [License](#license)

---

## ✅ Features

* User Authentication (Login & Register)
* Real-time Messaging (One-to-one chat)
* Create and Share Posts
* Edit User Profile
* View Posts Feed
* Responsive UI and Smooth Navigation

---

## 📸 Screenshots

Screenshots are located in the `Project_Images` directory:

| Home Screen                                          | Home Screen 2                                          | Edit Profile Screen                                    
| ---------------------------------------------------- | ------------------------------------------------------ | ------------------------------------------------------ |
| ![](Project_Images/Home%20Screen.png)                | ![](Project_Images/Home%20Screen%202.png)              | ![](Project_Images/Edit%20Profile%20Screen.png)        |

| Chats Screen                                          | Chat Screen                                           | Create Post Screen                                     |
| ----------------------------------------------------- | ------------------------------------------------------| ------------------------------------------------------ |
| ![](Project_Images/Chats%20Screen.png)                | ![](Project_Images/Chat%20Screen.png)                 | ![](Project_Images/Create%20Post%20Screen.png)         |

---

🎬 **Video Demo**:  
You can also check out a short demo video here:  
📽️ `Project_Images/Video Demo.webm`


## 🧱 Architecture

The project follows a layered architecture:

* **Presentation Layer**: Flutter UI with Cubit for state management.
* **Business Logic Layer**: Handles state transitions and business rules.
* **Data Layer**: Communicates with Firebase Firestore and Firebase Auth.

State is managed using **Cubit (from Bloc)** package ensuring a scalable and testable structure.

---

## 🛠️ Technologies Used

* **Flutter**
* **Dart**
* **Firebase Authentication**
* **Firebase Firestore**
* **Firebase Storage**
* **Cubit (Bloc)**
* **Cloud Firestore Rules** for data validation

---

## ⚙️ Setup and Installation

### 🔧 Prerequisites

* Flutter SDK installed ([Installation Guide](https://flutter.dev/docs/get-started/install))
* Firebase account and project created

### 🚀 Steps

1. **Clone the repository**

```bash
git clone https://github.com/kirlousHelal/social_app_flutter.git
cd social_app_flutter
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Set up Firebase**

* Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.
* Add Android/iOS platforms.
* Download `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and place it in the appropriate directory.
* Enable **Authentication** (Email/Password).
* Set up **Cloud Firestore** with required rules.
* Enable **Storage** if image uploads are used.

4. **Run the application**

```bash
flutter run
```

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Made with ❤️ by [Kirlous Helal](https://github.com/kirlousHelal)
