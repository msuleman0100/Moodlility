//
//  ContentView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/20/23.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    let devHeight = UIScreen.main.bounds.height
    let devWidth = UIScreen.main.bounds.width
    @State var newMood = ""
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Student.date, ascending: false)
    ]) var students: FetchedResults<Student>
    
    var body: some View {
        
            VStack {
                
                //Moods
                HStack {
                    Button {
                        addMood(mood: "Happy")
                    } label: {
                        moodView(nameAndEmojie: "😊\nHappy", bg: .green)
                    }

                    Button {
                        addMood(mood: "Normal")
                    } label: {
                        moodView(nameAndEmojie: "🙁\nNormal", bg: .orange)
                    }
                    
                    Button {
                        addMood(mood: "Down")
                    } label: {
                        moodView(nameAndEmojie: "😔\nDown", bg: .red)
                    }
                    
                }
              
                Divider()
                    .padding(.vertical, 32)

                //Moods list...
                List(students, id: \.self) { std in
                    VStack(alignment: .leading) {
                        Text(std.mood ?? "Unknown")
                                .font(.title3)
                        Text("\(std.date ?? Date.now)")
                            .opacity(0.7)
                    }
                }
                
            }
            .background(Color.black.opacity(0.03))
       
    }
    
    func addMood(mood: String) {
        let student = Student(context: moc)
        student.id = UUID()
        student.mood = mood
        student.date = Date.now
        try? moc.save()
    }
    
    @ViewBuilder func moodView(nameAndEmojie: String, bg: Color) -> some View {
        Text(nameAndEmojie)
            .font(.title)
            .multilineTextAlignment(.center)
            .frame(width: devWidth/3.5, height: devWidth/4)
            .background(bg)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: .white, radius: 5)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
