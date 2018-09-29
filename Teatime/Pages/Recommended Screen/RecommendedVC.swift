//
//  RecommendedVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 05. 04..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit
import RealmSwift

class RecommendedVC: UIViewController {

    var selectedTea: Tea!
    
    @IBOutlet weak var minuteLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    var realm: Realm!
    
    var toSave = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try realm = Realm()
        }catch{
            print("Error")
        }
        
        
        print("Type of tea: ", selectedTea.teaType)
        print("Taste level: \(selectedTea.teaTaste!)%")
        print("Water oz: ", selectedTea.teaWater!)
        
        determineMinute()
        determineTemp()
    }
    
    func determineMinute(){
        if let time = selectedTea.teaTime{
            minuteLabel.text = "\(time/60) min"
        }else{
            let minute = Int(arc4random_uniform(2)+1)
            selectedTea.teaTime = (minute*60)
            minuteLabel.text = "\(minute) min"
        }
    }
    
    func determineTemp(){
        if let temperature = selectedTea.teaTemp{
            tempLabel.text = "\(temperature) F"
        }else{
            let temp = Int(arc4random_uniform(300)+100)
            selectedTea.teaTemp = temp
            tempLabel.text = "\(temp) F"
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        if toSave == true{
            let teaObject = TeaObject()
            teaObject.teaType = selectedTea.teaType
            teaObject.teaTaste = selectedTea.teaTaste!
            teaObject.teaWater = selectedTea.teaWater!
            teaObject.teaTemp = selectedTea.teaTemp!
            teaObject.teaTime = selectedTea.teaTime!
            
            try! self.realm.write {
                self.realm.add(teaObject)
            }
        }

        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let vc = segue.destination as! TimerVC
            vc.selectedTea = selectedTea
        }
    }
    

  

}
