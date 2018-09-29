//
//  OzWaterVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 05. 04..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit

class OzWaterVC: UIViewController {

    var selectedTea: Tea!
    
    @IBOutlet weak var customYellow: UIView!
    
    @IBOutlet weak var oz8Yellow: UIView!

    @IBOutlet weak var oz12Yellow: UIView!
    
    @IBOutlet weak var oz32Yellow: UIView!
    
    let yellwoColor = #colorLiteral(red: 0.9960784314, green: 0.7803921569, blue: 0.0431372549, alpha: 0.2)
    
    var selectedOz: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedOz = 0

        customYellow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customYellowTapped(_:))))
        
        oz8Yellow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(oz8YellowTapped(_:))))
        
        oz12Yellow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(oz12YellowTapped(_:))))
        
        oz32Yellow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(oz32YellowTapped(_:))))
        
        NotificationCenter.default.addObserver(self, selector: #selector(customChanged(_:)), name: Notification.Name("customChanged"), object: nil)
    }
    
    @objc func customChanged(_ sender: Notification){
        if let data = sender.object as? Int{
            selectedOz = data
        }
    }
    
    @objc func customYellowTapped(_ sender: UITapGestureRecognizer){
        if customYellow.backgroundColor == UIColor.clear{
            performSegue(withIdentifier: "custom", sender: nil)
        }

        alpaChange(view: customYellow, amountToChange: nil)
    }
    
    @objc func oz8YellowTapped(_ sender: UITapGestureRecognizer){
        alpaChange(view: oz8Yellow, amountToChange: 8)
    }
    
    @objc func oz12YellowTapped(_ sender: UITapGestureRecognizer){
        alpaChange(view: oz12Yellow, amountToChange: 12)

    }
    
    @objc func oz32YellowTapped(_ sender: UITapGestureRecognizer){
        alpaChange(view: oz32Yellow,amountToChange: 32)
    }

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alpaChange(view: UIView, amountToChange: Int?){
        if view.backgroundColor == UIColor.clear{
            view.backgroundColor = yellwoColor
            if let amount = amountToChange{
                selectedOz = amount
            }
        }else{
            view.backgroundColor = UIColor.clear
            selectedOz = 0
        }
        
        if customYellow != view{
            customYellow.backgroundColor = UIColor.clear
        }
        
        if oz8Yellow != view{
            oz8Yellow.backgroundColor = UIColor.clear
        }
        
        if oz12Yellow != view{
            oz12Yellow.backgroundColor = UIColor.clear
        }
        
        if oz32Yellow != view{
            oz32Yellow.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        if selectedOz == 0{
            let alertController = UIAlertController(title: "No amount selected", message: "Please select an amount to continue!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "next", sender: nil)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let vc = segue.destination as!  RecommendedVC
            selectedTea.teaWater = selectedOz
            vc.selectedTea = selectedTea
        }
        
        if segue.identifier == "custom"{
            let vc = segue.destination as! CustomPopUpVC
            vc.selectedAmount = selectedOz
        }
    }
    

}
