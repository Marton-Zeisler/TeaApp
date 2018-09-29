//
//  SavedTeaVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 05. 09..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit
import RealmSwift

class SavedTeaVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var realm: Realm!
    
    var teaObjects: Results<TeaObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        do{
            try realm = Realm()
        }catch{
            print("Error")
        }
        
        //teaObjects = realm.objects(TeaObject.self)

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teaObjects != nil{
            return teaObjects.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SavedTeaCell
        cell.teaTypeLabel.text = (teaObjects[indexPath.row].teaType).uppercased()
        cell.tasteLabel.text = "Taste Level: \(teaObjects[indexPath.row].teaTaste)%"
        cell.WaterLabel.text = "\(teaObjects[indexPath.row].teaWater)oz Water"
        cell.teaImage.image = UIImage(named: (cell.teaTypeLabel.text!).uppercased())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            do{
                try realm.write {
                    realm.delete(teaObjects[indexPath.row])
                    if teaObjects.count == 0{
                        self.navigationController?.popViewController(animated: true)
                    }
                    tableView.reloadData()
                }
            }catch{
                print("Error")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "next", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let index = sender as! Int
            let selectedTeaObject = teaObjects[index]
            let tea = Tea(teaType: selectedTeaObject.teaType, teaTaste: selectedTeaObject.teaTaste, teaWater: selectedTeaObject.teaWater, teaTemp: selectedTeaObject.teaTemp, teaTime: selectedTeaObject.teaTime)
            let destination = segue.destination as! RecommendedVC
            destination.selectedTea = tea
            destination.toSave = false
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
