//
//  TrainingListView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 18.03.21.
//

import SwiftUI

struct TrainingListView: View {
    var rifleid: Int64
    
    @State var trainings: [TrainingModel] = []
    
    
    var body: some View {
        ZStack {
            List(trainings) { training in
                NavigationLink(
                    destination: TrainingEditor(id: training.id)) {

                    HStack {
                        TrainingRow(idValue: training.id)
                        
                        Spacer()
                        
                        Button(action: {
                            //create db manager instance
                            let dbManager: DB_Manager = DB_Manager()
                            
                            //call delete function
                            dbManager.deleteTraining(idValue: training.id)
                            
                            //refresh the trainings array
                            self.trainings = dbManager.getTrainings(weaponid: rifleid)
                            
                        }, label: {
                            Image(systemName: "trash.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: TrainingAdd(rifleid: rifleid),
                            label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .padding()
                                    .background(Color.green)
                                    .clipShape(Circle())
                                    .padding([.bottom, .trailing])
                            }
                    )
                }
            }
        }
        .onAppear(perform: {
            self.trainings = DB_Manager().getTrainings(weaponid: rifleid)
        })
    }
}

struct TrainingListView_Previews: PreviewProvider {
    
    static var previews: some View {
        TrainingListView(rifleid: 1)
    }
}
