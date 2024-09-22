# Elm Task - Incident Management App

## Overview
Elm Task is a SwiftUI-based incident management application designed to allow users to submit, view, and manage incidents. The app integrates with a remote API to fetch incident types, submit incidents, and display dashboards of incidents. It uses modern SwiftUI techniques and follows the MVVM architecture pattern for maintainability and scalability.

## Features
- **Incident Submission**: Users can submit incidents with descriptions, latitude, longitude, status, and types.
- **Incident Types from API**: The incident types are fetched dynamically from an API and presented in a dropdown.
- **Status Management**: Incidents can have various statuses such as Submitted, In Progress, Completed, or Rejected.
- **Incident Dashboard**: Users can view dashboards with metrics about incidents (based on the screen shown).

## File Structure
The project is divided into multiple features and services for modularity.

- **Root**
    - `RootView.swift`: Main entry view of the app.
    - `AuthFlowView.swift`: Handles the authentication flow.
    - `IncidentFlowView.swift`: Handles the incident flow.
  
- **Features**
    - **Dashboard**
        - Views, ViewModel, and Models related to the incident dashboard.
    - **Incident**
        - `NewIncidentView.swift`: Handles incident submission.
    - **Auth**
        - Handles user authentication.
    - **Splash**
        - Initial splash screen logic.

- **Services**
    - `LocationManager.swift`: Handles real-time location fetching using CoreLocation.
    - `IncidentService.swift`: Network service that handles API requests related to incidents.
  
- **Coordinator**
    - `AppCoordinator.swift`: Central coordinator for managing navigation across the app.

## Usage
1. When launching the app, users can submit new incidents.
2. Users can select the incident type from the dropdown menu.
3. Incidents are then managed and displayed in a dashboard.

## Contributors
- **[Abdelrahman youssef]** - Lead Developer
