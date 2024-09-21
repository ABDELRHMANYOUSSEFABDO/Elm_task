//
//  SplashView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel
    
    
    @State private var scaleEffect: CGFloat = 0.5
    @State private var opacity: Double = 0.0

    var body: some View {
        VStack {
            
                Image("Elm")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(AppColors.primary)
                .scaleEffect(scaleEffect)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2)) {
                        scaleEffect = 1.0
                        opacity = 1.0
                    }
                }

            
            Text("Welcome to Elm")
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)
                .padding()
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).delay(0.5)) {
                        opacity = 1.0
                    }
                }
        }
        
        .onAppear {
            viewModel.startSplashScreen()
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel(coordinator: AppCoordinator()))
}
