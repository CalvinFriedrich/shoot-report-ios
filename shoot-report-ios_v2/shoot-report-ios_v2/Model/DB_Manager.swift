//
//  Training_Manager.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 30.03.21.
//

import Foundation
import SQLite

class DB_Manager {
    private var db: Connection!
    private var trainings: Table!
    
    private var id: Expression<Int64>!
    private var moodEmote: Expression<String>!
    private var trainingCase: Expression<String>!
    private var place: Expression<String>!
    private var date: Expression<Date>!
    private var count: Expression<Int64>!
    private var shots: Expression<String>!
    private var score: Expression<Double>!
    private var comment: Expression<String>!
    private var rifleid: Expression<Int64>!
    
    private var weapons: Table!
    
    private var weaponid: Expression<Int64>!
    private var name: Expression<String>!
    private var shown: Expression<Bool>!
    
    init (){
        
        //exception handling
        do {
            
            //path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            db = try Connection("\(path)/report.sqlite3")
            
            //creating table object
            trainings = Table("trainings")
            
            //create instances of each column
            id = Expression<Int64>("id")
            moodEmote = Expression<String>("moodEmote")
            trainingCase = Expression<String>("trainingCase")
            place = Expression<String>("place")
            date = Expression<Date>("date")
            count = Expression<Int64>("count")
            shots = Expression<String>("shots")
            score = Expression<Double>("score")
            comment = Expression<String>("comment")
            rifleid = Expression<Int64>("rifleid")
            
            //creating table object
            weapons = Table("weapons")
            
            //create instances of each column
            weaponid = Expression<Int64>("weaponid")
            name = Expression<String>("name")
            shown = Expression<Bool>("shown")
            
            //create the table
            try db.run(trainings.create(ifNotExists: true) { (t) in
                t.column(id, primaryKey: true)
                t.column(moodEmote)
                t.column(trainingCase)
                t.column(place)
                t.column(date)
                t.column(count)
                t.column(shots)
                t.column(score)
                t.column(comment)
                t.column(rifleid)
            })
            try db.run(weapons.create(ifNotExists: true) { (t) in
                t.column(weaponid, primaryKey: true)
                t.column(name)
                t.column(shown)
            })
            
            //check if the weapons have been filled with the initial data
            let isPreloaded = UserDefaults.standard.bool(forKey: "isPreloaded")
            if !isPreloaded {
                addDefaults()
                UserDefaults.standard.set(true, forKey: "isPreloaded")
            }

            
        } catch {
            //show error message if something went wrong
            print(error.localizedDescription)
        }
    }
    
    
    
