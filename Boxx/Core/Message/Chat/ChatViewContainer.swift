//
//  ChatView.swift
//  Boxx
//
//  Created by Максим Алексеев  on 28.02.2024.
//

import SwiftUI
import ExyteChat

struct ChatViewContainer: View {
    @EnvironmentObject var viewModel: ChatViewModel
    var body: some View {
        ChatView(messages: viewModel.messages) { draft in
            viewModel.sendMessage(draft)
        } 
        .interactiveDismissDisabled()
    }
}
//
//#Preview {
//    ChatViewContainer()
//        .environmentObject(ChatViewModel())
//}
