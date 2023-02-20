
# # CountryFlags

## Description
This is a proposed solution for a CodeChallenge about building an app that provides information about countries around the world. The app must display a list of countries (with their related flag) from which it is possible to access a detail screen showing information of a single country. 
These APIs can be used to retrieve the data:
- REST (https://restcountries.com/)
- GraphQL https://github.com/trevorblades/countries

These are Guidelines & Requirements: 
- Deployment target can be set to the latest iOS release.
- The supported device is iPhone only in portrait orientation.
- Swift 5.x must be used.
- External libraries can be used if the choice is adequately justified (e.g. it is recommended to use Apollo for the GraphQL API).

## Architecture
The architecture implemented its built on MVVM + Coordinator.
Every screen Its built around a ViewModel and a ViewController, with all the UI managed by a custom UIView attacched to the root of UIViewController. The Coordinator is responsible for the navigation between ViewControllers. Because there is no need about some fancy offline functionality, viewmodels are using directly the API services, wiuthout any abstraction layer between persistence and network services (like for example with a Repository Pattern).
For achieve better performance GraphQL API it's used instead of the REST API, so for example inside the List only necessary fields are fetched for the UI.
Every component its built with protocols and dependency injection, for make every piece of logic more reliable and testable.
Because of lack of experience with reactive programming, the current implementation of MVVM it's built around closures, to mimic the behaivor of reactive frameworks. 
There are Unit Tests for viewmodels.

## Notes
Due to lack of time, Datasource object it's not fully tested. For same reason, there are not UI Testing.
GraphQL and consequently Apollo Client it's used first time here and due lack of time, some best practice may not be implemented precisely. For example The Service and the relative Error Handling is not injected cause the lack of an injectable ApolloClient Mock.

## Requirements
Target SDK 16.2 
Developed on Xcode 14.2

## Installation & Execution
The only external dependency is Apollo Client (integrated via SPM), so open the project and run.

## Author

Daniele

## License

SurveyQuestions it's available under MIT License. See LICENSE file for more information
