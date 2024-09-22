//
//  OTPView.swift
//  Elm_task
//
//  Created by Abdelrahman.Youssef on 21/09/2024.
//

import SwiftUI

import SwiftUI

struct OTPView: View {
    @ObservedObject var viewModel: OTPViewModel
    
    @State private var otpFields = Array(repeating: "", count: 4)

    var body: some View {
        VStack(spacing: 20) {
          
            Text("Verify OTP")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 20)
            

            HStack(spacing: 15) {
                ForEach(0..<4) { index in
                    TextField("", text: $otpFields[index])
                        .frame(width: 50, height: 50)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .font(.system(size: 24, weight: .bold))
                        .onChange(of: otpFields[index]) { newValue in
                            if newValue.count > 1 {
                                otpFields[index] = String(newValue.prefix(1))
                            }
                        }
                }
            }
            .padding(.bottom, 20)

            
            Button(action: {
                let otp = otpFields.joined()
                viewModel.verifyOTP(otp: otp)
            }) {
                Text("Verify OTP")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isLoading ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .disabled(viewModel.isLoading)
            
            
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
            
            Spacer()
        }
        .padding()
        .navigationTitle("Verify OTP")
    }
}


struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewCoordinator = AppCoordinator()

       
        OTPView(viewModel: OTPViewModel(email: "", coordinator: previewCoordinator))  
    }
}

