//
//  Components.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.body)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(AppColors.primary)
                .cornerRadius(8)
        }
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .font(AppTypography.body)
            .padding(AppSpacing.medium)
            .background(AppColors.background)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppColors.textSecondary, lineWidth: 1)
            )
            .padding(.horizontal, AppSpacing.medium)
    }
}

