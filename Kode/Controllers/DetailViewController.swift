//
//  DetailViewController.swift
//  Kode
//
//  Created by Илья Сутормин on 09.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var user: Item!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var departLabel: UILabel!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormater = DateFormatter()
        
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dute = dateFormater.date(from: user.birthday)!
        
        dateFormater.dateFormat = "d MMMM yyyy"
        let newString = dateFormater.string(from: dute)
        
        
        nameLabel.text = String("\(user.firstName) \(user.lastName)")
        departLabel.text = user.position
        tabLabel.text = user.userTag.lowercased()
        birthdayLabel.text = newString
        phoneLabel.text = String("+7 \(user.phone)")
        ageLabel.text = String("\(yearsBetweenDate(startDate: dute, endDate: Date())) лет")
    }
    
    func yearsBetweenDate(startDate: Date, endDate: Date) -> Int {
    
        let dateFormater = DateFormatter()
        let calendar = Calendar.current

        let components = calendar.dateComponents([.year], from: startDate, to: endDate)

        return components.year!
    }
    
    @IBAction func tap(_ sender: Any) {
        let url = URL(string: "tel://+7\(user.phone)")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    
}

