//
//  NetworkChoice.swift
//  FlightSearch
//
//  Created by Владимир Колосов on 18.02.2021.
//

import Foundation

// Выбор напрвления запросов моки или реальные

//let networkServices: NetworkProtocol = NetworkMock.shared

let networkServices: NetworkProtocol = NetworkService.shared
