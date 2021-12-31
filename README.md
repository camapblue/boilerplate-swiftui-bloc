# boilerplate-swiftui-bloc

Boilerplate iOS Project with SwiftUI & Bloc Pattern

## Getting Started

This project is a iOS app of Boilerplate that building by Swift.

## Awareness
- Always think about the milion users are using this app, so it must be the **World Class** app
- Coding is not just feature done, it's the **reflection of success**
- To get the best quality, must have the **best solution**
- Always think about & follow up **SOLID principal** for every solutions
- Naming is **VERY VERY IMPORTANT**, it's not coding, it's solution

## Architecture

Apply Clean Architecture + BloC pattern 
```
|-----------------  Layers  -----------------|
| Presentations | Business Logic | Data Layer|
|:------------------------------------------:|

|--------------------------  Actual  ---------------------------|
| Presentations  |      Business Logic    |         Data        |
|:-------------------------------------------------------------:|
| Module <--> Bloc <--> Service <--> Repository <--> Client/Dao |
|:-------------------------------------------------------------:|
|:----  Extension Entity   ----|----    Basic Entity   --------:|
|:-------------------------------------------------------------:|
```
### Module
- This is the major view layer of iOS app and is categorized by module (feature or epic). 
- View is rendered based on the bloc state if needed. 
- View that are used across module will be placed in *CommonUI folder* and **MUST NOT** build based on bloc state.
- A view or screen can have multiple blocs to control UI's state or no blocs at all.

Examples of a standard view that build based on bloc states:
```swift
    private var contactListBloc: LoadListBloc<Contact>
    
    init(contactListBloc: LoadListBloc<Contact>) {
        self.contactListBloc = contactListBloc
        contactListBloc.add(event: LoadListStarted())
    }
    
    var body: some View {
        NavigationView {
            LoadListView<Contact, Text>(bloc: contactListBloc) { contact in
                Text(contact.firstName)
            } itemKey: { $0.id }
        }
    }
```

