//
//  MainSearch.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI
@available(iOS 17.0, *)
struct MainSearch: View {
    @State private  var showDestinationSearchView = false
    @EnvironmentObject var viewModel: AuthViewModel
    let user: User
    
    
    
    
    var body: some View {
        NavigationStack{
            if showDestinationSearchView{
                DestinationSearchView (show: $showDestinationSearchView)
            } else{
                ScrollView{
                    LazyVStack(spacing: 5){
                        SearchAndFilter()
                        
                            .onTapGesture {
                                withAnimation{
                                    showDestinationSearchView.toggle()
                                }
                            }
                        ForEach(viewModel.orders) {item in NavigationLink(value: item){ ListingitemView(item: item)
                                .scrollTransition{
                                    content, phase in content
                                        .scaleEffect(phase.isIdentity ? 1 : 0.85)
                                        .opacity(phase.isIdentity ? 1 : 0.85)
                                }
                            
                        }
                        }
                        .frame(height: 160)
                    }
                }  .navigationDestination(for: ListingItem.self){ item in
//                    ListingDetail(item: item)
                    ListingDetail(item: item)
                        .environmentObject(ListingViewModel(authViewModel: self.viewModel))
                        .navigationBarBackButtonHidden()
                    
                }.onAppear{
                    viewModel.fetchOrder()
                }
            }
            
        }
    }
}


