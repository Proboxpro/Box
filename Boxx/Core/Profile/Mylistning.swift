//
//  Mylistning.swift
//  Boxx
//
//  Created by Nikita Larin on 05.01.2024.
//

import SwiftUI
import Firebase
@available(iOS 17.0, *)

struct Mylistning: View {
  
    
    @EnvironmentObject var viewModel: AuthViewModel
    @available(iOS 17.0, *)
    
    
    
    var body: some View {
        Spacer()
        
        List {
            
            ForEach(viewModel.myorder) { item in
                
                if item.isAuthorized && !item.dataIsExpired {
                    
                    MyListingItemView(item: item) {
                        
                        if let index = viewModel.myorder.firstIndex(where: { $0.id == item.id }) {
                            
                            print(viewModel.myorder.remove(at: index).ownerName)
                            
                        }
                        
                        
                    }
                }
                
            }
            
            HStack {
                Spacer()
                
                Text("История")
                
                Spacer()
                
            }
            
            
            ForEach(viewModel.myorder) { item in
                
                if item.dataIsExpired {
                    
                    MyListingItemView(item: item) {
                        
                        if let index = viewModel.myorder.firstIndex(where: { $0.id == item.id }) {
                            
                            print(viewModel.myorder.remove(at: index).ownerName)
                            
                        }
                        
                    }
                    
                }
                
            }
            .frame(height: 160)
        }                .listStyle(PlainListStyle())
        
            .onAppear{
                viewModel.fetchOrder()
            }
        
    }
}
