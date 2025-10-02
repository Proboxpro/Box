//
//  Registration.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 16.11.2023.
//

import SwiftUI

struct Registration: View {
    @State private var email = ""
    @State private var login = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var imageUrl = ""
    @State private var backgroundPicture = ""

    


    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 12) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                Spacer()
                Text("Регистрация")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                Color.clear.frame(width: 24, height: 24)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            Text("Зарабатывай честно")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .padding(.top, 4)
            
            VStack(spacing: 14){
                AuthTextField(text: $login, placeholder: "Логин")
                AuthTextField(text: $password, placeholder: "Пароль", isSecure: true)
                AuthTextField(text: $confirmPassword, placeholder: "Повторите пароль", isSecure: true)
                AuthTextField(text: $email, placeholder: "Почта", keyboard: .emailAddress)
                AuthTextField(text: $backgroundPicture, placeholder: "Номер телефона", keyboard: .phonePad)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            
            Button(action: {}) {
                Text("Подтвердить личность")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .foregroundColor(.white)
            }
            .background(Color("Peach").opacity(0.9))
            .cornerRadius(14)
            .padding(.horizontal, 16)
            .padding(.top, 20)
            
            Button(action: {}) {
                Text("Создать аккаунт")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.primary.opacity(0.15), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            
            Button(action: { dismiss() }) {
                Text("Уже есть аккаунт?")
                    .foregroundColor(Color("Peach"))
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.top, 16)
            
            Button(action: {}) {
                Text("Войти с помощью сервиса SumSub")
                    .foregroundColor(.secondary)
                    .font(.system(size: 13))
            }
            .padding(.top, 6)
            
            Spacer()
        }
        
    }
}
extension Registration {
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
