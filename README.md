# watch App
This document outlines the specifications and requirements for the Flutter application task during the internship process. The project involves creating a functional app with registration, login, and movie list features, using the **Parse Platform API** for backend and local database integration.

---

## **Task Overview**

The application consists of two main screens:

1. **Login Screen**:  
   - Includes input fields for username and password.
   - Buttons to either register a new user or log in with existing credentials.

2. **Dashboard Screen**:  
   - Displays a scrollable list of movies retrieved from a remote database.
   - Shows details for each movie, such as the title, description, and additional movie information.

---

## **Requirements**

### **1. Login Functionality**
- Allow user registration with a unique username and password.
- Enable users to log in using their registered credentials.

### **2. Remote Database Integration**
- Use the **Parse Platform API** for backend services.
- Store and retrieve movie list data locally using a caching mechanism.

---

## **Implementation**

### **1. Technology Stack**
- **Frontend**: Flutter for cross-platform development.
- **Backend**: Parse Platform API for data fetching and local storage management.

### **2. User Interface**
- Design the UI as per the provided wireframes.
- Ensure the app is responsive across various screen sizes.

### **3. Code Quality**
- Write clean and modular code.
- Add comments to explain the purpose of functions and components.

---

## **Features**

### **Main Functionality**
1. **Movies List**:
   - Fetch and display movies with pagination.
2. **Details Navigation**:
   - View detailed information about a movie.
3. **Pagination**:
   - Navigate through pages of movies using arrow buttons.

---

## **Architecture Overview**

### **1. Login to MainView Navigation**
- Upon successful login, the app navigates to `MainView` using a custom router.

### **2. Dependency Injection Setup**
- Use `initHomeModule()` to set up necessary dependencies, such as `HomeUseCase` and `MainViewModel`.

### **3. State Management with Provider**
- Use `ChangeNotifierProvider` to manage state updates and notify UI components reactively.

### **4. Data Fetching Flow**
1. **Start Method**:
   - Initiates data loading in `MainViewModel`.
2. **Repository Pattern**:
   - Fetch data from the local database first. If unavailable, retrieve it from the remote API via `AppServiceClient`.

### **5. Error Handling**
- Handle API response errors gracefully using the `Either` type.

---

## **Packages Used**

| Package                     | Version | Purpose                                                                 |
|-----------------------------|---------|-------------------------------------------------------------------------|
| **Lottie**                  | 3.1.3   | Provides animated illustrations.                                       |
| **Freezed Annotation**      | 2.4.4   | Helps create immutable data models.                                    |
| **Dartz**                   | 0.10.1  | Functional programming utilities for safe data handling.               |
| **Json Annotation**         | 4.9.0   | Facilitates JSON serialization.                                        |
| **Internet Connection Checker** | 1.0.0+1 | Checks for active internet connections.                                |
| **Dio**                     | 5.7.0   | Handles HTTP requests.                                                 |
| **Pretty Dio Logger**       | 1.4.0   | Logs API requests for debugging.                                       |
| **Get It**                  | 8.0.2   | Service locator for dependency injection.                              |
| **Flutter Phoenix**         | 1.1.1   | Allows app restarts for session management.                            |
| **Provider**                | 6.1.2   | Simplifies state management.                                           |
| **Shared Preferences**      | 2.3.3   | Stores simple key-value pairs locally.                                 |
| **Easy Localization**       | 3.0.7   | Adds localization and internationalization.                            |

---

## **Development Tools**

| Tool                     | Version          |
|--------------------------|------------------|
| **Flutter**              | 3.24.3 (stable) |
| **Dart SDK**             | 3.3.4 (stable)  |
| **Android SDK**          | 34.0.0          |
| **Android Studio**       | 2024.2          |
| **VS Code**              | 1.95.2          |
| **OpenJDK**              | 17.0.8.1        |
| **Gradle**               | 8.4             |
| **OS**                   | Windows 10      |

---

## **Resources**

- [Parse Platform API for Flutter Documentation](https://api.themoviedb.org/3)  
- Official Flutter Documentation: [flutter.dev](https://flutter.dev)  

---

This document ensures clarity in the implementation and provides a structured approach to completing the task efficiently.
