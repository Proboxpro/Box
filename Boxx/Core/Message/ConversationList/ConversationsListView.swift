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
    @EnvironmentObject var viewModel: AuthViewModel
    
    private var items: [ListingItem] {
        return viewModel.orders
    }
    @State private var selectedItem: ListingItem? = nil
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                ScrollView {
                    ForEach(viewModel.orderDescription, id: \.hashValue) { order in
                        ConversationRowView(isCompleted: order.isCompleted,
                                            orderImageURL: order.image,
                                            profileName: items.filter{ $0.ownerUid == order.ownerId }.last?.ownerName ?? "Заказ",
                                            orderDescription: order.description ?? "Описание")
                            .onTapGesture {
                                self.selectedItem = items.filter{ $0.ownerUid == order.ownerId }.last
                            }
                    }
                }
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
                }
                .fullScreenCover(item: $selectedItem, onDismiss: {
                    viewModel.fetchOrderDescription()
                }, content: { item in
                    NavigationView{
                        OrderDetail(item: item)
                            .environmentObject(OrderViewModel(authViewModel: self.viewModel))
                            .navigationBarBackButtonHidden()
                    }
                })
                
            }
            .onAppear {
                viewModel.fetchOrderDescription()
                viewModel.fetchOrder()
            }
        }
    }
}

//@available(iOS 17.0, *)
//struct Inbox_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationsListView()
//    }
//}
