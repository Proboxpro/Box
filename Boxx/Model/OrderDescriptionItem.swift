//
//  OrderDescriptionItem.swift
//  Boxx
//
//  Created by Руслан Парастаев on 17.04.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct OrderDescriptionItem: Identifiable, Codable, Hashable {
    let id: String
    let documentId: String
    
    let announcementId: String
    let ownerId: String
    let recipientId: String
    
    let description: String?
    let image: URL?
    let price: Int?
    
    var isSent: Bool
    var isInDelivery: Bool
    var isDelivered: Bool
    
    let isCompleted: Bool
}

enum OrderStatus {
    case isSent, isInDelivery, isDelivered
}
