//
//  TerminalViewModel.swift
//  TestTask
//
//  Created by Владимир Колосов on 18.05.2021.
//

import Foundation
import RxSwift
import CoreLocation

class TerminalViewModel {
    
    let disposeBag = DisposeBag()
    // для получения данных из базы
    let setTerm = BehaviorSubject<[TerminalsData]>(value: [])
    
    // Текст из строки поиска
    let serachTerminal = PublishSubject<String>()
    
    let sortCell = BehaviorSubject<Bool>(value: false)
    
    // получаем выбранный терминалов в поле откуда или куда
    let getTerminal = BehaviorSubject<TerminalsData>(value: .init())
    
    let allTerminal = BehaviorSubject<[TerminalsData]>(value: [])
    
    // для передачи в поле откуда или куда
    private var direction: PublishSubject<TerminalsData>?
    
    // для передачи выбранного направелние в сегмент контроле
    let directionSelected = BehaviorSubject<EnumSegmentControllerl>(value: .From)
    
    var fromOrTo: Bool?
    
    init(withCitySubject subject: PublishSubject<TerminalsData>, withFrom from: Bool) {
        
        self.direction = subject
        
        Observable.combineLatest(serachTerminal, directionSelected, getTermData(), sortCell).map { (search, direction, data, sort) -> [TerminalsData] in
            var filteredTerminals: [TerminalsData] = []
            var sortedDistanceTerminals: [TerminalsData] = []
            var terminals: [TerminalsData] = data
            
            // Проверка на пустое поле поиска
            if (!search.isEmpty){
                terminals.removeAll()
                // фильтр по символам из поля поиска
                terminals.append(contentsOf: data.filter { item in
                    item.nameTerm.contains(search)
                })
            }
            if (!sort) {
                sortedDistanceTerminals = terminals.sorted(by: { $0.distance < $1.distance })
                terminals = sortedDistanceTerminals
            }
            
          if (sort) {
                sortedDistanceTerminals = terminals.sorted(by: { $0.nameTerm < $1.nameTerm })
                terminals = sortedDistanceTerminals
            }
            
            switch direction {
            // филтруем по receiveCargo и defoult
            case .From:
                filteredTerminals.removeAll()
                for i in terminals {
                    if (i.receiveCargoTerm == true || i.defaultTerm == true){
                        filteredTerminals.append(i)
                    }
                }
                return filteredTerminals
 
            case .To:
                filteredTerminals.removeAll()
                // филтруем по giveoutCargo
                for i in terminals {
                     if (i.giveoutCargoTerm == true){
                        filteredTerminals.append(i)
                    }
                }
                return filteredTerminals
            }
            
        }.subscribe {  val in
            self.setTerm.onNext(val)
        }.disposed(by: disposeBag)
        
        // получаем понимаение откуда или куда
        fromOrTo = from
        
    }
    
    // Передача города в
    func selectTerminal() {
        guard let terminal = try? getTerminal.value() else {
            return
        }
        direction?.onNext(terminal)
    }
    
    //  Вытаскиваем данные из базы в массив
    func getTermData() -> Observable<[TerminalsData]> {
        return Observable.create { val -> Disposable in
            val.onNext(RealmService.shared.getAllTerminal())
            val.onCompleted()
            return Disposables.create()
        }
    }
}
