//
//  NetworkServices.swift
//  TestTask
//
//  Created by Владимир Колосов on 14.05.2021.
//
import Foundation
import RxSwift
import Alamofire

class NetworkServices: NetwortProtocol {
    
    static let shared  = NetworkServices()
    
    func getTerminal() -> Observable<[TermResponse]> {
        
        return getTermResp().flatMap { val -> Observable<[TermResponse]> in
            
            guard let response = try? JSONDecoder().decode(Response.self, from: val) else {
                return .error(RxError(message: "Проблемы со структурой"))
            }
            return .of(response.city)
        }
    }
    
   
    
    private let baseUrl = "https://api.dellin.ru/static/catalog/terminals_v3.json"
    
    func getTrans(_ success: @escaping([TermResponse]) -> Void) {
        let url = baseUrl
        AF.request(url, method: .get).responseData { data in
            if let data = data.data {
                let decoder = try? JSONDecoder().decode(Response.self, from: data)
                success(decoder?.city ?? [])
            }
        }
    }
}
