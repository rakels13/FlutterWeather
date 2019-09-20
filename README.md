# Flutter Weather or Weather forecast

A weather forecast app by Rakel Sigurjónsdóttir. The project is developed in flutter and using the weatherAPI found at: [OpenWeather](https://openweathermap.org/forecast5). The app shows the weather for the current day (the closest forecast in time) and then a list of overview for the next four following days (forecast for noon on those days). Clicking on any of the days in the list or the current weather opens a detail page that shows some more detail information about the forecast. The app uses the users location to retrieve the information.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need a few things installed and working to be able to review and test the project.

* Flutter SDK and other prerequsites, recommend going through the getting started phase found at: [Flutter.dev](http://flutter.dev/)


### Installing

Here is a step by step on the installation needed to get the project up and running locally.

No installation other than what is detailed from the flutter get started guide.

If you haven't cloned the repository yet, now is a good time to do so.
Once you have the repository locally on your device you can go ahead and install all required dependencies for the program. Following we have the dependencies needed in pubspec.yaml

* http: ^0.12.0+2
* location: ^1.4.1
* intl: ^0.16.0


Finally, to run the app in debug mode from your editor.

## Running the tests

No test to run yet.

## Next steps (The TODO list)

* Adding caching with time limits - perhaps using flutter_cache_manager
* Adding a refresh button
* Adding search options for other locations than the ones obtained by geolocation
* Adding more info in the detailed weather page, perhaps overview of all the forecasts for given day
* Refactoring the code
* Designing a better UI and layout

## Built With

* [Flutter](flutter.dev) - The framework used
* [OpenWeather API](https://openweathermap.org/forecast5) - 5 day weather forecast 

## Author

* **Rakel Sigurjónsdóttir** 
