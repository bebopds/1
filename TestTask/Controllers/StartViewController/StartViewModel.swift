//
//  StartViewModel.swift
//  TestTask
//
//  Created by Владимир Колосов on 13.05.2021.
//
import RxSwift
import Foundation
import RealmSwift
import CoreLocation
import ProgressHUD

class StartViewModel {
    
    let disposeBag = DisposeBag()
    // для получения терминала в откуда
    let cityFrom = PublishSubject<TerminalsData>()
    // для получения терминала в куда
    let cityTo = PublishSubject<TerminalsData>()
    // блокировка разблокировка кнопки сохранить
    let enableButton = BehaviorSubject<Bool>(value: false)
    // для блокировки/ активности кнопок откуда и куда
    let enabledDirectionButton = BehaviorSubject<Bool>(value: false)
    
    let manager = CLLocationManager()
    
    init() {
        // запрос и запись в базу
        NetworkServices.shared.getTerminal().subscribe(onNext: { val in
            self.setInBase(forArray: val)
        }).disposed(by: disposeBag)
        
        // проверка заполенения полей откуда и куда для разблокировки кнопки "Сохранить"
        Observable.combineLatest(cityTo, cityFrom).map { (to, from) -> Bool in
            var enable: Bool = false
            if ((from.receiveCargoTerm && (to.giveoutCargoTerm || to.defaultTerm)) && from.nameTerm != to.nameTerm ){
                enable = true
            } else { enable = false }
            
            return enable
        }.bind(to: enableButton).disposed(by: self.disposeBag)
    }
    
    // Запись в базу
    func setInBase(forArray array: [TermResponse]) {
        // получаем координаты
        let coordinates = LocationManager.shared.coordinate()
        var newWorktime: Worktable = Worktable.init()
        var distance: String = ""
        var newUrl: String = ""
        for city in array {
            for allTerminalInCity in city.terminals.terminal{
                for item in allTerminalInCity.worktables.worktable {
                    // замена урла
                    newUrl = transferURL(text: allTerminalInCity.maps?.width?.six?.height?.sixx?.url ?? "")
                    // фильтрация и форматирование графика работы
                    if (item.department == "Приём и выдача груза" || item.department == "Приём груза"){
                        newWorktime.monday = transferString(text: item.monday ?? "")
                        newWorktime.timetable = replacementString(text: item.timetable ?? "")
                        newWorktime.tuesday = transferString(text:item.tuesday ?? "")
                        newWorktime.wednesday = transferString(text:item.wednesday ?? "")
                        newWorktime.thursday = transferString(text:item.thursday ?? "")
                        newWorktime.friday = transferString(text:item.friday ?? "")
                        newWorktime.saturday = transferString(text:item.saturday ?? "")
                        newWorktime.sunday = transferString(text:item.sunday ?? "")
                        newWorktime.department = item.department
                    }
                }
                
                // Проверка на доступ к геолокации и вывод дистанции или сообщения
                if CLLocationManager.locationServicesEnabled() {
                    
                    switch manager.authorizationStatus {
                    case .restricted, .denied:
                        distance = "Нет доступа к геолокации"
                    case .authorizedAlways, .authorizedWhenInUse:
                        distance = getDistance(coordinate: coordinates, latitude: Double(allTerminalInCity.latitude ?? "0.0") ?? 0.0,  longitude: Double(allTerminalInCity.longitude ?? "0.0") ?? 0.0 )
                    case .notDetermined: break
                    @unknown default: break
                    }
                }
                
                // запись в базу
                let term = TerminalsData()
                RealmService.shared.addTreminals(term, networkTerm: allTerminalInCity, newWorktime: newWorktime, distance: distance, newUrl: newUrl)
                
                newWorktime = Worktable.init()
            }
        }
        
        // разблокировка кнопок "Откуда/ Куда"
        enabledDirectionButton.onNext(true)
    }
    // форматирование текста в графике работ по дням
    func transferString(text: String) -> String {
        if (text.contains("ч")){
            return text + "\n"
        }
        if (text.count > 1) {
            let toString = text.components(separatedBy: "-")
            let backToString = toString.joined(separator: "\n")
            return backToString
        }
        else { return text + "\n"}
    }
    // форматирование текста в графике работ неделя в целом
    func replacementString(text: String) -> String {
        let toString = text.components(separatedBy: "; ")
        let backToString = toString.joined(separator: "\n")
        return backToString
    }
    
    // получение дистанции по координатам
    func getDistance(coordinate: CLLocationCoordinate2D, latitude: Double, longitude: Double) -> String{
        let startLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let endLocation = CLLocation(latitude: latitude , longitude: longitude)
        let distance: CLLocationDistance = startLocation.distance(from: endLocation)
        return "\(Int(distance/1000))"
    }
    
    // изменение ула картинок
    func transferURL(text: String) -> String {
        if (text.count > 1) {
            let toString = text.components(separatedBy: "http:")
            let backToString = toString.joined(separator: "https:")
            return backToString
        }
        else { return text}
    }
}
