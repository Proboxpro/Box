//
//  ConversationsListView.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 17.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI

@available(iOS 17.0, *)
struct OrdersList: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var orderItem: OrderDescriptionItem? = nil

    var body: some View {
        if let user = viewModel.currentUser {
           NavigationStack {
               ScrollView {
                   if !viewModel.ownerOrderDescription.isEmpty {
                       Text("Мои поездки")
                           .fontWeight(.medium)
                           .foregroundStyle(.black)
                   }
                   ForEach(viewModel.ownerOrderDescription, id: \.hashValue) { order in
                       OrderRow(isCompleted: order.isCompleted,
                                orderImageURL: order.image,
                                profileName: "В \(order.cityTo)",
                                orderDescription: order.description ?? "Описание",
                                date: order.creationTime)
                           .onTapGesture {
                               self.orderItem = order
                           }
                   }
                   
                   if !viewModel.orderDescription.isEmpty {
                       Text("Заказанные товары")
                           .fontWeight(.medium)
                           .foregroundStyle(.black)
                   }
                   ForEach(viewModel.orderDescription, id: \.hashValue) { order in
                       OrderRow(isCompleted: order.isCompleted,
                                orderImageURL: order.image,
                                profileName: "В \(order.cityTo)",
                                orderDescription: order.description ?? "Описание",
                                date: order.creationTime)
                           .onTapGesture {
                               self.orderItem = order
                           }
                   }
                   
                   if !viewModel.recipientOrderDescription.isEmpty {
                       Text("Нужно получить")
                           .fontWeight(.medium)
                           .foregroundStyle(.black)
                   }
                   ForEach(viewModel.recipientOrderDescription, id: \.hashValue) { order in
                       OrderRow(isCompleted: order.isCompleted,
                                orderImageURL: order.image,
                                profileName: "В \(order.cityTo)",
                                orderDescription: order.description ?? "Описание",
                                date: order.creationTime)
                           .onTapGesture {
                               self.orderItem = order
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
               .fullScreenCover(item: $orderItem, onDismiss: {
                   viewModel.fetchOrderDescription()
               }, content: { item in
                   NavigationView{
                       OrderDetail(orderItem: item)
                           .environmentObject(OrderViewModel(authViewModel: self.viewModel))
                           .navigationBarBackButtonHidden()
                   }
               })
               
           }
           .onAppear {
               viewModel.fetchOrderDescription()
               viewModel.fetchOrderDescriptionAsOwner()
               viewModel.fetchOrderDescriptionAsRecipient()
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
