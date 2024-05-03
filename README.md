# Answer Ai assignment

A project created in flutter using Bloc supports mobile platforms i.e. IOS and Andorid.

* The project is an assignmet to the Answers-AI <https://answersai.com/>.

## Getting Started

The project integrates anthropic AI within a clean architecture framework, leveraging Firebase Firestore for data storage. This setup enables human-like responses to user queries while ensuring scalability and maintainability through modular design principles.

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/a15056478/Ankur-Saini-AnswersAi-Flutter.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 3:**

Go to project main.dart or run this command. Make sure you are connected to a simulator or a physical device.

```
flutter run 
```

## Key

* Get The Anthropic api Secutiry from the owner of the project and replace in .env file

## App Features

* Splash
* Login
* Signup
* OTP verfication
* Home (Chat Page)
* Chat with AI

### Libraries & Tools Used

* [Bloc](https://pub.dev/packages/flutter_bloc)
* [Firestore](https://firebase.flutter.dev/) Database
* [Google Sign In](https://pub.dev/packages/google_sign_in) (To authenticate user with gmail)
* [Get It](https://pub.dev/packages/get_it) (Dependenc Injection)
* [internet_connection_checker_plus](https://pub.dev/packages/internet_connection_checker_plus) (To check internet status)
* [form_validator](https://pub.dev/packages/form_validator) (validate email and password)
* [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) (For responsiveness)
* [intl](https://pub.dev/packages/intl) (for Date formatting)
* [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) (To store key)
* [email_otp](https://pub.dev/packages/email_otp) (To send OTP on email)
* [anthropic] (<https://docs.anthropic.com/claude/docs/intro-to-claude>)

### Folder Structure

Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- common/
|- data/
|- model/
|- presentation/
|- widgets/
|- blocs_list.dart
|- main.dart
|- wrapper.dart
|- firebase_options.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```

1 - Common 
    a.Constants
    b. ThemeText - custom textstyles
    c. Utils - Common functions for logical operations

2 - Data
    a. Respository - Contains Onboarding and Chat repository 
    b. Use Cases

3 - Domain
    a. Dependency Injenction(di)
    b. Firebase - Firebase fuctions for user sign up, login, add chat, show history is defined in           firebase_config.dart
    c. Repository - Functions for Chat and Oboarding repository are declared here.

4 - Model - Contains data models required in the app for user and chat

5 - Presentation
    a. Blocs - Contain blocs for onbaording and chat operation
    b. Screens -  Contains all screesn for the app

6- Widget - Conatins common widgets for the app

```

### UI

-> Home Page - Main screen where user can chat
-> Login Page - For existing user registration
-> Signup Page -  For New user registration
-> OTP verification Page -  For new and old user email verification
