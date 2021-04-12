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
    
    private var competitions: Table!
    
    private var comp_id: Expression<Int64>!
    private var competitionCase: Expression<String>!
    private var comp_place: Expression<String>!
    private var comp_date: Expression<Date>!
    private var comp_shots: Expression<String>!
    private var comp_score: Expression<Double>!
    private var comp_comment: Expression<String>!
    private var comp_rifleid: Expression<Int64>!
    
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
            
            //creating table object
            competitions = Table("competitions")
            
            //create instances of each column
            comp_id = Expression<Int64>("comp_id")
            competitionCase = Expression<String>("competitionCase")
            comp_place = Expression<String>("comp_place")
            comp_date = Expression<Date>("comp_date")
            comp_shots = Expression<String>("comp_shots")
            comp_score = Expression<Double>("comp_score")
            comp_comment = Expression<String>("comp_comment")
            comp_rifleid = Expression<Int64>("comp_rifleid")
            
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
            try db.run(competitions.create(ifNotExists: true) { (t) in
                t.column(comp_id, primaryKey: true)
                t.column(competitionCase)
                t.column(comp_place)
                t.column(comp_date)
                t.column(comp_shots)
                t.column(comp_score)
                t.column(comp_comment)
                t.column(comp_rifleid)
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
    
    
    public func addCompetition(competitionValue: String, placeValue: String, dateValue: Date, shotsValue: String, scoreValue: Double, commentValue: String, rifleidValue: Int64) {
        do {
            print("Hi")
            try db.run(competitions.insert(competitionCase <- competitionValue, comp_place <- placeValue, comp_date <- dateValue, comp_shots <- shotsValue, comp_score <- scoreValue, comp_comment <- commentValue, comp_rifleid <- rifleidValue))
            print("Bye")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteCompetition(idValue: Int64) {
        do {
            //get competition using id
            let competition: Table = competitions.filter(comp_id == idValue)
            
            //run the delete query
            try db.run(competition.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getCompetitions(weaponid: Int64) -> [CompetitionModel] {
        //create empty array
        var competitionModels: [CompetitionModel] = []
        
        //get all competitions in ascending order
        competitions = competitions.order(id.asc)
        
        //exception handling
        do {
            
            //loop through all competitions
            for competition in try db.prepare(competitions.filter(weaponid == comp_rifleid)) {
                
                //create new model in each iteration
                let competitionModel: CompetitionModel = CompetitionModel()
                
                //set values in model from database
                competitionModel.id = competition[comp_id]
                competitionModel.competitionCase = competition[competitionCase]
                competitionModel.place = competition[comp_place]
                competitionModel.date = competition[comp_date]
                competitionModel.shots = competition[comp_shots]
                competitionModel.score = competition[comp_score]
                competitionModel.comment = competition[comp_comment]
                
                //append in new array
                competitionModels.append(competitionModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return competitionModels
    }
    
    public func updateCompetition(idValue: Int64, competitionValue: String, placeValue: String, dateValue: Date, shotsValue: String, scoreValue: Double, commentValue: String, rifleidValue: Int64) {
        do {
            //get competition using id
            let competition: Table = competitions.filter(comp_id == idValue)
            
            //run the update query
            try db.run(competition.update(competitionCase <- competitionValue, comp_place <- placeValue, comp_date <- dateValue, comp_shots <- shotsValue, comp_score <- scoreValue, comp_comment <- commentValue, comp_rifleid <- rifleidValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getCompetition(idValue: Int64) -> CompetitionModel {
        //create an empty object
        let competitionModel: CompetitionModel = CompetitionModel()
        
        //exception handling
        do {
            
            //get competition using id
            let competition: AnySequence<Row> = try db.prepare(competitions.filter(comp_id == idValue))
            
            //get row
            try competition.forEach({ rowValue in
                //set values in model
                competitionModel.id = try rowValue.get(comp_id)
                competitionModel.competitionCase = try rowValue.get(competitionCase)
                competitionModel.place = try rowValue.get(comp_place)
                competitionModel.date = try rowValue.get(comp_date)
                competitionModel.shots = try rowValue.get(comp_shots)
                competitionModel.score = try rowValue.get(comp_score)
                competitionModel.comment = try rowValue.get(comp_comment)
                competitionModel.rifleid = try rowValue.get(comp_rifleid)
            })
        } catch {
            print(error.localizedDescription)
        }
        
        return competitionModel
    }
    
    
    public func getTrainingGraph(weaponid: Int64) -> ([Double], [Double], [String], [String]) {
        var wholeRings: [Double] = []
        var tenthRings: [Double] = []
        var wholeDates: [String] = []
        var tenthDates: [String] = []
        
        //get all trainings in ascending order
        trainings = trainings.order(id.asc)
        
        //exception handling
        do {
            
            //loop through all trainings
            for training in try db.prepare(trainings.filter(weaponid == rifleid)) {
                let rings = training[score]
                let helper:Date = training[date]
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .short
                let date = (formatter1.string(from: helper))
                
                //check if the result is an integer (= a score with whole rings)
                if floor(rings) == rings {
                    wholeRings.append(rings)
                    wholeDates.append(date)
                } else {
                    tenthRings.append(rings)
                    tenthDates.append(date)
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return (wholeRings, tenthRings, wholeDates, tenthDates)
    }
    
    public func getCompetitionGraph(weaponid: Int64) -> ([Double], [Double], [String], [String]) {
        var wholeRings: [Double] = []
        var tenthRings: [Double] = []
        var wholeDates: [String] = []
        var tenthDates: [String] = []
        
        //get all competitions in ascending order
        competitions = competitions.order(id.asc)
        
        //exception handling
        do {
            
            //loop through all competitions
            for competition in try db.prepare(competitions.filter(weaponid == comp_rifleid)) {
                let rings = competition[comp_score]
                let helper:Date = competition[comp_date]
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .short
                let date = (formatter1.string(from: helper))
                
                //check if the result is an integer (= a score with whole rings)
                if floor(rings) == rings {
                    wholeRings.append(rings)
                    wholeDates.append(date)
                } else {
                    tenthRings.append(rings)
                    tenthDates.append(date)
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return (wholeRings, tenthRings, wholeDates, tenthDates)
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
