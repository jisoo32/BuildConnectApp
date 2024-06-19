//
//  Session view.swift
//  BuildHireApp
//
//  Created by 함지수 on 6/8/24.
//


import SwiftUI


struct SessionView: View {
    @Binding var jobPosting: JobPosting
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Project Title: \(jobPosting.project)")
                    .font(.headline)
                Text("Address: \(jobPosting.location)")
                    .font(.headline)
                Text("Jop Title: \(jobPosting.jobTitle)")
                    .font(.subheadline)
                Text("Salary: \(jobPosting.salary)").font(.subheadline)
                Text("Employment Period: \(formattedDateRange(start: jobPosting.startDate, end: jobPosting.endDate))")
                Text("Description: \(jobPosting.description)")
                    .font(.subheadline)
            }
            .navigationBarTitle("Details")
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(jobPosting: .constant(JobPosting(
            project: "Project A",
            location: "Seoul",
            jobTitle: "Civil Engineer",
            description: "3+ years of experience",
            salary: "$5,800/mon~",
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .month, value: 6, to: Date())!,
            latitude: nil,
            longitude: nil
            
        )))
    }
}
//@State private var jobPostings: [JobPosting] = [
//    JobPosting(project: "building A", location: "Seoul", jobTitle: "Civil Enginner", description: "3+ years of experience", salary: "~원", startDate: Date(), endDate: Calendar.current.date(byAdding: .month, value: 6, to: Date())!, latitude: nil, longitude: nil),
    
private func formattedDateRange(start: Date, end: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    return "\(dateFormatter.string(from: start)) ~ \(dateFormatter.string(from: end))"
}
