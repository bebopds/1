//
//  TerminalTableViewCell.swift
//  TestTask
//
//  Created by Владимир Колосов on 15.05.2021.
//

import UIKit
import SDWebImage
import RxSwift

class TerminalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var terminalLabel: UILabel!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var derivalLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupTerm(_ city: TerminalsData) {
        terminalLabel.text = city.nameTerm
        addressLabel.text = city.addressTerm     
        mapImage.sd_setImage(with: URL(string: city.map), completed: nil)
        if(mapImage.image?.getPixelColor(pos: CGPoint(x: 50,y: 50)) == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
            mapImage.image = UIImage(named: "map")
        }
        derivalLabel.text = city.department
        arrivalLabel.text = city.timetable
        mondayLabel.text = city.monday
        tuesdayLabel.text = city.tuesday
        wednesdayLabel.text = city.wednesday
        thursdayLabel.text = city.thursday
        fridayLabel.text = city.friday
        saturdayLabel.text = city.saturday
        sundayLabel.text = city.sunday
        distanceLabel.text = "\(city.distance) м."
    }
}
