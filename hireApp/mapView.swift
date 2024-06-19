//
//  Mapview.swift
//  BuildHireApp
//
//  Created by 함지수 on 6/7/24.
//

import SwiftUI
import MapKit

struct JobPostingMap: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @Binding var jobPostings: [JobPosting]

    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region, annotationItems: jobPostings) { jobPosting in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: jobPosting.latitude ?? 0, longitude: jobPosting.longitude ?? 0)) {
                    NavigationLink(destination: SessionView(jobPosting: .constant(jobPosting))) {
                        ZStack {
                            Image(systemName: "bubble.right.fill") // 말풍선 아이콘
                                .resizable()
                                .frame(width: 80, height: 30) // 말풍선 크기 조절
                                .foregroundColor(.blue)
                            
                            Text(jobPosting.project) // 프로젝트 이름 표시
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle("Job Postings Map")
        }
    }
}
