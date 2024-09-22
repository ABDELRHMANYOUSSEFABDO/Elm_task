//
//  LoginView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Welcome Back")
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)
                .padding(.bottom, AppSpacing.large)
            
            CustomTextField(placeholder: "Email", text: $viewModel.email)
                .padding(.bottom, AppSpacing.medium)
            
            
            PrimaryButton(title: viewModel.isLoading ? "Logging in..." : "Login") {
                viewModel.login()
            }
            .padding(.bottom, AppSpacing.medium)
            .disabled(viewModel.isLoading)
            
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: AppColors.primary))
                    .padding(.bottom, AppSpacing.medium)
            }
            
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(AppTypography.caption)
                    .foregroundColor(AppColors.error)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.bottom, AppSpacing.medium)
            }
            
            
            if viewModel.loginSuccess {
                Text("Login successful!")
                    .font(AppTypography.subheadline)
                    .foregroundColor(AppColors.success)
                    .padding(.bottom, AppSpacing.medium)
            }
            
            Spacer()
        }
        .padding(.horizontal, AppSpacing.medium)
        .background(AppColors.background)
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let previewCoordinator = AuthCoordinator()
        LoginView(viewModel: LoginViewModel(coordinator: previewCoordinator))
    }
}
