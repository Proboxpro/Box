//
//  StartView.swift
//  Boxx
//
//  Created by Assistant on 02.10.2025.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer(minLength: 24)
                
                Text("PYPA")
                    .font(.system(size: 72, weight: .heavy))
                    .foregroundColor(Color("Peach"))
                    .padding(.top, 24)
                
                VStack(spacing: 8) {
                    Text("Путешествуй и\nторгуй с нами.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    Text("Мы совершаем сделки безопасно и\nпомогаем зарабатывать путешественникам")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                
                Spacer()
                
                NavigationLink {
                    Login()
                } label: {
                    Text("Войти")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .foregroundColor(.white)
                }
                .background(Color("Peach").opacity(0.9))
                .cornerRadius(14)
                .padding(.horizontal, 24)
                
                NavigationLink {
                    Registration()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Зарегистрироваться")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .foregroundColor(Color("Peach"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color("Peach").opacity(0.9), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                
                Spacer(minLength: 32)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}


