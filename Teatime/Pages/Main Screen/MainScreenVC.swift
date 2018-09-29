//
//  MainScreenVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 05. 04..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit
import RealmSwift

class MainScreenVC: UIViewController {

    var realm: Realm!
    
    var teaObjects: Results<TeaObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try realm = Realm()
        }catch{
            print("Error")
        }
        
        teaObjects = realm.objects(TeaObject.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


    @IBAction func savedTapped(_ sender: Any) {
        if teaObjects.count > 0{
            performSegue(withIdentifier: "saved", sender: nil)
        }else{
            let alert = UIAlertController(title: "No saved teas yet", message: "Select BREW NEW TEA to create your first tea!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saved"{
            let destination = segue.destination as! SavedTeaVC
            destination.teaObjects = teaObjects
        }
        
    }
    
}
