//
//  ProfileView.swift
//  Boxx
//
//  Created by Nikita Larin on 18.12.2023.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            let user1 = Boxx.User(id:  "",
                                  fullname: "" , login: viewModel.profile?.imageUrl ?? "", email: "sdc", imageUrl: viewModel.order?.ownerImageUrl ?? "")
            
            UserProfileHome(size: size, safeArea: safeArea, user: user1)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
    
}

