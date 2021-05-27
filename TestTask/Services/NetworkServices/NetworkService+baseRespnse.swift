//
//  NetworkService+baseRespnse.swift
//  VovaFinal
//
//  Created by Владимир Колосов on 02.04.2021.
//

import Foundation
import Alamofire
import RxSwift

extension NetworkService {
    
    // Получение списка терминалов
    func getCitiesResp() -> Observable<Data> {
        let url = "https://api.dellin.ru/static/catalog/terminals_v3.json"
        return Observable.create { val -> Disposable in
            AF.request(url).responseData { response in
                if response.error != nil {
                    val.onError(RxError(message: "Список не получен"))
                } else {
                    guard let data = response.data else {
                        return
                    }
                    val.onNext(data)
                    val.onCompleted()
                }
            }
            return Disposables.create()
            
        }
    }
    
}
