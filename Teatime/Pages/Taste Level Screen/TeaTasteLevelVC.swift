//
//  TasteLevelVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 04. 22..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit

class TeaTasteLevelVC: UIViewController {
    
    var selectedTea: Tea!
    var selectedPercent = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        selectedPercent = Int(round(sender.value))
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        selectedTea.teaTaste = selectedPercent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let vc = segue.destination as! OzWaterVC
            selectedTea.teaTaste = selectedPercent
            vc.selectedTea = selectedTea
        }
    }
    

}
