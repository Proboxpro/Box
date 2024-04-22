//
//  ConversationsListView.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 17.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI


@available(iOS 17.0, *)
struct ConversationsListView: View {
    /// auth "service"
    @EnvironmentObject var authViewModel: AuthViewModel
    /// view model for selected chat
    @State var chatViewModel: ChatViewModel? = nil
    /// current screen view model
    @StateObject var viewModel = ConversationListViewModel()
    
    @State private var shoulShowChat: Bool = false
    @State private var conversationToOpen: Conversation?
    
    var body: some View {
        if let user = authViewModel.currentUser {
            NavigationStack {
                ScrollView {
                    Text("")
                    ForEach(viewModel.conversations) { conversation in
                        ConversationRowView(conversationTitle: conversation.title, imageURL: conversation.pictureURL, latestMessageText: conversation.latestMessage?.text ?? "", formattedDateString: conversation.latestMessage?.createdAt?.timeAgoDisplay() ?? "")
                            .onTapGesture {
                                self.conversationToOpen = conversation
                                chatViewModel = ChatViewModel(auth: authViewModel, conversation: conversation)
                                shoulShowChat.toggle()
                            }
                    }
                    
                }
                .task ({
                    viewModel.subscribeToUpdates()
                    viewModel.fetchData()
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading)
                    {
                        VStack{
                            HStack{
                                WebImage(url: URL(string: user.imageUrl ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(50)
                                    .shadow(radius: 5)
                                
                                Text(user.login)
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing)
                    {
                        Button{
                            Profile()
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .fullScreenCover(isPresented: $shoulShowChat, onDismiss: {
                    viewModel.subscribeToUpdates()
                    viewModel.fetchData()
                }, content: {
                    if let conversationToOpen = conversationToOpen, let chatViewModel = chatViewModel {
                        NavigationView {
                            ChatViewContainer()
                                .environmentObject(chatViewModel)
                                .navigationBarItems(leading: Button("Back", action: {
                                    shoulShowChat.toggle()
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
                
                Text("\(conversationToOpen?.title ?? "")")
                    .hidden()
                
            }
        }
    }
}
@available(iOS 17.0, *)
struct Inbox_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsListView()
    }
}
