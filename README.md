# Movies iOS App  

A SwiftUI-based movie application developed using the VIPER architecture. This project is built for Xcode 14.1 and targets iOS 16.  

## Features  
- Browse popular movies.
- View detailed information about selected movies.  
- User-friendly and responsive interface.  

## Tech Stack  
- **Language**: Swift  
- **Framework**: SwiftUI  
- **Architecture**: VIPER  
- **Target iOS Version**: iOS 16  
- **IDE**: Xcode 14.1  

## Installation  

1. Clone the repository:  
   ```bash  
   git clone https://github.com/masumrpg/movies-ios-swift.git  
   ```  

2. Navigate to the project directory:  
   ```bash  
   cd movies-ios-swift  
   ```  

3. Open the project in Xcode 14.1:  
   ```bash  
   open MoviesApp.xcodeproj  
   ```  

4. Select your desired simulator or device and hit **Run**.  

## Project Structure  

The application follows the VIPER architecture, ensuring a clean separation of concerns:  
- **View**: Handles UI and user interactions.  
- **Interactor**: Business logic and data manipulation.  
- **Presenter**: Mediator between View and Interactor.  
- **Entity**: Data models.  
- **Router**: Navigation logic.   