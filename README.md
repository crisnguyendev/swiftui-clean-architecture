# Dishcovery

Dishcovery is an iOS application built with SwiftUI that follows Clean & Modular Architecture principles. The app leverages the Spoonacular Food API to help users discover, search, and explore delicious recipes and food-related content. It is designed to work seamlessly across multiple environments (Production, Development, Staging) and supports advanced features such as offline caching, pagination, internationalization, accessibility, dependency injection, and dependency management via Swift Package Manager.

---

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
  - [Core Module](#core-module)
  - [Modular Structure & Feature Breakdown](#modular-structure--feature-breakdown)
- [Environment & Build Configuration](#environment--build-configuration)
- [API Integration](#api-integration)
- [Testing](#testing)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

---

## Features

- **Discover Recipes:** Browse a curated list of recipes.
- **Search Functionality:** Search recipes by name or ingredients.
- **Detailed Recipe Information:** View details like ingredients, instructions, nutritional facts, and more.
- **Offline Support & Caching:** Work offline seamlessly using locally cached data.
- **Paging & Refresh:** Integrated support for load-more pagination and pull-to-refresh actions.
- **Multi Environment Support:**  
  - Build variants managed with Xcconfig files, custom Info.plist keys, and defined schemes.
  - Supports product flavors using multi-target configurations.
- **Internationalization & Localization:** Centralized string catalog for managing localized content.
- **Accessibility:** Utilizes SwiftUI’s default behavior to ensure an inclusive user experience.
- **Robust Testing:**  
  - **Unit Testing:** Implemented with XCTest.
  - **UI Testing:** Automated with XCUITest.
- **Clean & Modular Architecture:**  
  - **Core Module:** Built on protocol-oriented abstractions for easy library replacement and implementation modifications.
  - **Feature Modules:** Organized by functionality (e.g., Menu, Search) with dedicated layers.
- **Advanced Networking & Logging:**  
  - **Network:** Powered by Alamofire with support for interceptors (authorization, retry, and SSL pinning).
  - **Logger:** Uses SwiftyBeaver for advanced logging.
- **Security:**  
  - Token manager to support OAuth/JWT integration in the future.
  - Secure data storage using KeychainService.
- **Common Resources:**  
  - Extensions for colors, fonts, dimensions, modifiers, and localized strings.
- **Dependency Injection:** Supports dependency injection for decoupled, modular, and testable code.
- **Dependency Management:** Uses Swift Package Manager (SPM) to manage dependencies, frameworks, and libraries.

---

## Architecture

Dishcovery is structured with a focus on separation of concerns, ensuring that each component is independent, testable, and easily replaceable.

### Core Module

The **Core** module provides the essential services and common resources for the entire application. It is entirely built on protocol-oriented abstractions so that libraries or implementations (e.g., networking, logging, caching) can be replaced with minimal impact on the overall project.

- **Logger:** Utilizes [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver) for flexible logging.
- **Networking:** Uses [Alamofire](https://github.com/Alamofire/Alamofire) to handle network requests with support for interceptors that manage:
  - **Authorization:** Attaching tokens automatically.
  - **Retry Logic:** Managing transient failures.
  - **Security:** Implementing SSL pinning.
- **Common Resources:**  
  - Shared extensions for UI elements (colors, fonts, dimensions, modifiers).
  - A centralized system for localized strings.
- **Security Services:**  
  - Token Manager for future OAuth/JWT integration.
  - KeychainService for secure data storage.

### Modular Structure & Feature Breakdown

The project is divided into distinct modules:

- **Core:** Contains shared services and infrastructure components.
- **Features:** Each feature is self-contained and adheres to Clean Architecture principles, breaking down into:
  - **Domain:**  
    - **Entities:** Define core data models.  
      *Example:* `MenuItem` and `Serving` are defined to model menu data.
    - **Use Cases:** Contain business logic.  
      *Example:* The `FetchMenuItemsUseCaseProtocol` defines a use case to fetch menu items:
      ```swift
      import Foundation

      protocol FetchMenuItemsUseCaseProtocol {
          func execute(query: String, offset: Int, number: Int) async throws -> [MenuItem]
      }
      ```
  - **Data:**  
    - Implements the repository pattern to abstract data access.
    - Combines remote API calls with local caching strategies for offline support.
  - **Presentation:**  
    - Follows the MVVM pattern.  
      - **ViewModel:** Manages state, search inputs, pagination (load more and pull-to-refresh), and offline data handling.
      - **View:** SwiftUI views that display data and manage user interactions.

#### Feature: Menu

The **Menu** feature allows users to search menus by name, even when offline. Key aspects include:

- **Search by Name:**  
  Users can search for menus using keywords. The search functionality leverages the `SearchMenuByNameUseCase`.
  
- **Offline Support & Caching:**  
  Fetched menu data is cached locally (using SwiftData and other caching strategies) to provide a seamless offline experience.
  
- **Paging Integration:**  
  Implements pagination to handle large datasets:
  - **Load More:** Automatically loads additional data as the user scrolls.
  - **Pull-to-Refresh:** Allows users to refresh the menu list to fetch the latest data.

*Refer to the project code for detailed implementations in the `Features/Menu` folder, including `MenuItem.swift`, `MenuRepository.swift`, `MenuViewModel.swift`, and associated files.*

---

## Environment & Build Configuration

Dishcovery supports multiple build environments and product flavors:

- **Multi Environment Support:**
  - **Xcconfig Files:** Manage different configurations (Production, Development, Staging).
  - **Custom Info.plist Keys:** Define environment-specific settings.
  - **Xcode Schemes:** Predefined schemes for each environment streamline the build process.
- **Product Flavor Support:**  
  - Multi-target configurations allow for different product flavors with customized features or branding.

---

## API Integration

Dishcovery integrates with the [Spoonacular Food API](https://spoonacular.com/food-api) to retrieve recipes and food-related data.

1. **Sign Up & API Key:**
   - Register at the Spoonacular API page to obtain your API key.
   - Store your API key securely in a configuration file (e.g., `Secrets.plist`) or via environment variables.
2. **Data Layer Integration:**
   - The repository combines remote API calls with local caching to ensure data is available offline and updated in real-time when online.

---

## Testing

- **Unit Testing:**  
  - Use XCTest to validate business logic and component behavior.
- **UI Testing:**  
  - Implement automated tests with XCUITest to ensure a smooth user experience.
- **Multi Environment Testing:**  
  - Leverage different Xcconfig files and schemes to test across Production, Development, and Staging environments.

---

## Todo List: Coming soon...

1. **Integrate Analytics Frameworks**
   - **User Behavior Tracking:**
     - Add frameworks like Adobe Analytics or Firebase Analytics to monitor user behavior.
     - Track events such as `recipe_viewed`, `menu_searched`, and `menu_item_selected`.
   - **App Performance Monitoring & Crash Reporting:**
     - Use Firebase Crashlytics, Sentry, or AppDynamics to monitor app crashes and performance.
     - Set up alerts for critical crashes and performance bottlenecks.

2. **Integrate Remote Configuration System**
   - Add tools like Firebase Remote Config or LaunchDarkly for A/B testing and feature flagging.
   - Enable staged rollouts and dynamically control feature availability without app updates.

3. **Integrate CI/CD System**
   - Set up Jenkins, Fastlane, or GitHub Actions for automated builds, testing, and deployments.
   - Automate app delivery to App Store Connect for efficient release management.

4. **Feature Rollout Management**
   - Integrate with LaunchDarkly or similar tools for percentage-based rollouts, targeted user releases, version-specific features, and dependency-based rollouts.

---

## Usage

1. **Launch the App:**
   - Open the project in Xcode and run it on your preferred simulator or device.
2. **Explore & Search Menus:**
   - Use the search bar in the Menu feature to find menus by name.
   - Experience smooth paging with load-more and pull-to-refresh functionalities.
3. **Offline Capabilities:**
   - Enjoy continuous access to cached menu data even when offline.

---

## Contributing

Contributions to Dishcovery are welcome! To contribute:

1. **Fork the Repository.**
2. **Create a New Branch:**

   ```bash
   git checkout -b feature/YourFeatureName
   ```

3. **Commit Your Changes.**
4. **Push to Your Fork:**

   ```bash
   git push origin feature/YourFeatureName
   ```

5. **Open a Pull Request:**
   - Provide a clear description of your changes and reference any related issues.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- **[Spoonacular Food API](https://spoonacular.com/food-api):** For providing extensive food-related data.
- **[SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver):** For advanced logging capabilities.
- **[Alamofire](https://github.com/Alamofire/Alamofire):** For robust networking features.
- **[crisnguyendev/swiftui-clean-architecture](https://github.com/crisnguyendev/swiftui-clean-architecture):** For the foundational project structure and Clean Architecture implementation.

---

Happy coding and enjoy exploring Dishcovery!
