//
//  RealmServices.swift
//  TestTask
//
//  Created by Владимир Колосов on 17.05.2021.
//
import RealmSwift
import Foundation

class RealmService {
    
    static let shared = RealmService()
    
    private var realm: Realm?
    
    init() {
        // Inside your application(application:didFinishLaunchingWithOptions:)
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 18,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 19) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        realm = try! Realm()
    }
    
    func deleteTerminals(_ terminals: TerminalsData) {
        try? realm?.write {
            realm?.delete(terminals)
        }}
    
    func addTreminals(_ terminals: TerminalsData, networkTerm: Terminal, newWorktime: Worktable, distance: String, newUrl: String){
        try? realm?.write {
            terminals.nameTerm = networkTerm.name
            terminals.addressTerm = networkTerm.fullAddress ?? ""
            terminals.defaultTerm = networkTerm.default ?? false
            terminals.giveoutCargoTerm = networkTerm.giveoutCargo ?? false
            terminals.receiveCargoTerm = networkTerm.receiveCargo ?? false
            terminals.latitudeTerm = Double(networkTerm.latitude ?? "0.0") ?? 0.0
            terminals.longitudeTerm = Double(networkTerm.longitude ?? "0.0") ?? 0.0
            terminals.map = newUrl
            terminals.department = newWorktime.department ?? ""
            terminals.timetable = newWorktime.timetable ?? ""
            terminals.monday = newWorktime.monday ?? ""
            terminals.tuesday = newWorktime.tuesday ?? ""
            terminals.wednesday = newWorktime.wednesday ?? ""
            terminals.thursday = newWorktime.thursday ?? ""
            terminals.friday = newWorktime.friday ?? ""
            terminals.saturday = newWorktime.saturday ?? ""
            terminals.sunday = newWorktime.sunday ?? ""
            terminals.distance = Int(distance) ?? 0

            print(terminals.department)
            realm?.add(terminals)
        }
    }
    
    func removeAll() {
        try? realm?.write{
            realm?.deleteAll()
        }
    }
    
    func getAllTerminal() -> [TerminalsData] {
        return realm?.objects(TerminalsData.self).map({ term -> TerminalsData in
            
            return term
        }) ?? []
    }
}
