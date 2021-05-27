////
////  NetworkMock.swift
////  FlightSearch
////
////  Created by Владимир Колосов on 18.02.2021.
////
//
//import Foundation
//
//class NetworkMock: NetworkProtocol{
//
//
//
//    static let shared  = NetworkMock()
//
//
//    // Мок запроса получения айпи адреса
//func getIp() -> Observable<String> {
//        success("192.168.1.1")
//    }
//
//    // Мок запроса получения города по айпи
//    func getIPCity(withCityIp cityIp: String) -> Observable<CityIPResponse>
//        success(CityIPResponse.init(iata: "MOW", name: "Москва"))
//
//    }
//
//    // мок молучение списка городов с аэропортами
//    func getCity(_ success: @escaping ([CityResponse]) -> Void) {
//        let nameTrans = NameTranslations.init(en: "Jakarta")
//         let one = CityResponse.init(code: "JKT", name: "Джакарта", name_translations:nameTrans)
//         let two = CityResponse.init(code: "HRN", name: "Херон-Айленд", name_translations:nameTrans)
//        success([one, two])
//
//    }
//
//    // мок получение списка дат с ценами
//    func getPrice(_ dataRequest: RequestSearchModel, success: @escaping (PriceResponse) -> Void) {
//
//        let onePriceData = DataPrice.init(price: 123, departure_at: "2021-03-06T12:20:00Z", return_at: "2021-03-06T12:20:00Z")
//        let twoPriceData = DataPrice.init(price: 321, departure_at: "2021-03-07T12:20:00Z", return_at: "2021-03-08T12:20:00Z")
//
//        let onePrice = PriceResponse.init(data: ["0" : ["0" : onePriceData, "1": twoPriceData]])
//
//        success(onePrice)
//    }
//
//
//}
