//
//  ContentView.swift
//  hireApp
//
//  Created by snlcom on 6/8/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct JobPosting: Identifiable {
    var id = UUID()
    var project: String
    var location: String
    var jobTitle: String
    var description: String
    var latitude: Double? // 위도
    var longitude: Double? // 경도

}

struct ContentView: View {
    @State private var jobPostings: [JobPosting] = [
        JobPosting(project: "building A", location: "서울시", jobTitle: "토목기사", description: "경력 3년 이상", latitude: nil, longitude: nil),
        JobPosting(project: "building B",location: "강원도", jobTitle: "건축기사", description: "경력 무관", latitude: nil, longitude: nil)
    ]
    
    var body: some View {
        TabView {
            // 구인 탭
            NavigationView {
                List {
                    ForEach(jobPostings) { jobPosting in
                        NavigationLink(destination: JobPostingDetail(jobPosting: jobPosting)) {
                            JobPostingRow(jobPosting: jobPosting)
                        }
                    }
                    .onDelete(perform: deleteJobPosting)
                }
                .navigationBarTitle("구인")
                .navigationBarItems(trailing: NavigationLink(destination: AddJobPostingView(jobPostings: $jobPostings)) {
                    Image(systemName: "plus")
                })
            }
            .tabItem {
                Image(systemName: "briefcase.fill")
                Text("구인")
            }
            
            // 구직 탭
            NavigationView {
                JobPostingMap(jobPostings: $jobPostings)
            }
            .tabItem {
                Image(systemName: "map.fill")
                Text("구직")
                
            }
        }
    }

    
    private func deleteJobPosting(at offsets: IndexSet) {
        jobPostings.remove(atOffsets: offsets)
    }
}


struct JobPostingRow: View {
    var jobPosting: JobPosting
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(jobPosting.project)
                .font(.headline)
            Text(jobPosting.location)
                .font(.headline)
            Text(jobPosting.jobTitle)
                .font(.subheadline)
            Text(jobPosting.description)
                .font(.subheadline)



        }
    }
}

struct JobPostingDetail: View {
    var jobPosting: JobPosting
    
    var body: some View {
        VStack {
            Text(jobPosting.project)
                .font(.headline)
            Text(jobPosting.location)
                .font(.headline)
            Text(jobPosting.jobTitle)
                .font(.subheadline)
            Text(jobPosting.description)
                .font(.subheadline)

        }
        .navigationBarTitle("구인 상세 정보")
    }
}

struct AddJobPostingView: View {
    @Binding var jobPostings: [JobPosting]
    @State private var project: String = ""
    @State private var location: String = ""
    @State private var jobTitle: String = ""
    @State private var description: String = ""
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var showCoordinates: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("구인 정보 입력")) {
                TextField("프로젝트", text: $project)
                TextField("위치", text: $location)
                TextField("직책", text: $jobTitle)
                TextField("설명", text: $description)
            }
            
            Button(action: {
                getCoordinates()
            }) {
                Text("위치 확인")
            }
            if showCoordinates {
                Text("위치가 확인되었습니다.")
                Text("위도: \(latitude), 경도: \(longitude)")
            }
            
            Button(action: addJobPosting) {
                Text("구인 정보 추가")
            }
        }
        .navigationBarTitle("구인 정보 추가")
    }
    
    private func getCoordinates() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                print("위치를 찾을 수 없습니다.")
                return
            }
            latitude = placemark.location?.coordinate.latitude ?? 0
            longitude = placemark.location?.coordinate.longitude ?? 0
            print("위도: \(latitude), 경도: \(longitude)")
            showCoordinates = true
        }
        
    }
    
    private func addJobPosting() {
        let newJobPosting = JobPosting(project: project, location: location, jobTitle: jobTitle, description: description, latitude: latitude, longitude: longitude)
        jobPostings.append(newJobPosting)
        project = ""
        location = ""
        jobTitle = ""
        description = ""
        latitude = 0 // 초기화
        longitude = 0 // 초기화
        showCoordinates = false // 초기화
    }
}
