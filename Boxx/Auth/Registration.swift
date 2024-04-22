//
//  Registration.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct Registration: View {
    @State private var email = ""
    @State private var login = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var imageUrl = "https://firebasestorage.googleapis.com/v0/b/newboc-ae213.appspot.com/o/user%2Flogo.png?alt=media&token=77b3ec3c-1dfd-4ba8-91a4-b52b4d738b2c"
    @State private var backgroundPicture = ""

    


    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            //// image

            VStack(spacing: 24){
                InputView(text: $email,
                          title: "Email ",
                          placeholder: "name@mail.ru")
                .autocapitalization(.none)
                
                InputView(text: $login, title:"Логин", placeholder:"Введите Логин")
                    .autocapitalization(.none)
                
                InputView(text: $fullName, title:"ФИО", placeholder:"Как в паспорте")
                    .autocapitalization(.none)
                
                
                InputView(text: $password, title:"Пароль", placeholder:"Введите пароль",  isSecureField: false)
                ZStack(alignment: .trailing){
                    InputView(text: $confirmPassword, title:"Подтвердите пароль", placeholder:"Повторите пароль",  isSecureField:false)
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword{
                            Image (systemName: "checkmark.circle.fill")
                            .imageScale (. large)
                            .fontWeight (.bold)
                            .foregroundColor (Color (.systemGreen) )
                        }
                        else{
                            Image (systemName: "xmark.circle.fill")
                            .imageScale (.large)
                            .fontWeight (.bold)
                            .foregroundColor (Color (.systemRed))
                        }
                    }
                }
                
            }.padding(.horizontal)
                .padding(.top, 12)
            
            Button { Task{
                try await viewModel.createUser(withEmail: email, password: password,fullname: fullName, login: login, imageUrl: imageUrl)
            }
            } label: {
                HStack {
                    Text ("Зарегестрироваться")
                        .fontWeight (.semibold)
                    Image (systemName: "arrow.right")
                }
                . foregroundColor (.white)
                .frame(width:UIScreen.main.bounds.width-32, height: 48)
                .disabled(formIsValid)
                .opacity(formIsValid ?  1.0 : 0.5)
                
            }.background (Color (.systemBlue))
                .cornerRadius (10)
                .padding(.top,25)
            
            Spacer()
            
            Button {
    dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text ("Уже есть аккаунт?")
                    Text ("Вход")
                        .fontWeight(.bold)
                }  .font (.system(size: 14))
            }
        }
        
    }
}
extension Registration: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
        && fullName.count > 10


    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
