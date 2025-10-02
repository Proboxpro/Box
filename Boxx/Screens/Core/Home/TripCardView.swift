//
//  TripCardView.swift
//  Boxx
//
//  Created by Assistant on 02.10.2025.
//

import SwiftUI

struct TripCardView: View {
    var item: TripItem
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 240, height: 170)
                .clipped()
                .cornerRadius(12)
            
            LinearGradient(colors: [.black.opacity(0.0), .black.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                .cornerRadius(12)
                .frame(width: 240, height: 140)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                HStack {
                    Text(item.price)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .semibold))
                    Spacer()
                    Text(item.author)
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                }
            }
            .padding(12)
        }
        .frame(width: 240, height: 170)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
    }
}

struct TripCardView_Previews: PreviewProvider {
    static var previews: some View {
        TripCardView(item: TripItem(id: "1", imageName: "Background", title: "Мурманск - Санкт-Петербург", price: "6000 ₽", author: "Alexander"))
    }
}