### Bloc
- It's the main stateful layer that keep all app's state and data.
- Data must keep in State class, not in bloc itself 
- Bloc can handle all UI's business, such as proceed an user's action, control loading flow or update new language, ... All UIs that need update by state, it's responsible of Bloc
- Bloc is managed through by BlocManager, control constructor and dispose, communicate between blocs by add event or listen state changes, and even for broadcast on global channel
- The naming convention to define Event and State class can reference [here](https://bloclibrary.dev/#/blocnamingconventions)
- State class **MUST** be extended by Equatable, but Event class.
- BaseBloc is advanced class of Bloc to handle some generic business such as show/hide app loading (locked loading), handle callApi with common error handling.
- Bloc key is required for all blocs, use Constants to define key.
- Bloc can reference to multiple services to handle business, but less is better.

Example of Bloc new instance:
```swift
    func contactListBloc() -> LoadListBloc<Contact> {
        let key = Keys.Bloc.contactList
        let bloc = BlocManager.shared.newBloc(LoadListBloc<Contact>.self, key: key) {
            return LoadListBloc<Contact>(
                key: key,
                service: Services().contactListService()
            )
        }
        return bloc as! LoadListBloc<Contact>
    }
```

and the constructor in DI class:
```swift
    SplashView(contactListBloc: Blocs().contactListBloc())
```

### Service
- It's the main layer to handle all data business
- It's a stateless layer, so it will be constructed on demand
- A service may contain many usecases that belong to a same module or epic
- A service can communicate with other services
- All services **MUST** be defined with an interface (abstract class), bloc communicate with service through by the interface 
- Constructor in Services class (DI class)

```swift
    class Services {
      func contactService() -> ContactService {
          return ContactServiceImpl(contactRepository: Repository.shared.contactRepository())
      }

      // list service
      func contactListService() -> LoadListService<Contact> {
          return ContactListServiceImpl(contactRepository: Repository.shared.contactRepository())
      }
  }
```

### Repository
- It's imported from local framework project name *Repository*
- The main data source of app that is used by service layer
- It's a stateless layer, so it will be constructed on demand
- It contains a little bit business rules to branch data source that should be used, from client or dao
- It also handle the caching logic rules, from memory or local storage
- All repositories **MUST** be defined with an interface (abstract class), service communicate with repository through by the interface 
- Constructor in Repository class (DI class)

```swift
    public class Repository {
        public static let shared = Repository()

        // Repository
        public func contactRepository() -> ContactRepository {
            return ContactRepositoryImpl(
                contactDao: contactDao(), contactApi: contactApi()
            )
        }

        // Api
        func contactApi() -> ContactApi {
            return ContactApiImpl()
        }

        // Dao
        func contactDao() -> ContactDao {
            return ContactDaoImpl()
        }
    }
```

### Client/Dao
- It's data source layer, client means data is from RestFul API and Dao means data is from local storage
- BaseAPI is advanced class to handle all generic calling API, retry when access token is expired and need to refresh, also for general API error handling
- BaseDao is advanced class to handle the generic storage, save/get list or item, or even for a string or an integer
- All APIs & Dao **MUST** be defined with an interface (abstract class), repository communicate with api/dao through by the interface 

### Model
- It covers all entities in app
- Have 2 kind of models, basic entity and extension entity.
- Basic entity is belong to repository, it defines all entity's properties and support basic parsing with JSON
- Extension entity is belong to UI layer, it defines all utility methods of an entity
- All entity **MUST** extended by Equatable that useful in smart comparation

## Dependencies Injection
- There are 3 kinds of class to support construct instance for DI, BlocManager, Services and Repository
- BlocManager is a singleton class that not only work as a bloc manager but also support to provider bloc instance. All constructor of bloc should be function inside Bloc class for easy to maintain.
- Services is a singleton class that provide the instance of service.
- Repository is a singleton class that provide the instance of repository, api & dao

## Code Structure
Here is list all of key folders or files in code structure:
```
.
|-- environments                        *setup all configs that based on the environment, using .ENV file*
|   |-- dev                             *Development environment*
|   |-- prod                            *Production environment*
|   |-- qc                              *Testing environment*
|-- boilerplate-swiftui-bloc            *store all assets that are font, icon, image, video or animation*
|   |-- boilerplate-swiftui-bloc
|   |   |-- Bloc                            *all blocs that need in project*
|   |       |-- language                    *each bloc has a folder with name of bloc only*
|   |           |-- language_bloc.dart      *the Bloc class that extends of BaseBloc*
|   |           |-- language_event.dart     *define all Event class, must follow the naming convention strongly*
|   |           |-- language_state.dart     *define all State class that extends of Equatable, must follow the naming convention*
|   |           |-- language.dart           *the index file that export all files in bloc folder*
|   |   |-- Extensions                      *All foundation extensions class, such as String, Int, Date, ...
|   |   |-- Global                          *define all constant values such Keys, Strings, ...*
|   |   |-- Model                           *define all extension entities and all entities that need in UI layer*
|   |   |-- Modules                         *define all UI Views that categorized by module or epic*
|   |   |-- Service                         *define all service classes*
|   |   |-- Utils                           *define all utility classes*
|   |   |-- CommonUI                        *define all common Views and can use across modules but not use bloc inside*
|   |   |-- boilerplate_swiftui_blocApp.swift                       *the main class that app launch from*
|   |-- boilerplate-swiftui-blocTests
|-- Repository
|   |-- Repository
|   |   |-- Api                         *define all api classes*
|   |   |-- Dao                         *define all dao classes*
|   |   |-- Enum                        *define all enum*
|   |   |-- Model                       *define all basic entities*
|   |   |-- Repository                  *define all repository classes*
|   |   |-- Repository.swift            *Repository class, singleton class that support DI for data layer*
|   |-- RepositoryTests                 *unit testing for repository, require testing for repositorry only*
```

## Storybook


## Router


## Environment
- All configurations data **MUST** set in .evn files, includes configurations for UI layers, service layers, repository layers, and even for common package.
- Configs class, a singleton class is set for all packages that need to load configuration data
- For testing purpose, the configuration data should be passed as parameters in constructor of class instead of hard using.

To run app with setting new environment for qc, run shell script:
```
  ./run.sh -e qc
```

For the next run with qc environement, it can be run normally with Flutter command `flutter run`

## Testing
- All Blocs **MUST** have unit testing for all Events and StreamSubscriptions, except static constructor.
- All Services **MUST** have unit testing for all public methods.
- All Repositories **MUST** have unit testing for all public methods.

## Logging
- Support logging for 6 standard levels of logs, here is lists (order by the priority of log)
  1. fatal: *for any issuse that kill the app or business*
  2. error: *for any exception that the app catch*
  3. warning: *for any potential error, invalid data or unexpected value that cause lead to error*
  4. info: *for log actions or events from end-user*
  5. debug: *for debug purpose and will not see in production, only see in development or testing mode*
  6. trace: *for tracking in order to identify bugs, do not keep it when bug is resolved*
- The logging level for each environment will be set in .env files
- The Log class is a singleton and be able to get from singleton instance of Common class
