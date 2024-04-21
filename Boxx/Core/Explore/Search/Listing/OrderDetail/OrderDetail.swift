//
//  OderDetail.swift
//  Boxx
//
//  Created by Руслан Парастаев on 14.04.2024.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import PhotosUI
@available(iOS 17.0, *)

struct OrderDetail: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    var item: ListingItem
    
    @State private var showingMessage = false
    @State private var showingProfile = false
    @State private var value: String = ""
    @State private var recipient: String = ""
    
    private var orderItem: OrderDescriptionItem? {
        return viewModel.orderDescription.last
    }
    
    @State private var conversationToOpen: Conversation? = nil
    @State var chatViewModel: ChatViewModel? = nil
    
    var isSendAviable: Bool {
        return viewModel.orderDescription.first?.description != ""
    }
    
    var filtereduser: [User] {
        guard !recipient.isEmpty else { return viewModel.users }
        return viewModel.users.filter{ $0.login.localizedCaseInsensitiveContains(recipient)}
    }
    
    var receipentUser: User? {
        return viewModel.users.first { $0.login.localizedCaseInsensitiveContains(recipient) }
    }
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    dismiss()
                }  label: { Image(systemName:"chevron.left")
                        .foregroundStyle(.black)
                        .background{
                            Circle()
                                .fill(.white)
                                .frame(width: 32, height: 32)
                        }
                }
                .padding(32)
                Spacer()
                Button{
                    
                }  label: { Image(systemName:"scope")
                        .foregroundStyle(.white)
                        .background{
                            Circle()
                                .fill(.red)
                                .frame(width: 32, height: 32)
                        }
                }
                .padding(32)
            }
            Spacer()
            VStack{
                HStack(spacing: 8){
                    HStack{
                        Button{
                            showingProfile.toggle()
                        } label: {
                            WebImage(url: URL(string: item.imageUrl))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                        }.sheet(isPresented: $showingProfile, content: {
                            ProfileView()
                        })
                        VStack(alignment: .leading, spacing: 0){
                            Text("\(item.ownerName)")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            HStack(spacing: 8){
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.yellow)
                                Text("4.4 · Рейтинг")
                                    .fontWeight(.regular)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .frame(maxHeight: 32)
                    }
                    Spacer()
                    Button {
                        if isSendAviable {
                            Task{
                                do {
                                    if let receipentUser = receipentUser {
                                        await orderViewModel.selectUsers([item.ownerUid, viewModel.currentUser?.id ?? ""] + [receipentUser.id])
                                    } else {
                                        await orderViewModel.selectUsers([item.ownerUid, viewModel.currentUser?.id ?? ""])
                                    }
                                    
                                    if let conversation = await orderViewModel.conversationForUsers() {
                                        self.chatViewModel = ChatViewModel(auth: viewModel, conversation: conversation)
                                        showingMessage.toggle()
                                        self.orderViewModel.selectedUsers = []
                                    }
                                }
                            }
                        } else {
                            
                        }
                    } label: {
                        Image(systemName:"message.fill")
                            .foregroundStyle(.black)
                            .background{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 32, height: 32)
                            }
                            .sheet(isPresented: $showingMessage, content: {
                                if let chatViewModel = chatViewModel  {
                                    NavigationView {
                                        ChatViewContainer()
                                            .environmentObject(chatViewModel)
                                            .navigationBarItems(leading: Button("Back", action: {
                                                showingMessage.toggle()
                                            }))
                                            .navigationBarItems(trailing: AsyncImage(url: URL(string: item.imageUrl), content: { image in
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
                                            .navigationTitle(item.ownerName)
                                            .navigationBarTitleDisplayMode(.inline)
                                    }
                                }
                            })
                    }
                    .disabled(!isSendAviable)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                    Button{
                        guard let url = URL(string: "tel://89205707541") else { return }
                        UIApplication.shared.open(url)
                    }  label: { Image(systemName:"phone.fill")
                            .foregroundStyle(.white)
                            .background{
                                Circle()
                                    .fill(.red)
                                    .frame(width: 32, height: 32)
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(32)
                
                VStack(alignment: .leading, spacing: 32) {
                    ZStack{
                        HStack{
                            Spacer()
                            Rectangle()
                                .foregroundColor((orderItem?.isInDelivery ?? false) ? .green : .gray)
                                .frame(width: 128, height: 2)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 36, trailing: 0))
                            Rectangle()
                                .foregroundColor((orderItem?.isDelivered ?? false) ? .green : .gray)
                                .frame(width: 128, height: 2)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 36, trailing: 0))
                            Spacer()
                        }
                        HStack{
                            VStack(spacing: 16){
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.white)
                                    .background(
                                        Circle()
                                            .fill((orderItem?.isSent ?? false) ? .green : .gray)
                                            .frame(width: 32, height: 32)
                                    )
                                Text("Отправлен")
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                            VStack(spacing: 16){
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.white)
                                    .background(
                                        Circle()
                                            .fill((orderItem?.isInDelivery ?? false) ? .green : .gray)
                                            .frame(width: 32, height: 32)
                                    )
                                Text("В доставке")
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                            VStack(spacing: 16){
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.white)
                                    .background(
                                        Circle()
                                            .fill((orderItem?.isDelivered ?? false) ? .green : .gray)
                                            .frame(width: 32, height: 32)
                                    )
                                Text("Доставлен")
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    
                    HStack(spacing: 16){
                        if let url = orderItem?.image {
                            WebImage(url: url)
                                .resizable()
                                .frame(maxWidth: 80, maxHeight: 80)
                        }
                        
                        if let description = orderItem?.description {
                            Text("Описание: \(description)")
                                .fontWeight(.regular)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(32)
                .background(Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(12))
                
            }
            .background(Rectangle()
                .foregroundColor(.black)
                .cornerRadius(12))
        }
        .onAppear {
            viewModel.fetchOrderDescription()
            orderViewModel.fetchData()
        }
        .navigationBarHidden(true)
        .background(Rectangle()
            .foregroundColor(.gray))
    }
}
