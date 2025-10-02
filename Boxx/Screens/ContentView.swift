//
//  ContentView.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 16.11.2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @EnvironmentObject var viewModel:  AuthViewModel

    var body: some View {
        Group{
            //DEBUG: _
            if viewModel.userSession != nil {
                MainTabBar()
                    .environmentObject(viewModel)
//            Text("jher")
                //            TestView()
            } else {
                StartView()
                    .alert(viewModel.activeAlert?.title ?? "Сообщение", isPresented: $viewModel.isAlertPresented) {
                        Button("OK") { viewModel.dismissAlert() }
                    } message: {
                        Text(viewModel.activeAlert?.message ?? "")
                    }
            }
        }
    }
}

@available(iOS 17.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}
