//
//  HomeView.swift
//  Boxx
//
//  Created by Assistant on 02.10.2025.
//

import SwiftUI

struct HomeView: View {
    private let trips: [TripItem] = [
        .init(id: UUID().uuidString, imageName: "Background", title: "Мурманск - Санкт-Петербург", price: "6000 ₽", author: "Alexander"),
        .init(id: UUID().uuidString, imageName: "Image", title: "Мурманск - Торжок", price: "3500 ₽", author: " ")
    ]
    
    private let deals: [DealItem] = [
        .init(id: UUID().uuidString, thumbnail: "Image", title: "Platdo", subtitle: "Футболка", timeAgo: "1 час назад", price: "3200₽", avatar: "profile"),
        .init(id: UUID().uuidString, thumbnail: "Background", title: "Slam", subtitle: "Чемодан", timeAgo: "3 часа назад", price: "17500 ₽", avatar: "profile"),
        .init(id: UUID().uuidString, thumbnail: "Image", title: "Platdo", subtitle: "Футболка", timeAgo: "1 час назад", price: "3200₽", avatar: "profile"),
        .init(id: UUID().uuidString, thumbnail: "Background", title: "Slam", subtitle: "Чемодан", timeAgo: "3 часа назад", price: "17500 ₽", avatar: "profile"),
        .init(id: UUID().uuidString, thumbnail: "Image", title: "Platdo", subtitle: "Футболка", timeAgo: "1 час назад", price: "3200₽", avatar: "profile"),
        .init(id: UUID().uuidString, thumbnail: "Background", title: "Slam", subtitle: "Чемодан", timeAgo: "3 часа назад", price: "17500 ₽", avatar: "profile"),
        .init(id: UUID().uuidString, thumbnail: "Image", title: "Platdo", subtitle: "Футболка", timeAgo: "1 час назад", price: "3200₽", avatar: "profile"),
        .init(id: UUID().uuidString, thumbnail: "Background", title: "Slam", subtitle: "Чемодан", timeAgo: "3 часа назад", price: "17500 ₽", avatar: "profile")
    ]
    
    var body: some View {
            VStack(alignment: .leading, spacing: 24) {
                Text("Последние поездки")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(trips, id: \.id) { item in
                            TripCardView(item: item)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Text("Последние сделки")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.horizontal, 16)
                
                VStack(spacing: 16) {
                    ScrollView {
                        ForEach(deals, id: \.id) { deal in
                            DealRowView(item: deal)
                                .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 10)
    }
}

struct TripItem: Hashable {
    var id: String
    var imageName: String
    var title: String
    var price: String
    var author: String
}

struct DealItem: Hashable {
    var id: String
    var thumbnail: String
    var title: String
    var subtitle: String
    var timeAgo: String
    var price: String
    var avatar: String
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


