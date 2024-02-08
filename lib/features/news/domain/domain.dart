

String domainLayer = '''

    2. Domain Layer
    
    This layer contains the business logic of your application and is 
    framework-independent. It defines use cases and entities
    (if your entities differ from your data models).
     
    Entities:
    If needed, you can define entities that are independent of your
    models. This is useful if your data layer models do not fit your business
    logic needs perfectly.
    
    Use Cases: 
    
    Define use cases that represent actions your application 
    can perform. For example, you might have a 
    GetTeslaNews, GetTechCrunchNews, and GetWallStreetNews use cases. 
    These use cases would use the repositories to fetch the data.
     ''';
