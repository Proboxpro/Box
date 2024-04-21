//
//  MainSearch.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI

struct SearchParameters  {
//    enum SelectedParameters {
//        case dateAndCity
//        case date
//        case city
//        case none
//    }
//    
    var cityName: String = ""
    var startDate = Date()
    var endDate = Date()
    var datesIsSelected = false
}

//enum MainScrollViewStatus {
//    case location
//    case dates
//    case killo
//}

@available(iOS 17.0, *)
struct MainSearch: View {
    @State private var showDestinationSearchView = false
    @State private var searchBarIsEmpty = true
    @EnvironmentObject var viewModel: AuthViewModel
    @State var searchParameters = SearchParameters()
    
    //    @StateObject var searchViewModel :  DestinationSearchViewModel
    
    //    @State private var currentCityName: String = ""
    
    let user: User
    
    var body: some View {
        NavigationStack{
            if showDestinationSearchView{
                DestinationSearchView(show: $showDestinationSearchView, parameters: $searchParameters)
            } else{
                MainScrollView()
            }
        }
    }
    
    
    //MARK: - Views
    func MainScrollView()->some View {
        ScrollView{
            LazyVStack(spacing: 5){
                let filteredOnParamOrder = searchParameters.cityName == "" ? viewModel.myorder : viewModel.filteredOnParam(searchParameters, searchBarIsEmpty: searchBarIsEmpty)
                let isOrderFound = !filteredOnParamOrder.isEmpty && searchParameters.cityName != ""
                
                if isOrderFound && !searchBarIsEmpty {
                    SearchAndFilterWithCity(cityName: searchParameters.cityName, SearchBarIsEmpty: $searchBarIsEmpty)
                } else {
                    SearchAndFilter(SearchBarIsEmpty: $searchBarIsEmpty, showDestinationSearchView: $showDestinationSearchView)
                }
                
                let ordersToShow = filteredOnParamOrder.filter({$0.startdate.toDate()! >= Date()})
                
                if ordersToShow.isEmpty {
                    OrdersNotFoundView()
                } else {
                    ForEach(ordersToShow) {item in NavigationLink(value: item){ ListingitemView(item: item)
                            .scrollTransition{
                                content, phase in content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.85)
                                    .opacity(phase.isIdentity ? 1 : 0.85)
                            }
                    }
                    }
                    .frame(height: 160)
                }
            }
        }
        .navigationDestination(for: ListingItem.self){ item in
            ListingDetail(item: item)
                .environmentObject(self.viewModel)
                .navigationBarBackButtonHidden()
            
        }
        .onAppear{
            viewModel.fetchOrder()
        }
    }
    
    //MARK: - Views
    func OrdersNotFoundView()->some View {
        VStack {
            HStack {
                Image(systemName: "rectangle.and.text.magnifyingglass")
                Text("отправлений не найдено")
            }
            .foregroundColor(.gray)
        }
    }
}


