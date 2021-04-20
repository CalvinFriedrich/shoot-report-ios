//
//  ProcedureView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 19.04.21.
//

import SwiftUI

struct ProcedureView: View {
    var rifleid: Int64
    
    @State private var selectedTab: Int = 0
    
    @State var showPopup: Bool = false
    @State var preparation: String = ""
    @State var sequence: String = ""
    
    var body: some View {
        ZStack {
            //basic view
            VStack {
                Picker("Procedure", selection: $selectedTab) {
                    Text("PREPARATION").tag(0)
                    Text("SHOT SEQUENCE").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                switch selectedTab {
                    case 0:
                        VStack {
                            Text("My procedure before competition").foregroundColor(.green)
                                .padding()
                            Button(action: {
                                showPopup = true
                            }, label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Preparation")
                                        if preparation != "" {
                                            Text(preparation)
                                                .opacity(0.5)
                                        } else {
                                            Text("Not Set")
                                                .font(.subheadline)
                                                .opacity(0.5)
                                        }
                                    }
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 40)
                                    
                                    Spacer()
                                }
                            })
                        }
                    case 1:
                        VStack {
                            Text("My procedure for the shot").foregroundColor(.green)
                                .padding()
                            Button(action: {
                                showPopup = true
                            }, label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Shot Sequence")
                                        if sequence != "" {
                                            Text(sequence)
                                                .font(.subheadline)
                                                .opacity(0.5)
                                        } else {
                                            Text("Not Set")
                                                .font(.subheadline)
                                                .opacity(0.5)
                                        }
                                    }
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 40)
                                    
                                    Spacer()
                                }
                            })
                        }
                    default: Text("Error")
                }
                
                Spacer()
            }
            
            //Pop Up
            
            if showPopup {
                if selectedTab == 0 {
                    ZStack {
                        Color.white
                        VStack {
                            Text("Preparation").font(.title).bold()
                            Text("Here you can define what you do as ideal preparation.")
                            TextField("Preparation", text: $preparation)
                            HStack {
                                Spacer()
                                Button("CANCEL") {
                                    self.showPopup = false
                                }
                                Button("OK") {
                                    UserDefaults.standard.set(preparation, forKey: "preparation_\(rifleid)")
                                    self.showPopup = false
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(width: 300, height: 200)
                    .cornerRadius(20).shadow(radius: 20)
                }
                
                if selectedTab == 1 {
                    ZStack {
                        Color.white
                        VStack {
                            Text("Shot Sequence").font(.title).bold()
                            Text("Here you can note your ideal shot sequence.")
                            TextField("Procedure", text: $sequence)
                            HStack {
                                Spacer()
                                Button("CANCEL") {
                                    self.showPopup = false
                                }
                                Button("OK") {
                                    UserDefaults.standard.set(sequence, forKey: "sequence_\(rifleid)")
                                    self.showPopup = false
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(width: 300, height: 200)
                    .cornerRadius(20).shadow(radius: 20)
                }
            }
        }
        .onAppear(perform: {
            self.preparation = UserDefaults.standard.string(forKey: "preparation_\(rifleid)") ?? ""
            self.sequence = UserDefaults.standard.string(forKey: "sequence_\(rifleid)") ?? ""
        })
    }
}

struct ProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureView(rifleid: 1)
    }
}
