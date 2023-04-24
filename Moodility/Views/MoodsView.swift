//
//  MoodsView.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/20/23.
//

import SwiftUI
import CoreData


struct MoodsView: View {
    
    let devHeight = UIScreen.main.bounds.height
    let devWidth = UIScreen.main.bounds.width
    @State var showPopup = false
    @Environment(\.managedObjectContext) var moc
    let loggedInUsername = UserDefaults.standard.string(forKey: "loggedInUsername")
    @State var moods: [Mood] = []
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                
                //Moods
                VStack(alignment: .leading, spacing: 5) {
                    Text("Moods")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    Text("How do you feel today!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding([.leading, .trailing, .bottom])
                }
                .padding(.top,32)
                HStack {
                    Spacer()
                    Button {
                        addMood(mood: "Happy")
                    } label: {
                        moodButton(nameAndEmojie: "😊\nHappy", bg: .green)
                    }
                    
                    Button {
                        addMood(mood: "Normal")
                    } label: {
                        moodButton(nameAndEmojie: "🙁\nNormal", bg: .orange)
                    }
                    
                    Button {
                        addMood(mood: "Down")
                    } label: {
                        moodButton(nameAndEmojie: "😔\nDown", bg: .red)
                    }
                    Spacer()
                }
                
                Divider().padding(.top, 32)
                
                //Moods list...
                Text("Recent Moods")
                    .font(.title)
                    .fontWeight(.medium)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color.black.opacity(0.03))
            .foregroundColor(.black)
            
            if showPopup {
                Text("**Today's Mood Has Already Added**")
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            
        }
        .padding(.bottom, 1)
        .onAppear() {
            fetchUserMoods()
            //UserDefaults.standard.set(false, forKey: "userExists")
        }
        
        .toolbar(.hidden, for: .navigationBar)
    }
    
    func fetchUserMoods() {
        if let user = loggedInUsername?.lowercased()  {
            print("\nUser - \(user)\n")
            let request = NSFetchRequest<Mood>(entityName: "Mood")
//            request.predicate = NSPredicate(format: "user.username == %@", user)
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Mood.date, ascending: false)]
            do {
                let moods = try moc.fetch(request)
                if moods.isEmpty {
                    print("\nMoods not found")
                } else {
                    print("\nMoods found and listed below...\n")
                    withAnimation { self.moods.removeAll() }
                    for mood in moods {
                        if mood.user?.username!.lowercased() == user {
                            self.moods.append(mood)
                            print("\nFound\n" + (mood.user?.username ?? "ok"))
                            print(user)
                            print(mood.mood ?? "pl")
                        } else {
                            print("\nNot found\n" + (mood.user?.username ?? "ok"))
                            print(user)
                            print(mood.mood ?? "pl")
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
    
    
    //For Saving New Mood
    func addMood(mood: String) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: Date())
        let date = formatter.date(from: stringDate)
        
        guard let user = loggedInUsername else {
            print("\nUsername not found here on addMood - \(loggedInUsername?.lowercased() ?? "empty")\n")
            return
        }
        
        let request = NSFetchRequest<Mood>(entityName: "Mood")
//        request.predicate = NSPredicate(format: "user.username == %@", "\(user)")
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \Mood.date, ascending: false)]
        
        do {
            
            let moods = try moc.fetch(request)
            
            var ifExists = false
            for mood in  moods {
                if mood.date == date && mood.user!.username!.lowercased() == user.lowercased() {
                    ifExists = true
                }
            }
            
            
            if !ifExists {
                
                let newMood = Mood(context: moc)
                newMood.id = UUID()
                newMood.mood = mood
                newMood.date = date
                newMood.user = User(context: moc)
                newMood.user?.username = user.lowercased()
                newMood.user?.displayName = "Muhammad Suleman"
                do {
                    try moc.save()
                } catch {
                    print("Error savnig mood: \(error)")
                }
                print("Justed Added Today's Mood.")
                fetchUserMoods()
            } else {
                 withAnimation { showPopup = true }
                 // Hide  popup after 2 seconds
                 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                     withAnimation { showPopup = false }
                 }
                 print("Today's Mood Has Already Been Added.")
             }
            
        } catch {
            print("Error fetching mood: \(error)")
        }
        
    }
    
    func deleteMood(_ newMood: Mood) {
        for mood in moods {
            if mood == newMood {
                moc.delete(mood)
                fetchUserMoods()
            }
        }
    }
    
    //Mood Updating Button - ViewBuilder
    @ViewBuilder func moodButton(nameAndEmojie: String, bg: Color) -> some View {
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
        MoodsView()
    }
}
