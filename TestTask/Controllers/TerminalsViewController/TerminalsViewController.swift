//
//  TerminalsViewController.swift
//  TestTask
//
//  Created by Владимир Колосов on 18.05.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ProgressHUD

class TerminalsViewController: UIViewController {
   
    
    class func instanceContoller() -> TerminalsViewController? {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: "TerminalsViewController") as? TerminalsViewController
    }
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var nameRadioButtom: UIButton!
    
    @IBOutlet weak var distanceRadioButtom: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: TerminalViewModel?
    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = SSRadioButtonsController(buttons: nameRadioButtom, distanceRadioButtom)
        
        if (viewModel?.fromOrTo == false) {
            viewModel?.directionSelected.onNext(.To)
            self.navigationItem.title = "Выбор города назначения"
            segmentControl.selectedSegmentIndex = 1
            
        } else {
            viewModel?.directionSelected.onNext(.From)
            segmentControl.selectedSegmentIndex = 0
            
        }
        
            //Регистрация ячейки
        tableView.register(UINib(nibName: "TerminalTableViewCell", bundle: nil), forCellReuseIdentifier: "TerminalTableViewCell")
        tableView.rowHeight = 45

        // передача значения из поля поиска
        searchBar.rx.text.map { val -> String in
            val ?? ""
        }.subscribe(onNext: { val in
            if let viewModel = self.viewModel {
                viewModel.serachTerminal.onNext(val)
            }
        }).disposed(by: disposeBag)
        
        // загружаем города и формируем по ячейкам
        viewModel?.setTerm.bind(to:tableView.rx.items(cellIdentifier: "TerminalTableViewCell", cellType: TerminalTableViewCell.self)) { (index, model, cell) in
 
            cell.setupTerm(model)
        }.disposed(by: disposeBag)
        
       tableView.rowHeight = 600
        
        // Выбор ячейки и передача в сабжект для заполнения "Откуда/куда"
        tableView.rx.modelSelected(TerminalsData.self).subscribe(onNext: {[weak self] val in
            if let viewModel = self?.viewModel {
            viewModel.getTerminal.onNext(val)
            }
            self?.viewModel?.selectTerminal()
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    @IBAction func nameButton(_ sender: Any) {
        viewModel?.sortCell.onNext(true)
    }
    
    @IBAction func distanceButton(_ sender: Any) {
        viewModel?.sortCell.onNext(false)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentControlModul(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            viewModel?.directionSelected.onNext(.From)
            break
        case 1:
            viewModel?.directionSelected.onNext(.To)
            break
        default:
            break
        }
    }
}
