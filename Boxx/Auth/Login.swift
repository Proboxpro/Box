//
//  Login.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 16.11.2023.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image ("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.vertical, 80)
                
                VStack(spacing: 24){
                    InputView(text: $email,
                              title: "Email ",
                              placeholder: "name@mail.ru")
                    .autocapitalization(.none)
                    
                    InputView(text: $password, title:"Пароль", placeholder:"Введите пароль",  isSecureField: true)
                    
                }.padding(.horizontal)
                    .padding(.top, 20)
                
                Button { Task{
                    try await viewModel.signIn(withEmail: email, password: password)
                }
                } label: {
                        HStack{
                            Text ("SIGN IN")
                                .fontWeight (.semibold)
                            Image (systemName: "arrow.right")
                            
                        }
                        . foregroundColor (.white)
                        .frame(width:UIScreen.main.bounds.width-32, height: 48)
                        .disabled(formIsValid)
                        .opacity(formIsValid ?  1.0 : 0.5)
                    }   .background (Color (.systemBlue))
                        .cornerRadius (10)
                        .padding(.top,25)
                
                
                Spacer()
                
                NavigationLink{ Registration()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text ("Нет аккаунта?")
                        Text ("Регистрация")
                            .fontWeight(.bold)
                    }  .font (.system(size: 14))
                    
                }
                
            }
        }
    }
}
extension Login : AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
