//
//  ViewController.swift
//  TestTask
//
//  Created by Владимир Колосов on 13.05.2021.
//

import UIKit
import RxSwift
import ProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var fromButton:  UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    let viewModel = StartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Выравнивание цвета навигейшин бара
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        LocationManager.shared.locationShared()
        
        // чистка базы
        RealmService.shared.removeAll()
        
        // Получения города в поле Куда
        viewModel.cityTo.map( {  val -> String in
            val.nameTerm
        }).bind(to: toButton.rx.title()).disposed(by: disposeBag)
        
        // Получение города в поле Откуда
        viewModel.cityFrom.map( {  val -> String in
            val.nameTerm
        }).bind(to: fromButton.rx.title()).disposed(by: disposeBag)
        // блокировка/ разблокировка кнопок пока парсится джейсон
        viewModel.enabledDirectionButton.bind(to: fromButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.enabledDirectionButton.bind(to: toButton.rx.isEnabled).disposed(by: disposeBag)
    
        viewModel.enableButton.subscribe(onNext:{ [weak self] val in
            self?.saveButton.rx.isEnabled.onNext(val)
            if (val) {
                self?.saveButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            } else {
                self?.saveButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
        }).disposed(by: disposeBag)
        
    }

    @IBAction func fromButton(_ sender: Any) {
        let terminalViewModel = TerminalViewModel(withCitySubject: viewModel.cityFrom, withFrom: true)
            guard let vc = TerminalsViewController.instanceContoller() else { return }
            vc.viewModel = terminalViewModel
            vc.viewModel?.sortCell.onNext(false)
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toButton(_ sender: Any) {
        let terminalViewModel = TerminalViewModel(withCitySubject: viewModel.cityTo, withFrom: false)
            guard let vc = TerminalsViewController.instanceContoller() else { return }
            vc.viewModel = terminalViewModel
        vc.viewModel?.sortCell.onNext(true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
    }
    
}

