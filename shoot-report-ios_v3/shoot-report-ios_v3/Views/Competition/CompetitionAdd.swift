//
//  CompetitionAdd.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 23.04.21.
//

import SwiftUI
import Combine

struct CompetitionAdd: View {
    @State private var showingAlert = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var shots = ["0.0", "0.0", "0.0", "0.0", "0.0", "0.0"]
    @State private var sumShots = 0.0
    private let count: Int64 = 6
    
    @State var competitionCase: String = ""
    @State var place: String = ""
    @State var date: Date = Date()
    @State var score: Double = 0
    @State var comment: String = ""
    var rifleid: Int64
    
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
        
        sumShots = sumShotsSetOne + sumShotsSetTwo
        
        score = sumShots / Double(count)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List {
                    HStack {
                        Text("Which mode did you shoot?").bold()
                        Divider()
                        TextField("Competition", text: $competitionCase)
                            .multilineTextAlignment(.trailing)
                    }
         
                    HStack {
                        Text("Where was your competition?").bold()
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
                        .buttonStyle(PlainButtonStyle())
                        
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
                        .buttonStyle(PlainButtonStyle())
                    }
         
                    VStack {
                        HStack {
                            VStack(spacing: 0.0) {
                                Text("Series 1").bold()
                                TextField("0", text: $shots[0])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Series 2").bold()
                                TextField("0", text: $shots[1])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Series 3").bold()
                                TextField("0", text: $shots[2])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                        }
                        Divider()
         
                        HStack {
                            VStack(spacing: 0.0) {
                                Text("Series 4").bold()
                                TextField("0", text: $shots[3])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Series 5").bold()
                                TextField("0", text: $shots[4])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            Divider()
                            VStack(spacing: 0.0) {
                                Text("Series 6").bold()
                                TextField("0", text: $shots[5])
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                        }
                    }
                    
                    Text("Total Rings: \(sumShots, specifier: "%.1f")")
                        .onChange(of: shots, perform: { value in
                            result()
                    })
                    
                    TextField("Competition report", text: $comment)
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
                            
                            //save competition method
                            
                            addCompetition()
                            
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
    
    private func addCompetition() {
        let shotsValue = shots.joined(separator: ",")
        
        withAnimation {
            let newCompetition = Competition(context: viewContext)
            newCompetition.id = UUID()
            newCompetition.competitionCase = competitionCase
            newCompetition.place = place
            newCompetition.date = date
            newCompetition.shots = shotsValue
            newCompetition.score = score
            newCompetition.comment = comment
            newCompetition.rifleid = rifleid
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

struct CompetitionAdd_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionAdd(rifleid: 1)
    }
}
