//
//  DetailViewController.swift
//  DotaCodable
//
//  Created by Admin on 12/1/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var attributeLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var legsLbl: UILabel!
    @IBOutlet weak var fav: UISwitch!
    
    var hero:Hero?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let isOn = UserDefaults.standard.switchIsOn
        
        nameLbl.text = hero?.name
        attributeLbl.text = hero?.primaryAttribute
        attackLbl.text = hero?.attackType
        legsLbl.text = "\((hero?.legs)!)"
        
        //updateUI(isOn: isOn)
        let baseURL = "https://api.opendota.com" + (hero?.image)!
        let url = URL(string: baseURL)
        //need to fetch image
        image.getImage(from: url!)
    }
    
//    @IBAction func switchDidChange(_ sender: UISwitch) {

//    }
    @IBAction func switchToggled(_ sender: UISwitch) {
        //_ = UserDefaults.standard.bool(forKey: "favorite")
        updateUI(isOn: sender.isOn)
        UserDefaults.standard.switchIsOn = sender.isOn
    }
    
    private func updateUI(isOn:Bool) {
        if isOn == true {
            view.backgroundColor = .yellow
        } else {
            view.backgroundColor = .blue
        }
        fav.isOn = isOn
    }

}
