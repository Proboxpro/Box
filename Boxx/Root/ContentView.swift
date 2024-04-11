//
//  ContentView.swift
//  Boxx
//
//  Created by Nikita Larin on 16.11.2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @EnvironmentObject var viewModel:  AuthViewModel

    var body: some View {
        Group{
            
            if viewModel.userSession != nil {
                MainTabBar()
            }else {
                Login()
            }
        }
    }
}

@available(iOS 17.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
