//
//  ConversationRowView.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 17.11.2023.
//

import SwiftUI

struct ConversationRowView: View {
    var conversationTitle: String
    var imageURL: URL?
    var latestMessageText: String
    var formattedDateString: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15){
            AsyncImage(url: imageURL, content: { image in
                image
                    .resizable()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
            }, placeholder: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundColor(Color(.systemGray))
            })
            
            VStack(alignment: .leading, spacing: 4){
                Text(conversationTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(latestMessageText)
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack{
                Text(formattedDateString)
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            
        }
        .padding()
        .frame(height: 72)
    }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationRowView(conversationTitle: "Вася Пупкин", latestMessageText: "Привет спишь?)", formattedDateString: "Yesterday")
    }
}
