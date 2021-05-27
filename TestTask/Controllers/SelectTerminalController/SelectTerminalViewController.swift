//
//  SelectTerminalViewController.swift
//  TestTask
//
//  Created by Владимир Колосов on 15.05.2021.
//

import UIKit

class SelectTerminalViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var items: [TermResponse] = []
    var allItems: [TerminalsData] = []
    var test = TerminalsData()
    
    class func instanceContoller() -> SelectTerminalViewController? {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: "SelectTerminalViewController") as? SelectTerminalViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TerminalTableViewCell", bundle: nil), forCellReuseIdentifier: "TerminalTableViewCell")
        
        
       

            self.allItems.removeAll()
            self.allItems.append(contentsOf: RealmService.shared.getAllTerminal())
            self.tableView.reloadData()
        
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allItems.count
     
              
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TerminalTableViewCell") as! TerminalTableViewCell
        let cityModel = allItems[indexPath.row]
        cell.terminalLabel.text = cityModel.nameTerm
    
        return cell
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
