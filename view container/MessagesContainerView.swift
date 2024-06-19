//
//  MessagesContainerView.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 28/05/21.
//

import SwiftUI

struct MessagesContainerView: View {
    var body: some View {
        NavigationView {
            Text("메세지 및 비디오챗")
            .navigationBarTitle("", displayMode: .inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("user")
                            .font(Font.system(size: 20, weight: .bold))
                            .padding()
                            .frame(width: UIScreen.main.bounds.size.width / 2, alignment: .leading)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Image(systemName: "video")
                                .resizable()
                                .scaledToFit()
                                .font(.system(size: 20))
                                .padding(.trailing, 10)
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .font(.system(size: 20))
                        }
                    }
                })
        }
        .navigationBarHidden(true)
    }
}

struct MessagesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesContainerView()
    }
}
