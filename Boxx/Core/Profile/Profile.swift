//
//  Profile.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 16.11.2023.
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
    @State private var showingListing = false
    @State private var showingSupport = false

//    @State private var imageURL = ""
    
    var body: some View {
//        if let user = viewModel.currentUser{
        NavigationStack {
            AvatarProfileView()
            
            ListElemView()
        }
    }
    
//    func getImage()->UIImage {
//        if viewModel.currentUser?.imageUrl != nil {
//            WebImage(url: URL(string: user.imageUrl ?? ""))
//        }
//    }
    
    private func AvatarProfileView()->some View {
//        NavigationStack{
            //header
            VStack{
                PhotosPicker(selection: $photosPickerItem){
                    if avatar == nil {
                        WebImage(url: URL(string: viewModel.currentUser!.imageUrl ?? ""))
                        //                            Image(systemName: "person")
                        //                                .foregroundColor(.blue)
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 220, height: 220)
                            .aspectRatio(contentMode:.fill)
                            .clipShape(Circle())
                            .font(.system(size: 80))
                    } else {
                        Image (uiImage: avatar ?? UIImage (resource: .person ))
                            .resizable()
                            .frame(width: 220, height: 220)
                            .aspectRatio(contentMode:.fill)
                            .clipShape(Circle())
                            .font(.system(size: 80))
                    }
                }
                //                    .onAppear {
                //                        print("Diss")
                //                        viewModel.currentUser?.imageUrl = ""
                //                        avatar =
                //                        avatar = nil
                //                    }
                .onChange(of: photosPickerItem) { _, _ in
                    Task{
                        if let photosPickerItem,
                           let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                self.avatar = image
                                viewModel.saveProfileImage(item: photosPickerItem)
                            }
                        }
                    }
                    
                }
                Text (viewModel.currentUser!.login)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text (viewModel.currentUser!.fullname)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(viewModel.currentUser!.email)
                    . font (.footnote)
                    . accentColor(.gray)
            }
            
            
//        }
//    }
    }
    
    private func ListElemView()->some View {
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
                        Text("Верификация \(viewModel.checkIsApproved() ? "(пройдена)" : "(не пройдена)")")
                    }
                    .foregroundColor(.black)
                }
                .sheet(isPresented: $showingVerif, content: {
                    //                            ProfileView()
                    //MARK: - Sumsub View
                    SumsubView(user: $viewModel.currentUser)
                        .onDisappear(perform: {
                            if IdentityVerification.sdk != nil {
                                if IdentityVerification.sdk.status == .approved {
                                    withAnimation {
                                        viewModel.sumSubApprove()
                                    }
                                }
                            }
                        })
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
                    //                            Recomend()
                })
                HStack{
                    Image(systemName: "doc.questionmark")
                    Button(action: {
                        showingListing.toggle()
                    }) {
                        Text("Мои объявления")}
                    .foregroundColor(.black)
                }
                .sheet(isPresented: $showingListing, content: {
                    MyListing()
                })
                //                        .sheet(isPresented: $showingSupport, content: {
                //                            SupportView()
                //                        })
            }
            
            
            Section{
                NavigationLink {
                    SupportView()
                } label: {
                    Text("Поддержка")
                }
                .foregroundStyle(Color(.blue))
            }
            
            Section{
                Button(action: {
                    viewModel.signOut()
                }){
                    Text("Выход")}
            }
            
            .foregroundColor(.red)
        }
    }
}



//@available(iOS 17.0, *)
//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
//
//
