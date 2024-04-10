//
//  ConversationListViewModel.swift
//  Boxx
//
//  Created by Максим Алексеев  on 10.03.2024.
//

import Foundation
import SwiftUI

class ConversationListViewModel: ObservableObject {
//    var filteredConversations: [Conversation] {
//        return MessageService.shared.conversations
//    }
    
    @Published var conversations: [Conversation] = []
    
    func fetchData() {
        Task {
            await MessageService.shared.getUsers()
            await MessageService.shared.getConversations()
            
            DispatchQueue.main.async {
                self.conversations = MessageService.shared.conversations
            }
        }
    }
    
    
    func subscribeToUpdates() {
        MessageService.shared.subscribeToUpdates()
    }
}
