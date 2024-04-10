//
//  UploadpostView.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI

struct UploadpostView: View {
    var body: some View {
        NavigationStack{
            HStack{
                VStack{
                    Text("Добавьте свою поездку уже сегодня")
                    Divider()
                    SearchButton()
                } 
                .navigationTitle("Вы уезжате?")
                
            }
        }
    }
    
    struct UploadpostView_Previews: PreviewProvider {
        static var previews: some View {
            UploadpostView()
        }
    }
}
