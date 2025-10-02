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
    
    var body: some View {
//        if let user = viewModel.currentUser{
            if true {
            TabView{
//                MainSearch(user: user)
//                MainSearch(user: User(id: "123", fullname: "vsy", login: "sa", email: "santa51@amil.ru"))
                HomeView()
//                TestView()
                    .tag("1")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                Search()
//                TestView()
                    .tag("2")
                    .tabItem {
                        Image(systemName: "plus.circle")
                    }
                
                OrdersList()
//                TestView()
                    .tag("3")
                    .tabItem {
                        Image(systemName: "message")
                    }
                Profile()
//                TestView()
                    .tag("4")
                    .tabItem {
                        Image(systemName: "person")
                    }
                //                Test1()
            }
        }
    }
}


#Preview {
    MainTabBar().environmentObject(AuthViewModel())
}
