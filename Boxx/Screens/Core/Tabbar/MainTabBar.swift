//
//  MainTabBar.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 16.11.2023.
//

import SwiftUI
import Firebase

struct TestView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

//@available(iOS 17.0, *)
struct MainTabBar: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedTab: Int = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.gray.withAlphaComponent(0.1)  // фон таббара

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
//        if let user = viewModel.currentUser{
            if true {
            TabView{
//                Color.gray
//                MainSearch(user: user)
//                MainSearch(user: User(id: "123", fullname: "vsy", login: "sa", email: "santa51@amil.ru"))
                HomeView()
//                    .environmentObject(viewModel)
//                TestView()
                    .tag("1")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                Search()
//                TestView()
                    .tag("2")
                    .tabItem {
                        Image(systemName: "plus.circle")
                    }
                
                OrdersList()
                    .tag("3")
                    .tabItem {
                        Image(systemName: "message")
                    }
                Profile()
                    .tag("4")
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
        }
    }
}


#Preview {
    MainTabBar().environmentObject(AuthViewModel())
}
