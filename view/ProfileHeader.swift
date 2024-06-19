//
//  ProfileHeader.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 23/05/21.
//

import SwiftUI

struct ProfileHeader: View {
    
    let user: User
    
    var body: some View {
        HStack {
            Image(user.userImage)
                .resizable()
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(60)
                .clipped()
                .padding()
            Spacer()
            
            VStack {
                Text("11")
                    .font(Font.system(size: 16, weight: .bold))
                Text("Posts")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()

            VStack {
                Text("364")
                    .font(Font.system(size: 16, weight: .bold))
                Text("visitors")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()

            VStack {
                Text("358")
                    .font(Font.system(size: 16, weight: .bold))
                Text("interests")
                    .font(Font.system(size: 14, weight: .medium))
            }
            Spacer()
        }

        HStack {
            Text("연세대학교 건설환경공학과 #Programmer \nAiming to work at Hyundai #constructuion \nLoves Physics ")
                .font(.caption)
                .padding(.horizontal)
            Spacer()
        }
        
    }
}

struct ProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeader(user: User(userName: "student", userImage: "sample_post"))
    }
}
