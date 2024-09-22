//
//  SplashViewModel.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import Foundation

class SplashViewModel: ObservableObject {
    var coordinator: AppCoordinator

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    func startSplashScreen() {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.coordinator.navigateToAuthFlow()
        }
    }
}
