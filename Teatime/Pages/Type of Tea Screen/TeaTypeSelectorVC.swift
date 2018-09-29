//
//  TeaTypeSelectorVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 04. 21..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit

class TeaTypeSelectorVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var selectedIndex = 1
    
    var teas = [Tea]()

    override func viewDidLoad() {
        super.viewDidLoad()
        teas.append(Tea(teaType: "HERBAL TEA", teaTaste: nil, teaWater: nil, teaTemp: nil, teaTime: nil))
        teas.append(Tea(teaType: "GREEN TEA", teaTaste: nil, teaWater: nil, teaTemp: nil, teaTime: nil))
        teas.append(Tea(teaType: "BLACK TEA", teaTaste: nil, teaWater: nil, teaTemp: nil, teaTime: nil))
        teas.append(Tea(teaType: "WHITE TEA", teaTaste: nil, teaWater: nil, teaTemp: nil, teaTime: nil))
    
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout.invalidateLayout() // or reloadData()
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        }
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TeaTypeCell
        
        cell.teaLabel.text = teas[indexPath.row].teaType
        cell.teaImage.image = UIImage(named: "\(teas[indexPath.row].teaType)")
        
        if indexPath.row != selectedIndex{
            cell.teaImage.alpha = 0.42
            cell.rightArrowButton.isHidden = true
            cell.leftArrowButton.isHidden = true
        }else{
            cell.teaImage.alpha = 1.0
            cell.rightArrowButton.isHidden = false
            cell.leftArrowButton.isHidden = false
            cell.rightArrowButton.addTarget(self, action: #selector(rightArrowTapped(_:)), for: .touchUpInside)
            cell.leftArrowButton.addTarget(self, action: #selector(leftArrowTapped(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc func rightArrowTapped(_ sender: UIButton){
        scrollItem(isNext: true)
    }
    
    @objc func leftArrowTapped(_ sender: UIButton){
        scrollItem(isNext: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/3)+80, height: collectionView.frame.height)
    }
    
    
    @IBAction func nextTapped(_ sender: UIButton) {
        scrollItem(isNext: true)
    }
    
    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        // previous
        scrollItem(isNext: false)
    }
    
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        // next
        scrollItem(isNext: true)
    }
    
    func scrollItem(isNext: Bool){
        if isNext == true{
            if selectedIndex == teas.count-1{
                selectedIndex = 0
            }else{
                selectedIndex += 1
            }
        }else{
            if selectedIndex != 0{
                selectedIndex -= 1
            }else{
                selectedIndex = teas.count-1
            }
        }
        
        pageControl.currentPage = selectedIndex
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let vc = segue.destination  as! TeaTasteLevelVC
            vc.selectedTea = teas[selectedIndex]
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
