//
//  NetworkService+baseResponse.swift
//  TestTask
//
//  Created by Владимир Колосов on 15.05.2021.
//

import Foundation
import Alamofire
import RxSwift

extension NetworkServices {
    
    // Получение списка терминалов
    func getTermResp() -> Observable<Data> {
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
