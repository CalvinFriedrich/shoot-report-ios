//
//  TrainingEditor.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import SwiftUI
import Combine

struct TrainingEditor: View {
    @State private var showingAlert = false
    
    @Environment(\.managedObjectContext) private var viewContext
    var training: Training
    
    @State private var numOfShots = "0"
    @State private var sumShots = 0.0
    
    @State var moodEmote: MoodModel.Mood = MoodModel.Mood.happy
    @State var trainingCase: String = ""
    @State var place: String = ""
    @State var date: Date = Date()
    @State var count: Int64 = 0
    @State var shots = ["0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0"]
    @State var score: Double = 0
    @State var comment: String = ""
    @State var rifleid: Int64 = 0
    
    let buttonWidth = UIScreen.main.bounds.width/10
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    private func result() {
        var shotOne = Double(shots[0]) ?? 0.0
        var shotTwo = Double(shots[1]) ?? 0.0
        var shotThree = Double(shots[2]) ?? 0.0
        let sumShotsSetOne = shotOne + shotTwo + shotThree
        
        shotOne = Double(shots[3]) ?? 0.0
        shotTwo = Double(shots[4]) ?? 0.0
        shotThree = Double(shots[5]) ?? 0.0
        let sumShotsSetTwo =  shotOne + shotTwo + shotThree
        
        shotOne = Double(shots[6]) ?? 0.0
        shotTwo = Double(shots[7]) ?? 0.0
        shotThree = Double(shots[8]) ?? 0.0
        let sumShotsSetThree = shotOne + shotTwo + shotThree
        
        sumShots = sumShotsSetOne + sumShotsSetTwo + sumShotsSetThree
        
        count = Int64(numOfShots) ?? 0
        
        if count == 0 {
            score = sumShots
        } else {
            score = sumShots / Double(count)
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List {
                    Picker("Mood", selection: $moodEmote) {
                        ForEach(MoodModel.Mood.allCases) { mood in
                            Text(mood.rawValue).tag(mood)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    HStack {
                        Text("What did you train?").bold()
                        Divider()
                        TextField("Training", text: $trainingCase)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Where did you train?").bold()
                        Divider()
                        TextField("Location", text: $place)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    DatePicker(selection: $date, displayedComponents: .date) {
                        Text("Date").bold()
                    }
                    
                    HStack {
                        Button(action: {
                            showingAlert = true
                        }, label: {
                            Text("PHOTO")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: geometry.size.width * 0.45)
                                .background(Color.blue)
                                .cornerRadius(5)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            showingAlert = true
                        }, label: {
                            Text("QR CODE")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: geometry.size.width * 0.45)
                                .background(Color.blue)
                                .cornerRadius(5)
                        })
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack {
                        Text("Number of Shots").bold()
                        Divider()
                        TextField(numOfShots, text: $numOfShots)
                            .keyboardType(.numberPad)
                            .onReceive(Just(numOfShots)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.numOfShots = filtered
                                }
                            }
                    }
                    
                    VStack {
                        HStack {
                            VStack(spacing: 0.0) {
                                Text("Shot 1").bold()
                                TextField("0", text: $shots[0])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Shot 2").bold()
                                TextField("0", text: $shots[1])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Shot 3").bold()
                                TextField("0", text: $shots[2])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                        }
                        Divider()
                        
                        HStack {
                            VStack(spacing: 0.0) {
                                Text("Shot 4").bold()
                                TextField("0", text: $shots[3])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Shot 5").bold()
                                TextField("0", text: $shots[4])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Shot 6").bold()
                                TextField("0", text: $shots[5])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                        }
                        Divider()
                        HStack {
                            VStack(spacing: 0.0) {
                                Text("Shot 7").bold()
                                TextField("0", text: $shots[6])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Shot 8").bold()
                                TextField("0", text: $shots[7])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            
                            VStack(spacing: 0.0) {
                                Text("Shot 9").bold()
                                TextField("0", text: $shots[8])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                        }
                    }
                    
                    
                    Group {
                        Text("Total Rings: \(sumShots, specifier: "%.1f")")
                            .onChange(of: shots, perform: { value in
                                result()
                            })
                        
                        
                        Text("Average: \(score, specifier: "%.2f")")
                            .onChange(of: numOfShots, perform: { value in
                                result()
                            })
                    }
                    
                    TextField("Enter a comment here: ", text: $comment)
                        .frame(height: 70)
                    
                    
                    HStack {
                        Button(action: {
                            showingAlert = true
                        }, label: {
                            Text("SHARE")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: geometry.size.width * 0.45)
                                .background(Color.blue)
                                .cornerRadius(5)
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        
                        Button(action: {
                            let shotsValue = shots.joined(separator: ",")
                            
                            training.moodEmote = self.moodEmote.rawValue
                            training.trainingCase = self.trainingCase
                            training.place = self.place
                            training.date = self.date
                            training.count = self.count
                            training.shots = shotsValue
                            training.score = self.score
                            training.comment = self.comment
                            training.rifleid = self.rifleid
                            
                            do {
                                try viewContext.save()
                            } catch {
                                // Replace this implementation with code to handle the error appropriately.
                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                            
                            //back to home menu
                            self.mode.wrappedValue.dismiss()
                        }, label: {
                            Text("SAVE")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: geometry.size.width * 0.45)
                                .background(Color.blue)
                                .cornerRadius(5)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .onAppear(perform: {
                    //populate
                    self.moodEmote = MoodModel.Mood(rawValue: training.moodEmote ?? "😁") ?? MoodModel.Mood.happy
                    self.trainingCase = training.trainingCase ?? ""
                    self.place = training.place ?? ""
                    self.date = training.date ?? Date()
                    self.count = training.count
                    self.shots = training.shots?.components(separatedBy: ",") ?? ["0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0"]
                    self.score = training.score
                    self.sumShots = score * Double(count)
                    self.comment = training.comment ?? ""
                    self.rifleid = training.rifleid
                    
                    numOfShots = String(count)
                })
                .disableAutocorrection(true)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Coming soon!"), message: Text("Stay tuned for future updates"), dismissButton: .default(Text("Got it!")))
                }
            }
            .navigationBarItems(
                trailing:
                    Button("Close mich!", action: {
                        mode.wrappedValue.dismiss()
                    })
            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TrainingEditor_Previews: PreviewProvider {
    static var previews: some View {
        TrainingEditor(training: Training())
    }
}
