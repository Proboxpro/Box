//
//  BoxxApp.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI
import Firebase

@available(iOS 17.0, *)
@main
struct BoxxApp: App {
    @StateObject var viewModel = AuthViewModel()
//    @StateObject var searchViewModel : DestinationSearchViewModel
    
    init(){
        FirebaseApp.configure()
//        searchViewModel = DestinationSearchViewModel(authViewModel: viewModel)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)

        }
    }
}
