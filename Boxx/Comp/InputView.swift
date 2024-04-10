//
//  InputView.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let titel: String
    let placeholder: String
    var isSecureField = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(titel)
                .foregroundColor(Color(.darkGray))
                .fontWeight (.semibold)
                .font (.footnote)
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size:14))
            }
            else {
                TextField(placeholder, text: $text)
                    .font(.system(size:14))
            }
            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), titel: "Email Adress", placeholder: "placeholder@mail.ru")    }
}
