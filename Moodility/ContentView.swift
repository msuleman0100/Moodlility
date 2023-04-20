//
//  ContentView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/20/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var newMood = ""
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        NavigationView {
            
            VStack {
                TextField("How do you feel today!", text: $newMood)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button {
                    
                    let student = Student(context: moc)
                    student.id = UUID()
                    student.name = newMood
                    try? moc.save()
                    
                } label: {
                    Text("ADD")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal,32)
                        .padding(.vertical, 14)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Divider()
                    .padding(.vertical, 32)

                //Moods list...
                List(students, id: \.self) { std in
                    Text(std.name ?? "Unknown")
                            .font(.title3)
                }
            }
            
            .navigationTitle("Students")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
