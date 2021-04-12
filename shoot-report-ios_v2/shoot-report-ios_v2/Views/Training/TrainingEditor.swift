//
//  TrainingEditor.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 23.03.21.
//

import SwiftUI
import Combine

struct TrainingEditor: View {
    var id: Int64
    
    @State private var numOfShots = "0"
    @State private var sumShots = 0.0
    
    @State var moodEmote: TrainingModel.Mood = TrainingModel.Mood.happy
    @State var training: String = ""
    @State var place: String = ""
    @State var date: Date = Date()
    @State var count: Int64 = 0
    @State var shots = ["0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0"]
    @State var score: Double = 0
    @State var comment: String = ""
    @State var rifleid: Int64 = 0
    
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
        List {
            Picker("Mood", selection: $moodEmote) {
                ForEach(TrainingModel.Mood.allCases) { mood in
                    Text(mood.rawValue).tag(mood)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            HStack {
                Text("What did you train?").bold()
                Divider()
                TextField("Training", text: $training)
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
                    print("Button 1 tapped")
                }, label: {
                    Text("PHOTO")
                        .foregroundColor(.white)
                        .padding()
                        .padding([.leading, .trailing], 45)
                        .background(Color.blue)
                        .cornerRadius(5)
                })
                
                Spacer()
                
                Button(action: {
                    print("Button 2 tapped")
                }, label: {
                    Text("QR CODE")
                        .foregroundColor(.white)
                        .padding()
                        .padding([.leading, .trailing], 45)
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
                    print("Button 3 tapped")
                }, label: {
                    Text("SHARE")
                        .foregroundColor(.white)
                        .padding()
                        .padding([.leading, .trailing], 45)
                        .background(Color.blue)
                        .cornerRadius(5)
                })
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    let shotsValue = shots.joined(separator: ",")
                    DB_Manager().updateTraining(idValue: self.id, moodEmoteValue: moodEmote.rawValue, trainingValue: self.training, placeValue: self.place, dateValue: self.date, countValue: self.count, shotsValue: shotsValue, scoreValue: self.score, commentValue: self.comment, rifleidValue: self.rifleid)
                    //back to home menu
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("SAVE")
                        .foregroundColor(.white)
                        .padding()
                        .padding([.leading, .trailing], 45)
                        .background(Color.blue)
                        .cornerRadius(5)
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear(perform: {
            //get data from database
            let trainingModel: TrainingModel = DB_Manager().getTraining(idValue: self.id)
            
            //populate
            self.moodEmote = trainingModel.moodEmote
            self.training = trainingModel.trainingCase
            self.place = trainingModel.place
            self.date = trainingModel.date
            self.count = trainingModel.count
            self.shots = trainingModel.shots.components(separatedBy: ",")
            self.score = trainingModel.score
            self.sumShots = score * Double(count)
            self.comment = trainingModel.comment
            self.rifleid = trainingModel.rifleid
            
            numOfShots = String(count)
        })
        .disableAutocorrection(true)
    }
}

struct TrainingEditor_Previews: PreviewProvider {
    @State static var id: Int64 = 0
    
    static var previews: some View {
        TrainingEditor(id: id)
    }
}
