# Dishcovery

Dishcovery is an iOS application built with SwiftUI that follows Clean & Modular Architecture principles. The app leverages the Spoonacular Food API to help users discover, search, and explore delicious recipes and food-related content. It is designed to work seamlessly across multiple environments (Production, Development, Staging) and supports advanced features such as offline caching, pagination, internationalization, accessibility, dependency injection, and dependency management via Swift Package Manager.

---

## Table of Contents

- [Features](#features)
- [Coming Soon](#coming-soon)
- [Architecture](#architecture)
  - [Core Module](#core-module)
  - [Modular Structure & Feature Breakdown](#modular-structure--feature-breakdown)
    - [Clean Architecture Structure](#clean-architecture-structure)
    - [Presentation Patterns](#presentation-patterns)
- [Design Tradeoffs](#design-tradeoffs)
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
- **Search Menu:** Search menu items by name with robust offline caching and pagination support.
- **Search Recipe:** Search recipes by name or ingredients using a dedicated API service.
- **Detailed Recipe Information:** View details like ingredients, instructions, nutritional facts, and more.
- **Offline Support & Caching:** Work offline seamlessly using locally cached data.
- **Paging & Refresh:** Integrated support for load-more pagination and pull-to-refresh actions.
- **Multi Environment Support:**  
  - Build variants managed with Xcconfig files, custom Info.plist keys, and defined schemes.
  - Supports product flavors using multi-target configurations.
- **Internationalization & Localization:** Centralized string catalog for managing localized content.
- **Accessibility:** Utilizes SwiftUI’s default behavior to ensure an inclusive user experience.
- **Robust Testing:**  
  - **Unit Testing:** Implemented with XCTest, covering critical components such as use cases (business logic), ViewModels (interaction between view and domain), and repository tests (logic in the data layer).
  - **UI Testing:** Coming soon.
- **Clean & Modular Architecture:**  
  - **Core Module:** Built on protocol-oriented abstractions for easy library replacement and implementation modifications.
  - **Feature Modules:** Organized by functionality (e.g., Menu, Recipe) with dedicated layers.

---

## Coming Soon

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
   - Use **Fastlane + Jenkins** to support large-scale projects and ensure consistent CI/CD practices across teams (e.g., backend, frontend) in enterprise environments.

4. **Feature Rollout Management**
   - Integrate with LaunchDarkly or similar tools for percentage-based rollouts, targeted user releases, version-specific features, and dependency-based rollouts.

5. **Apply MVI Pattern for Menu**
   - Explore applying the Model-View-Intent (MVI) pattern for the Menu feature to reflect that the presentation layer can be flexible and adaptable to either MVVM or MVI approaches.

---

## Architecture

Dishcovery is structured with a focus on separation of concerns, ensuring that each component is independent, testable, and easily replaceable.

### Core Module

The **Core** module provides the essential services and common resources for the entire application. It is built entirely on protocol-oriented abstractions so that libraries or implementations (e.g., networking, logging, caching) can be replaced with minimal impact on the overall project. Key examples include:

- **Networking Services:**  
  - **Menu Feature:** Uses `AlamofireNetworkService` for calling the API.
  - **Recipe Feature:** Uses `URLSessionNetworkService` for calling the API.  
    Both services conform to the same `NetworkServiceProtocol`, making them interchangeable.
  
- **Persistent Service Layer:**  
  The persistent layer is abstracted through protocols, allowing it to be swapped between SwiftData, CoreData, Realm, or any other framework in the future.

### Modular Structure & Feature Breakdown

The project is divided into distinct modules:

- **Core:** Contains shared services and infrastructure components.
- **Features:** Each feature is self-contained and adheres to Clean Architecture principles, breaking down into several layers:

#### Clean Architecture Structure

- **Domain Layer:**
  - **Model:**  
    Defines the core business objects (e.g., `MenuModel`, `RecipeModel`, `ServingModel`). These models represent the data in its simplest form without any dependency on frameworks.
  - **UseCase:**  
    Encapsulates the business logic of the application. Use cases, such as `SearchMenuUseCaseProtocol` and `SearchRecipesUseCaseProtocol`, execute specific business actions like fetching data or processing user inputs.
  
- **Data Layer:**
  - **Repository:**  
    Provides a unified interface to access data by abstracting both remote API calls and local caching strategies.
  - **DTO (Data Transfer Object):**  
    Structures data for network transfers, ensuring that external data is properly mapped into the application's internal models.
  - **Entity (Persistent):**  
    Represents the data model tailored for persistence (e.g., using SwiftData, CoreData, or Realm) and may include additional persistence metadata.
  - **Adapter:**  
    Transforms DTOs into domain models and persistent entities, ensuring smooth data flow across layers.

#### Presentation Layer

- **View:**  
  SwiftUI views or other UI components responsible for displaying data.
  The View depends on the ViewModel but not vice versa. This decoupling means the ViewModel can be reused in various UI layers without being tightly bound to a specific view implementation.
- **ViewModel:**  
  Acts as an intermediary between the View and Domain layers, managing state, processing user inputs, and coordinating with use cases.
- **Coordinator:**  
  Manages navigation and the flow between different screens or modules, keeping navigation logic decoupled from the views.

#### Presentation Patterns

- **Recipe Feature (MVVM-C):**  
  Implements the Model-View-ViewModel-Coordinator pattern to promote modularity and clear navigation flows. The Coordinator handles screen transitions, while the ViewModel focuses on business logic.
- **Menu Feature (MVI):**  
  Adopts the Model-View-Intent pattern, using unidirectional data flow to manage reactive state and user interactions, especially useful for complex interactions like pagination and offline caching.

---

## Design Tradeoffs

Following Clean Architecture leads to a more structured and modular codebase, but it also creates more code and adds complexity to the project structure. For example, separating the domain model from persistent entities (Entity) and network models (DTO) may sacrifice some of the simplicity and direct integration benefits offered by SwiftData with SwiftUI. However, this separation makes the project significantly more flexible and scalable by decoupling it from any specific framework, ensuring that underlying technologies can be changed or upgraded at any time without impacting the core business logic.

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
  Implemented with XCTest, covering critical components:
  - **Use Cases:** Validate business logic by ensuring that core actions (e.g., fetching menu items or recipes) work as expected.
  - **ViewModels:** Ensure that the interaction between the view and domain is handled correctly, including state management, pagination, and user inputs.
  - **Repository Tests:** Cover logic in the data layer by testing repository implementations, ensuring correct integration of remote API calls, local caching, and data transformation through adapters.
- **UI Testing:**  
  - **Coming Soon:** Future releases will include UI testing using XCUITest to ensure a seamless user experience.
- **Multi Environment Testing:**  
  - Leverage different Xcconfig files and schemes to test across Production, Development, and Staging environments.

---

## Usage

1. **Launch the App:**
   - Open the project in Xcode and run it on your preferred simulator or device.
2. **Explore & Search Menus and Recipes:**
   - Use the search bars in the Menu and Recipe features to find content by name or ingredients.
   - Experience smooth paging with load-more and pull-to-refresh functionalities.
3. **Offline Capabilities:**
   - Enjoy continuous access to cached data even when offline.

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
