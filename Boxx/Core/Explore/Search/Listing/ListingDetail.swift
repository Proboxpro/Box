//
//  ListingDetail.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import PhotosUI
@available(iOS 17.0, *)

struct ListingDetail: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    //    @StateObject var listingViewModel = ListingViewModel(authViewModel: self.viewModel)
    @EnvironmentObject var listingViewModel: ListingViewModel
    var item: ListingItem
    
    @State private var photosPickerItem: PhotosPickerItem?
    
    @State private var productImage: UIImage? = nil
    @State private var productImageUrl: URL? = nil
    @State private var showingOrder = false
    @State private var showingProfile = false
    @State private var value: String = ""
    @State private var description: String = ""
    @State private var recipient: String = ""
    @State private var imageUrls: String = ""
    @State private var ownerImageUrl: String = ""
    @State private var text = ""
    
    @State private var conversationToOpen: Conversation? = nil
    @State var chatViewModel: ChatViewModel? = nil
    
    var isSendAviable: Bool {
        return description != "" && value != ""
    }
    
    var filtereduser: [User] {
        guard !recipient.isEmpty else { return viewModel.users }
        return viewModel.users.filter{ $0.login.localizedCaseInsensitiveContains(recipient)}
    }
    
    var receipentUser: User? {
        return viewModel.users.first { $0.login.localizedCaseInsensitiveContains(recipient) }
    }
    
    var body: some View {
        ScrollView{
            ZStack(alignment:.topLeading ){
                WebImage(url: URL(string: item.imageUrls))
                    .resizable()
                    .frame(maxHeight: 350)
                Button{
                    dismiss()
                }  label: { Image(systemName:"chevron.left")
                        .foregroundStyle(.black)
                        .background{
                            Circle()
                                .fill(.white)
                                .frame(width: 32, height: 32)
                        }
                        .padding(50)
                }
            }
            
            VStack(alignment: .leading, spacing: 8){
                Text("в город  \(item.cityTo)")
                    .font(.title)
                    .fontWeight(.semibold)
                VStack(alignment: .leading){
                    HStack(spacing: 2){
                        Image(systemName: "star.fill")
                        Text("4.4")
                        Text(" - " )
                        
                        Text("23 отзыва")
                            .underline()
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.black )
                    Text("из \(item.cityFrom)")
                    
                }                    .font(.caption)
                
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            HStack{
                VStack(alignment: .leading, spacing: 4 ){
                    Text("Размещено пользователем @ \(item.ownerName)")
                        .font(.headline)
                        .frame(width: 250, alignment: .leading )
                        .font(.caption)
                }
                .frame(width: 300, alignment: .leading )
                Spacer()
                Button{
                    showingProfile.toggle()
                } label: {
                    WebImage(url: URL(string: item.imageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }.sheet(isPresented: $showingProfile, content: {
                    ProfileView()
                })
            }
            .padding()
            
            Divider()
            VStack(alignment: .leading, spacing: 4 ){
                Text("Укажите стоимость описание и добавьте фотографию товара")
                    .font(.headline)
                    .frame(width: 350, alignment: .leading )
                    .font(.caption)
            }
            HStack(spacing: 10){
                
                VStack(alignment: .center, spacing: 5 ){
                    HStack(){
                        Image(systemName: "note")
                            .imageScale(.small)
                        TextField("Описание", text: $description)
                            .font(.subheadline)
                    }
                    .frame(width: 340, height: 44 )
                    .padding(.horizontal)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(description == "" ? Color(.tinder) : Color(.systemGray4))
                    }
                    HStack{
                        HStack(alignment: .top){
                            VStack(alignment: .leading){
                                HStack(alignment: .top){
                                    Image(systemName: "magnifyingglass")
                                    TextField("Получатель", text: self.$recipient)
                                        .font(.subheadline)
                                        .fontWeight(.semibold )
                                } .frame(width: 150, height: 44)
                                    .padding(.horizontal)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(lineWidth: 1.0)
                                            .foregroundStyle(receipentUser == nil ? Color.red : Color(.systemGray4))
                                    }
                                if self.recipient != ""{
                                    if  self.viewModel.users.filter({$0.login.lowercased().contains(self.recipient.lowercased())}).count == 0{
                                        VStack(alignment: .center){
                                            Text("Не найден")
                                        }
                                        .frame(width: 180, height: 44)
                                        .foregroundColor(Color.black.opacity(0.5))
                                        .overlay{RoundedRectangle(cornerRadius: 8)
                                                .stroke(lineWidth: 1.0)
                                                .foregroundStyle(Color(.systemGray4))
                                        }
                                    }
                                    else{
                                        VStack(alignment: .leading){
                                            ForEach(filtereduser.prefix(1)) { item in
                                                CardView(user: item )
                                                    .onTapGesture {
                                                        recipient = item.login
                                                    }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            HStack(alignment: .top){
                                Image(systemName: "note")
                                    .imageScale(.small)
                                TextField("Стоимость", text: $value)
                                    .font(.subheadline)
                            }
                            .frame(width: 150, height: 44 )
                            .padding(.horizontal)
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1.0)
                                    .foregroundStyle(value == "" ? Color.red : Color(.systemGray4))
                            }
                        }
                    }
                    Spacer()
                    PhotosPicker(selection: $photosPickerItem){
                        Image (uiImage: productImage ?? UIImage (resource: .plus ))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode:.fill)
                            .clipShape(Rectangle())
                            .font(.system(size: 80))
                    }.onChange(of: photosPickerItem) { _, _ in
                        Task{
                            if let photosPickerItem,
                               let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    productImage = image

                                    let url = try? await viewModel.saveOrderImage(data: data)
                                    productImageUrl = url
                                }
                            }
                        }
                    }
                }
                .frame(width: 300, alignment: .leading )
                Spacer()
            }
            .padding()
            Divider()
            
        }
        .onAppear {
            listingViewModel.fetchData()
        }
        .toolbar(.hidden, for:  .tabBar)
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom, 70)
        .overlay(alignment: .bottom) {
            VStack{
                Divider()
                    .padding(.bottom)
                HStack{
                    VStack(alignment: .leading){
                        Text(item.pricePerKillo)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("Цена за кг.")
                            .font(.footnote)
                        Text(item.startdate)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .underline()
                    }
                    Spacer()
                    Button {
                        if isSendAviable {
                            Task{
                                //                            viewModel.createNewOrder(senderName: viewModel.currentUser?.login ?? "", senderUid: viewModel.currentUser?.id ?? "", ownerUid: item.ownerUid, ownerName: item.ownerName, description: description, value: value, cityFrom: item.cityFrom, cityTo: item.cityTo, imageUrls: item.imageUrls, recipient: recipient, ownerImageUrl: item.imageUrl, text: text)
                                do {
                                    if let receipentUser = receipentUser {
                                        await listingViewModel.selectUsers([item.ownerUid, viewModel.currentUser?.id ?? ""] + [receipentUser.id])
                                    } else {
                                        await listingViewModel.selectUsers([item.ownerUid, viewModel.currentUser?.id ?? ""])
                                    }
                                    
                                    if let conversation = await listingViewModel.conversationForUsers() {
                                        self.conversationToOpen = conversation
                                        self.chatViewModel = ChatViewModel(auth: viewModel, conversation: conversation, initialMessageText: description == "" ? nil : description, initialImageURL: productImageUrl)
                                        showingOrder.toggle()
                                        self.listingViewModel.selectedUsers = []
                                    }
                                }
                            }
                        } else {
                            
                        }
                    } label: {
                        Text ("Отправить")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 140, height: 40 )
                            .background(.pink)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .sheet(isPresented: $showingOrder, content: {
                                if let conversationToOpen = conversationToOpen, let chatViewModel = chatViewModel  {
                                    NavigationView {
                                        ChatViewContainer()
                                            .environmentObject(chatViewModel)
                                            .navigationBarItems(leading: Button("Back", action: {
                                                showingOrder.toggle()
                                            }))
                                            .navigationBarItems(trailing: AsyncImage(url: conversationToOpen.pictureURL, content: { image in
                                                image
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                    .clipShape(Circle())
                                            }, placeholder: {
                                                Image(systemName: "person.circle.fill")
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                    .foregroundColor(Color(.systemGray))
                                            }))
            //                                .navigationBarBackButtonHidden(false)
                                            .navigationTitle(conversationToOpen.title)
                                            .navigationBarTitleDisplayMode(.inline)
                                    }
                                }
                            })
                    }
                    .disabled(!isSendAviable)
                    .opacity(isSendAviable ? 1.0 : 0.6)
                }
                .padding(.horizontal, 32)
            }
            .background(.white)
        }
        
    }
    
}



