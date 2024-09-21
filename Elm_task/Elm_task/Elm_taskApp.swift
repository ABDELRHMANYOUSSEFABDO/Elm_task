//
//  Elm_taskApp.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI

@main
struct Elm_taskApp: App {
    @StateObject var appCoordinator = AppCoordinator()
    

    var body: some Scene {
         WindowGroup {
             RootView()
                 .environmentObject(appCoordinator) 
                 
         }
     }
 }
    
