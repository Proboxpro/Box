//
//  TabBarView.swift
//  Boxx
//
//  Created by Supunme Nanayakkarami on 18.12.2023.
//

import SwiftUI

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    let tabBarOptions: [String]

    var body: some View {
        HStack {
            ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)),
                    id: \.0,
                    content: {
                index, name in
                TabBarItem(currentTab: self.$currentTab, namespace: namespace.self, tabBarItemName: name, tab: index, totalTabs: tabBarOptions.count)
            })
        }
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab:Int
    
    var totalTabs: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack{
                Text(tabBarItemName)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(currentTab == tab ? .black : .gray)
                if currentTab == tab {
                    Color(.red)
                        .frame(width: (UIScreen.main.bounds.width / CGFloat(totalTabs)) * 0.4, height: 3)
                        .cornerRadius(100)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                } else {
                    Color.clear.frame(width: (UIScreen.main.bounds.width / CGFloat(totalTabs)) * 0.4, height: 3)
                }
            }
            .animation(.spring(), value: self.currentTab)
            .frame(width: (UIScreen.main.bounds.width / CGFloat(totalTabs)))
        }
    }
}

#Preview {
    TabBarView(currentTab: .constant(0), tabBarOptions: ["Option1", "Option2", "Option3", "Option4"])
}
