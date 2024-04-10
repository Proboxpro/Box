//
//  Profile.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI
import PhotosUI
import Firebase
import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI
@available(iOS 17.0, *)

@MainActor
struct Profile: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var avatar: UIImage? = nil
    @State private var showingProfile = false
    @State private var showingVerif = false
    @State private var showingRules = false



    

    
    
    var body: some View {
        if let user = viewModel.currentUser{
            
            VStack{
                //header
                VStack{
                    PhotosPicker(selection: $photosPickerItem){
                        if avatar == nil {
                            WebImage(url: URL(string: user.imageUrl ?? ""))
                                .resizable()
                                .frame(width: 220, height: 220)
                                .aspectRatio(contentMode:.fill)
                                .clipShape(Circle())
                                .font(.system(size: 80))
                        }else {
                            Image (uiImage: avatar ?? UIImage (resource: .person ))
                                .resizable()
                                .frame(width: 220, height: 220)
                                .aspectRatio(contentMode:.fill)
                                .clipShape(Circle())
                                .font(.system(size: 80))
                        }
                    }.onChange(of: photosPickerItem) { _, _ in
                        Task{
                            if let photosPickerItem,
                               let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    avatar = image
                                    viewModel.saveProfileImage(item: photosPickerItem)
                                    self.avatar
                                }
                            }
                        }
                    }
                    Text (user.login)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text (user.fullname)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(user.email)
                        . font (.footnote)
                        . accentColor(.gray)
                }
                
                List{
                    Section{
                        VStack{
                            HStack{
                                Image(systemName: "person.circle.fill")
                                Button(action: {
                                    showingProfile.toggle()
                                }) {
                                    Text("Профиль")}
                                .foregroundColor(.black)
                            }
                            .sheet(isPresented: $showingProfile, content: {
                                ProfileView()
                            })
                            
                        }
                        HStack{
                            Image(systemName: "lock.circle")
                            Button(action: {
                                showingVerif.toggle()
                            }) {
                                Text("Верефикация")}
                            .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showingVerif, content: {
                            ProfileView()
                        })
                        HStack{
                            Image(systemName: "bell.fill")
                            Button(action: {
                                showingVerif.toggle()
                            }) {
                                Text("Мои объявления")}
                            .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showingVerif, content: {
                            Mylistning()
                        })
                        HStack{
                            Image(systemName: "checkmark.seal")
                            Button(action: {
                                showingRules.toggle()
                            }) {
                                Text("Правила")}
                            .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showingRules, content: {
                            ProfileView()
                        })
                    }
                
                   
                    Section{
                        Button(action: {
                            viewModel.signOut()
                        }) {
                            Text("Поддержка")}
                    }
                    Section{
                        Button(action: {viewModel.signOut()}){
                            Text("Выход")}
                    }
                    
                    .foregroundColor(.red)
                }
            }
        }
    }
}


@available(iOS 17.0, *)
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
