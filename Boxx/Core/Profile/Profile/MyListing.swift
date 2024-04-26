//
//  MyListing.swift
//  Boxx
//
//  Created by Руслан Парастаев on 26.04.2024.
//

import SwiftUI
import SDWebImageSwiftUI

@available(iOS 17.0, *)
struct MyListing: View {
    /// auth "service"
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            VStack {
                List {
                    
                    ForEach(viewModel.myorder) { item in
                        
                        if item.isAuthorized && !item.dataIsExpired {
                            
                            MyListingView(item: item) {
                                if let index = viewModel.myorder.firstIndex(where: { $0.id == item.id }) {
                                    
                                    print(viewModel.myorder.remove(at: index).ownerName)
                                    
                                }
                            }
                            .environmentObject(viewModel)
                        }
                        
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("История")
                        
                        Spacer()
                        
                    }
                    
                    
                    ForEach(viewModel.myorder) { item in
                        
                        if item.dataIsExpired {
                            
                            MyListingView(item: item) {
                                if let index = viewModel.myorder.firstIndex(where: { $0.id == item.id }) {
                                    
                                    print(viewModel.myorder.remove(at: index).ownerName)
                                    
                                }
                            }
                            .environmentObject(viewModel)
                            
                        }
                        
                    }
                    .frame(height: 160)
                }
                .listStyle(PlainListStyle())
            }
            .onAppear{
                viewModel.fetchOrder()
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
        }
    }
}

//@available(iOS 17.0, *)
//struct Inbox_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationsListView()
//    }
//}
