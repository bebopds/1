//
//  TerminalResp.swift
//  TestTask
//
//  Created by Владимир Колосов on 14.05.2021.
//

import Foundation

 struct Response: Codable {
    var city: [TermResponse]
}

struct TermResponse: Codable {
    var terminals: Terminals
}

struct Terminals: Codable {
    var terminal: [Terminal]
}

struct Terminal: Codable {
    var id: String?
    var name: String
    var address: String?
    var fullAddress: String?
    var latitude: String?
    var longitude: String?
    var receiveCargo: Bool?
    var giveoutCargo: Bool?
    var maps: Maps?
    var worktables: Worktables
    var `default`: Bool?
}

struct Worktables: Codable {
    var worktable: [Worktable]
}

struct Worktable : Codable {
    var department: String?
    var monday: String?
    var tuesday: String?
    var wednesday: String?
    var thursday: String?
    var friday: String?
    var saturday: String?
    var sunday: String?
    var timetable: String?
}

struct Maps: Codable{
    var width: Width?
}

struct Width: Codable {
    var six: Six?
    
    enum CodingKeys: String, CodingKey {
          case six = "640"
      }
}

struct Six: Codable {
    var height: Height?
}

struct Height: Codable{
    var sixx: Sixx?
    
    enum CodingKeys: String, CodingKey {
          case sixx = "640"
      }
}

struct Sixx: Codable {
    var url: String?
}
