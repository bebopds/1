//
//  NetworkProtocol.swift
//  TestTask
//
//  Created by Владимир Колосов on 14.05.2021.
//

import Foundation
import RxSwift

protocol NetwortProtocol {
    
    
func getTerminal() -> Observable<[TermResponse]>
    
}
