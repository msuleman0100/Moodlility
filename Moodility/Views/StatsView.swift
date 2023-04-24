//
//  StateView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/24/23.
//

import SwiftUI
import CoreData
import SwiftUICharts
import Charts

struct MoodData:Hashable {
    var date: String
    var mood: String
}

struct PieMood {
    let name: String
    let percentage: Double
    let color: Color
}


struct StatsView: View {
    
    @State var data = [
         MoodData(date: "Apr 18", mood: "Happy"),
         MoodData(date: "Apr 19", mood: "Normal"),
         MoodData(date: "Apr 20", mood: "Bad"),
         MoodData(date: "Apr 21", mood: "Normal"),
         MoodData(date: "Apr 22", mood: "Happy"),
         MoodData(date: "Apr 23", mood: "Happy"),
         MoodData(date: "Apr 24", mood: "Normal"),
     ]
    let loggedInUsername = UserDefaults.standard.string(forKey: "loggedInUsername")
    @State var moods: [Mood] = []
    @Environment(\.managedObjectContext) var moc
   
     
     var body: some View {
         
         VStack {
             
             VStack(alignment: .leading, spacing: 0) {
                 Text("Weekly Reports")
                     .font(.title2)
                     .padding(.horizontal)
                     .padding(.vertical, 10)
                 
                 Spacer()
                 
                 HStack(alignment: .bottom) {
                     Spacer()
                     ForEach(data, id: \.self) { day in
                         VStack(spacing: 10) {
                             Text(day.mood)
                                 .font(.footnote)
                                 .rotationEffect(.degrees(-90))
                                 .padding(.bottom, 5)
                             Rectangle()
                                 .fill(getBarColor(mood: day.mood))
                                 .frame(width: 12, height: getBarHeight(mood: day.mood))
                                 .cornerRadius(10)
                             Text(day.date)
                                 .bold()
                         }
                         .padding(.bottom, 5)
                         Spacer()
                     }
                 }
                 
             }
             .frame(height: 300, alignment: .bottom)
             .background(Color.red.opacity(0.2))
             .cornerRadius(16)
             .padding()
             
             VStack(alignment: .leading) {
                 Text("Previous Moods")
                     .font(.title2)
                     .padding(.horizontal)
                 ScrollView(showsIndicators: false) {
                     ForEach(moods, id: \.self) { mood in
                         VStack(alignment: .leading, spacing: 10) {
                             Text("**\(mood.wrappedMood)**")
                                 .font(.title3)
                             Text(mood.wrappedDate)
                                 .opacity(0.9)
                         }
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .foregroundColor(.white)
                         .padding(10)
                         .background(mood.wrappedMood == "Happy" ? Color.green:mood.wrappedMood == "Normal" ? Color.orange:Color.red)
                         .cornerRadius(12)
                         .padding(.horizontal)
                         .padding(.top, 2)
                     }
                 }
             }
            
         }
         .padding(.bottom, 1)
         .onAppear() { fetchUserMoods() }
         
     }
    
    func getBarHeight(mood: String) -> CGFloat {
        var value: CGFloat = 0.0
        if mood == "Happy" {
            value = 150
        } else if mood == "Normal" {
            value = 100
        } else if mood == "Down" {
            value = 60
        }
        return value
    }
    
    func getBarColor(mood: String) -> Color {
        var value: Color = .green
        if mood == "Happy" {
            value = .green
        } else if mood == "Normal" {
            value = .orange
        } else if mood == "Down" {
            value = .red
        }
        return value
    }
    
    func fetchUserMoods() {
        if let user = loggedInUsername?.lowercased()  {
            print("\nUser - \(user)\n")
            let request = NSFetchRequest<Mood>(entityName: "Mood")
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Mood.date, ascending: false)]
            do {
                let moods = try moc.fetch(request)
                if moods.isEmpty {
                    print("\nMoods not found")
                } else {
                    print("\nMoods found and listed below...\n")
                    withAnimation { self.moods.removeAll() }
                    var counter = 1
                    data.removeAll()
                    for mood in moods {
                        if mood.user?.username!.lowercased() == user {
                            if counter <= 7 {
                                let date = mood.date ?? Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd"
                                let chartDate = formatter.string(from: date)
                                let chartMood = mood.mood ?? "Unknown"
                                data.append(.init(date:"\(chartDate)", mood: chartMood))
                            }
                            counter += 1
                            self.moods.append(mood)
                        }
                    }
                }
            } catch {
                print("Error while fetching moods on onAppear:\n\(error)")
            }
        } else {
            print("User does not exists - \(loggedInUsername?.lowercased() ?? "empty")")
        }
    }
 }

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()

    }
}
