//
//  Terminals.swift
//  TestTask
//
//  Created by Владимир Колосов on 17.05.2021.
//

import Foundation
import RealmSwift

class TerminalsData: Object {
    @objc dynamic var nameTerm: String = ""
    @objc dynamic var addressTerm: String = ""
    @objc dynamic var latitudeTerm: Double = 0.0
    @objc dynamic var longitudeTerm: Double = 0.0
    @objc dynamic var receiveCargoTerm: Bool = false
    @objc dynamic var giveoutCargoTerm: Bool = false
    @objc dynamic var defaultTerm: Bool = false
    @objc dynamic var distance: Int = 0
    @objc dynamic var map: String = ""
    @objc dynamic var timetable: String = ""
    @objc dynamic var department: String = ""
    @objc dynamic var monday: String = ""
    @objc dynamic var tuesday: String = ""
    @objc dynamic var wednesday: String = ""
    @objc dynamic var thursday: String = ""
    @objc dynamic var friday: String = ""
    @objc dynamic var saturday: String = ""
    @objc dynamic var sunday: String = ""
}
