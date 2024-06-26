//
//  ContentView.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 03/04/21.
//

import SwiftUI

struct RootContainerView: View {
    @State private var selectedView = 0

    var body: some View {
        TabView(selection: $selectedView) {
            ContentView()
                .tabItem {
                    selectedView == 1 ? Image(systemName: "person.circle.fill") : Image(systemName: "person.circle")
                }
                .tag(1)
            TimeLineContainerView()
                .tabItem {
                    selectedView == 0 ?
                        Image(systemName: "house.fill") : Image(systemName: "house")
                }
                .tag(0)
            ReelsContainerView()
                .tabItem {
                    selectedView == 2 ? Image(systemName: "film.fill") : Image(systemName: "film")
                }
                .tag(2)
            SearchContainerView()
                .tabItem {
                    selectedView == 3 ? Image(systemName: "magnifyingglass") : Image(systemName: "magnifyingglass")
                }
                .tag(3)            
            ProfileContainerView()
                .tabItem {
                    selectedView == 4 ? Image(systemName: "person.circle.fill") : Image(systemName: "person.circle")
                }
                .tag(4)
            ActivityContainerView()
                .tabItem {
                    selectedView == 5 ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                }
                .tag(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContainerView()
    }
}
