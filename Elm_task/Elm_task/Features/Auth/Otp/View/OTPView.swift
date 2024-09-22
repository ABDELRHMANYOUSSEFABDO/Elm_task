//
//  OTPView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI

struct OTPView: View {
    @ObservedObject var viewModel: OTPViewModel
    
    // Create an array of empty fields for the OTP input
    @State private var otpFields = Array(repeating: "", count: 4)
    
    // Array of focusable fields for automatic transition between them
    @FocusState private var focusedField: Int?

    var body: some View {
        VStack(spacing: 20) {
            
            Text("Verify OTP")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 20)
            
            Spacer()

            // OTP input fields
            HStack(spacing: 15) {
                ForEach(0..<4) { index in
                    TextField("", text: $otpFields[index])
                        .frame(width: 50, height: 50)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .font(.system(size: 24, weight: .bold))
                        .focused($focusedField, equals: index) // Focus state for each field
                        .onChange(of: otpFields[index]) { newValue in
                            if newValue.count == 1 {
                                // Move to next field if the current field has one character
                                if index < 3 {
                                    focusedField = index + 1
                                } else {
                                    focusedField = nil // Dismiss keyboard when finished
                                }
                            } else if newValue.isEmpty && index > 0 {
                                // If the field is empty, move to the previous field
                                focusedField = index - 1
                            }
                            
                            // Ensure the user enters only 1 character
                            otpFields[index] = String(newValue.prefix(1))
                        }
                }
            }
            .padding(.bottom, 20)

            // Primary button for OTP submission
            PrimaryButton(
                title: viewModel.otpSuccess ? "Next" : "Verify OTP",
                action: {
                    let otp = otpFields.joined()
                    viewModel.verifyOTP(otp: otp)
                }
            )
            .disabled(viewModel.isLoading)
            .padding(.horizontal, 40)

            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 20)
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .medium))
                    .padding()
            }

            if viewModel.otpSuccess {
                Text("OTP verified successfully")
                    .foregroundColor(.green)
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 20)
            }

            Spacer() // Center everything vertically
        }
        .padding()
        .onAppear {
            focusedField = 0 // Start by focusing on the first field
        }
    }
}


struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewCoordinator = AppCoordinator()

       
        OTPView(viewModel: OTPViewModel(email: "", coordinator: previewCoordinator))  
    }
}

