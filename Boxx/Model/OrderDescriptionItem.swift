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
    
    let announcementId: String
    let ownerId: String
    let recipientId: String
    
    let description: String?
    let image: URL?
    let price: Int?
    
    let isSent: Bool
    let isInDelivery: Bool
    let isDelivered: Bool
    
    let isCompleted: Bool
}
