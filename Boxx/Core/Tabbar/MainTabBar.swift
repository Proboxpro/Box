//
//  MainTabBar.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI
import Firebase

@available(iOS 17.0, *)
struct MainTabBar: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedTab: Int = 0
    
    var body: some View {
        if let user = viewModel.currentUser{
            TabView{
                MainSearch(user: user)
                    .tag("1")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                Search()
                    .tag("2")
                    .tabItem {
                        Image(systemName: "plus.circle")
                    }
                
                ConversationsListView()
                    .tag("3")
                    .tabItem {
                        Image(systemName: "message")
                    }
                Profile()
                    .tag("4")
                    .tabItem {
                        Image(systemName: "person")
                    }
                Test1()
                    .tag("4")
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
            
            .onChange(of: selectedTab) { newValue in

            }
        }
        
    }
}


