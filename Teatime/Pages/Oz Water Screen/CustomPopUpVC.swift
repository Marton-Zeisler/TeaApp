//
//  CustomPopUpVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 05. 04..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit

class CustomPopUpVC: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    var selectedAmount = 0
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.setValue(Float(selectedAmount), animated: true)
        amountLabel.text = "\(selectedAmount) oz"
        
        

    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        amountLabel.text = "\(Int(sender.value)) oz"
        selectedAmount = Int(sender.value)
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("customChanged"), object: selectedAmount)
        dismiss(animated: true, completion: nil)
    }
    

}