    public func addWeapon(nameValue: String, shownValue: Bool) {
        do {
            try db.run(weapons.insert(name <- nameValue, shown <- shownValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteWeapon(idValue: Int64) {
        do {
            //get weapon using id
            let weapon: Table = weapons.filter(weaponid == idValue)
 
            //make weapon invisible
            try db.run(weapon.update(shown <- false))
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getWeapons() -> [WeaponModel] {
        //create empty array
        var weaponModels: [WeaponModel] = []
        
        //get all trainings in ascending order
        weapons = weapons.order(weaponid.asc)
        
        //exception handling
        do {
            
            //loop through all users
            for weapon in try db.prepare(weapons.filter(shown == true)) {
                
                //create new model in each iteration
                let weaponModel: WeaponModel = WeaponModel()
                
                //set values in model from database
                weaponModel.id = weapon[weaponid]
                weaponModel.name = weapon[name]
                
                //append in new array
                weaponModels.append(weaponModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return weaponModels
    }
    
    public func getWeapon(idValue: Int64) -> WeaponModel {
        //create an empty object
        let weaponModel: WeaponModel = WeaponModel()
        
        //exception handling
        do {
            
            //get training using id
            let weapon: AnySequence<Row> = try db.prepare(weapons.filter(weaponid == idValue))
            
            //get row
            try weapon.forEach({ rowValue in
                //set values in model
                weaponModel.id = try rowValue.get(weaponid)
                weaponModel.name = try rowValue.get(name)
                weaponModel.shown = try rowValue.get(shown)
            })
            
        } catch {
            print(error.localizedDescription)
        }
        
        return weaponModel
    }
    
    
    
    public func addTraining(moodEmoteValue: String, trainingValue: String, placeValue: String, dateValue: Date, countValue: Int64, shotsValue: String, scoreValue: Double, commentValue: String, rifleidValue: Int64) {
        do {
            try db.run(trainings.insert(moodEmote <- moodEmoteValue, trainingCase <- trainingValue, place <- placeValue, date <- dateValue, count <- countValue, shots <- shotsValue, score <- scoreValue, comment <- commentValue, rifleid <- rifleidValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteTraining(idValue: Int64) {
        do {
            //get training using id
            let training: Table = trainings.filter(id == idValue)
            
            //run the delete query
            try db.run(training.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getTrainings(weaponid: Int64) -> [TrainingModel] {
        //create empty array
        var trainingModels: [TrainingModel] = []
        
        //get all trainings in ascending order
        trainings = trainings.order(id.asc)
        
        //exception handling
        do {
            
            //loop through all trainings
            for training in try db.prepare(trainings.filter(weaponid == rifleid)) {
                
                //create new model in each iteration
                let trainingModel: TrainingModel = TrainingModel()
                
                //set values in model from database
                trainingModel.id = training[id]
                trainingModel.moodEmote = TrainingModel.Mood(rawValue: training[moodEmote])!
                trainingModel.trainingCase = training[trainingCase]
                trainingModel.place = training[place]
                trainingModel.date = training[date]
                trainingModel.count = training[count]
                trainingModel.shots = training[shots]
                trainingModel.score = training[score]
                trainingModel.comment = training[comment]
                
                //append in new array
                trainingModels.append(trainingModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return trainingModels
    }
    
    public func updateTraining(idValue: Int64, moodEmoteValue: String, trainingValue: String, placeValue: String, dateValue: Date, countValue: Int64, shotsValue: String, scoreValue: Double, commentValue: String, rifleidValue: Int64) {
        do {
            //get training using id
            let training: Table = trainings.filter(id == idValue)
            
            //run the update query
            try db.run(training.update(moodEmote <- moodEmoteValue, trainingCase <- trainingValue, place <- placeValue, date <- dateValue, count <- countValue, shots <- shotsValue, score <- scoreValue, comment <- commentValue, rifleid <- rifleidValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getTraining(idValue: Int64) -> TrainingModel {
        //create an empty object
        let trainingModel: TrainingModel = TrainingModel()
        
        //exception handling
        do {
            
            //get training using id
            let training: AnySequence<Row> = try db.prepare(trainings.filter(id == idValue))
            
            //get row
            try training.forEach({ rowValue in
                //set values in model
                trainingModel.id = try rowValue.get(id)
                trainingModel.moodEmote = TrainingModel.Mood(rawValue: try rowValue.get(moodEmote))!
                trainingModel.trainingCase = try rowValue.get(trainingCase)
                trainingModel.place = try rowValue.get(place)
                trainingModel.date = try rowValue.get(date)
                trainingModel.count = try rowValue.get(count)
                trainingModel.shots = try rowValue.get(shots)
                trainingModel.score = try rowValue.get(score)
                trainingModel.comment = try rowValue.get(comment)
                trainingModel.rifleid = try rowValue.get(rifleid)
            })
        } catch {
            print(error.localizedDescription)
        }
        
        return trainingModel
    }
    
    
    
    public func getGraph(weaponid: Int64) -> ([Double], [Double]) {
        var wholeRings: [Double] = []
        var tenthRings: [Double] = []
        
        //get all trainings in ascending order
        trainings = trainings.order(id.asc)
        
        //exception handling
        do {
            
            //loop through all trainings
            for training in try db.prepare(trainings.filter(weaponid == rifleid)) {
                let rings = training[score]
                
                //check if the result is an integer (= a score with whole rings)
                if floor(rings) == rings {
                    wholeRings.append(rings)
                } else {
                    tenthRings.append(rings)
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return (wholeRings, tenthRings)
    }
    
    
    
    //function to fill the weapon table with initial data
    //only called when app is executed for the first time, but table is immutable for user
    public func addDefaults() {
        addWeapon(nameValue: "Rifle1", shownValue: true)
        addWeapon(nameValue: "Rifle2", shownValue: true)
        addWeapon(nameValue: "Rifle3", shownValue: false)
        addWeapon(nameValue: "Rifle4", shownValue: true)
    }
}
