import SwiftUI
import CoreLocation
import MapKit

struct JobPosting: Identifiable {
    var id = UUID()
    var project: String
    var location: String
    var jobTitle: String
    var description: String
    var salary: String
    var startDate: Date
    var endDate: Date
    var latitude: Double?
    var longitude: Double?

}

struct ContentView: View {
    @State private var jobPostings: [JobPosting] = [
        JobPosting(project: "Project A", location: "Seoul", jobTitle: "Civil Engineer", description: "3+ years of experience", salary: "$5,800/mon", startDate: Date(), endDate: Calendar.current.date(byAdding: .month, value: 6, to: Date())!, latitude: nil, longitude: nil),
    ]
    
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(jobPostings) { jobPosting in
                        NavigationLink(destination: JobPostingDetail(jobPosting: jobPosting)) {
                            JobPostingRow(jobPosting: jobPosting)
                        }
                    }
                    .onDelete(perform: deleteJobPosting)
                }
                .navigationBarTitle("Job Posting")
                .navigationBarItems(trailing: NavigationLink(destination: AddJobPostingView(jobPostings: $jobPostings)) {
                    Image(systemName: "plus")
                })
            }
            .tabItem {
                Image(systemName: "briefcase.fill")
                Text("Job Posting")
            }
            
            NavigationView {
                JobPostingMap(jobPostings: $jobPostings)
                
            }
            .tabItem {
                Image(systemName: "map.fill")
                Text("Job Seeking")
                
            }
        }
    }
    
    private func deleteJobPosting(at offsets: IndexSet) {
        jobPostings.remove(atOffsets: offsets)
    }
}
//구인 첫화면
struct JobPostingRow: View {
    var jobPosting: JobPosting
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(jobPosting.project)
                .font(.headline)
            Text(jobPosting.location)
                .font(.subheadline)
            Text(jobPosting.jobTitle)
                .font(.subheadline)
        }
    }
}
//구인상세정보 보이는 란
struct JobPostingDetail: View {
    var jobPosting: JobPosting
    var body: some View {
        VStack {
            Text("Project Title: \(jobPosting.project)")
                .font(.headline)
            Text("Address: \(jobPosting.location)")
                .font(.subheadline)
            Text("Job Title: \(jobPosting.jobTitle)")
                .font(.subheadline)
            Text("Salary: \(jobPosting.salary)").font(.subheadline)
            Text("Employment Period: \(formattedDateRange(start: jobPosting.startDate, end: jobPosting.endDate))")
            Text("Description: \(jobPosting.description)")
                .font(.subheadline)
        }
        .navigationBarTitle("Details")
    }
    private func formattedDateRange(start: Date, end: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return "\(dateFormatter.string(from: start)) ~ \(dateFormatter.string(from: end))"
    }
}
//날짜 형식 함수


//+눌렀을때 화면

struct AddJobPostingView: View {
    @Binding var jobPostings: [JobPosting]
    @State private var project: String = ""
    @State private var location: String = ""
    @State private var jobTitle: String = ""
    @State private var description: String = ""
    @State private var salary: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var showCoordinates: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Enter Job Information")) {
                TextField("Project Title", text: $project)
                HStack {
                    TextField("Address", text: $location)
                    Button(action: {
                        getCoordinates()
                    }) {
                        Text("Verify Address")
                    }
                }
                if showCoordinates {
                    Text("Address Verified.")
                        .font(.footnote)
                        .foregroundColor(.green)
                }

                TextField("Job Title", text: $jobTitle)
                TextField("Description", text: $description)
                TextField("Salary", text: $salary)
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
            }
            

            
            Button(action: addJobPosting) {
                Text("Add Job Information")
            }
        }
        .navigationBarTitle("Add Job Information")
    }
    
    //주소를 위도 경도로 바꾸는 함수

    private func getCoordinates() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                print("Address Not Found.")
                return
            }
            latitude = placemark.location?.coordinate.latitude ?? 0
            longitude = placemark.location?.coordinate.longitude ?? 0
            print("latitude: \(latitude), longitude: \(longitude)")
            showCoordinates = true
        }
        
    }
    //입력한 project 누적
    private func addJobPosting() {
        let newJobPosting = JobPosting(project: project, location: location, jobTitle: jobTitle, description: description, salary: salary, startDate: startDate, endDate: endDate, latitude: latitude, longitude: longitude)
        jobPostings.append(newJobPosting)
        project = ""
        location = ""
        jobTitle = ""
        description = ""
        salary = ""
        startDate = Date() // 초기화
        endDate = Date() // 초기화
        latitude = 0 // 초기화
        longitude = 0 // 초기화
        showCoordinates = false // 초기화
    }
}

