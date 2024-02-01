# riverpod_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

[//]: # (    Clean Code)
    Clean Architecture is a software design philosophy that separates concerns 
    into independent layers, enhancing maintainability,
    scalability, and testability of an application. 

    The idea is to make the system easy to understand, develop, and test by separating the concerns 
    into layers.

    The Layers of Clean Architecture

    1. Entities:
    These are the core business objects of your application. 
    They are the least likely to change when something external changes. 
    example, if you're building a todo app, an entity might be a Todo class.

    2. Use Cases (Interactors):
    Use cases encapsulate all the business rules. 
    They should be independent of any external agency such as databases or web services. 
    This makes them independent of UI, database, framework, etc. 
    A use case for a todo app might be AddTodo, GetTodos, etc.
    
    3. Interface Adapters (Presenters, Controllers, Gateways): 
    This layer adapts data between the use cases and external agencies such as databases 
    or the web. It converts data from the format most convenient for use cases and entities, 
    to the format most convenient for external agencies, and vice versa.

    4. Frameworks and Drivers (UI, External Interfaces):
    This is where your Flutter widgets would live, along with any databases or 
    web services you use. This layer is the outermost layer and changes most frequently.

    Applying Clean Architecture in Flutter projects requires diligence and may introduce 
    more complexity upfront, but it pays off in long-term project health,
    especially for larger projects or teams.

    - 𝗗𝗼𝗺𝗮𝗶𝗻 𝗟𝗮𝘆𝗲𝗿: Contains your business logic and entities.
    - 𝗗𝗮𝘁𝗮 𝗟𝗮𝘆𝗲𝗿: Manages data access and storage.
    - 𝗣𝗿𝗲𝘀𝗲𝗻𝘁𝗮𝘁𝗶𝗼𝗻 𝗟𝗮𝘆𝗲𝗿: Handles UI and user interactions.


    Every architecture has one common thing — separation of concerns.

    Clean Architecture (CA) is an architectural pattern that was introduced by Robert C. Martin.

    The main idea behind Clean Architecture (CA) is to separate the application into 
    Three main layers:
    The **presentation layer, the domain layer, and the data layer.**

******************************************************************

[//]: # (DIP: Depency of Inversion)
    The Dependency Inversion Principle (DIP) is one of the key concepts in software engineering, especially when talking about writing maintainable and scalable code. In simple terms, DIP is about two main ideas:
    
    a. High-level modules should not depend on low-level modules. Both should depend on abstractions.

    This means that instead of having your business logic (high-level code) directly call or use 
    specific implementations of functions or classes (low-level code), both your high-level and 
    low-level modules should depend on interfaces or abstract classes. This way, you're not tying
    your core business logic to specific implementations, making your code more flexible and easier 
    to update or replace parts of it without affecting the rest.

    b. Abstractions should not depend on details. Details should depend on abstractions.

    This point emphasizes that the interfaces or abstract classes should not be designed based 
    on the details of implementations. Instead, your implementations should be built to match 
    these abstractions.

    .**Example in the Context of Flutter**
    Imagine you're building a Flutter app that fetches news articles from an API. 
    According to DIP:
    - You would first define an abstract class or interface for fetching news, 
      say NewsRepository. This is your abstraction.

    - You would first define an abstract class or interface for fetching news,
      say NewsRepository. This is your abstraction.

    - Then, you implement this interface with a class that actually fetches the news from the API,
      say ApiNewsRepository.  Your high-level module, perhaps a news article screen, would depend on
      NewsRepository rather than ApiNewsRepository. This way, the screen doesn't care where the news
      comes from, as long as it gets news. This is **dependency inversion in action.**

    // Abstraction
    abstract class NewsRepository {
    Future<List<Article>> fetchArticles();
    }
    
    // Implementation
    class ApiNewsRepository implements NewsRepository {
    @override
    Future<List<Article>> fetchArticles() {
    // Fetch from API![Screenshot 2024-02-02 at 02.11.24.png](..%2F..%2FDesktop%2FScreenshot%202024-02-02%20at%2002.11.24.png)
    }
    }
    
    // High-level module depending on abstraction, not on concrete implementation
    class NewsScreen {
    final NewsRepository newsRepository;
    
    NewsScreen(this.newsRepository);
    
    void displayArticles() async {
    final articles = await newsRepository.fetchArticles();
    // Display articles
    }
    }

**In this example, NewsScreen (a high-level module) depends on NewsRepository (an abstraction), 
    not directly on ApiNewsRepository (a low-level module). This approach allows you to change
    the source of news articles (say from an API to a local database) with minimal changes 
    to your high-level code, enhancing maintainability and scalability.**

******************************************************************
    Flutter Clean Architecture (CA) abides by this rule. This typically entails utilizing
    abstract classes and interfaces in Flutter to specify the contracts across layers,
    facilitating easier testing and the flexibility of changing implementations.



















