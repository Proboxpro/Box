//
//  Search.swift
//  Boxx
//
//  Created by Nikita Larin on 20.03.2024.
//


//import SwiftUI
//@available(iOS 17.0, *)
//struct SearchC: View {
//    @State private  var showDestinationSearchView = false
//    @EnvironmentObject var viewModel: AuthViewModel
//    let user: User
//    
//    var body: some View {
//        NavigationStack{
//            if showDestinationSearchView{
//                DestinationSearchView (show: $showDestinationSearchView)
//            } else{
//                ScrollView{
//                    LazyVStack(spacing: 5){
//                        SearchAndFilter()
//                            .onTapGesture {
//                                withAnimation{
//                                    showDestinationSearchView.toggle()
//                                }
//                            }
//                        ForEach(viewModel.orders) {item in NavigationLink(value: item){ ListingitemView(item: item)}
//                        }
//                        .frame(height: 160)
//                    }
//                }  .navigationDestination(for: ListingItem.self){ item in
//                    //ListingDetail(item: item)
//                    ListingDetail(item: item)
//                        .environmentObject(ListingViewModel(authViewModel: self.viewModel))
//                        .navigationBarBackButtonHidden()
//                    
//                }.onAppear{
//                    viewModel.fetchOrder()
//                }
//            }
//            
//        }
//    }
//}
//
//#Preview {
//    if #available(iOS 17.0, *) {
//        SearchC()
//    } else {
//        // Fallback on earlier versions
//    }
//}
