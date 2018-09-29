//
//  TimerVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 05. 05..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit
class TimerVC: UIViewController {

    @IBOutlet weak var refreshImage: UIImageView!
    
    @IBOutlet weak var didYouLabel: UILabel!
    
    @IBOutlet weak var minuteLabel: UILabel!
    
    @IBOutlet weak var tensLabel: UILabel!
    
    @IBOutlet weak var onesLabel: UILabel!
    
    let didYouKnows = ["There is an estimated 1,500 different types of tea.", "Tea originated in Southwest China, where it was used as a medicinal drink.", "Tea plants are native to East Asia, and probably originated in the borderlands of north Burma and southwestern China.", "Tea also contains small amounts of theobromine and theophylline.", "Black and green teas contain no essential nutrients in significant content"]
    var didYouKnowCounter = 0
    
    var timer: Timer!
    var timerLabel: Timer!
    
    var selectedTea: Tea!
    
    var countDownTotalSeconds = 80
    
    var countDownMinutes = 0
    var countDownSecondsTens = 0
    var countDownSecondOnes = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
                    
        timerLabel = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(animateDidYouKnows), userInfo: nil, repeats: true)
        
        countDownTotalSeconds = selectedTea.teaTime!
        calculateTimer()
    }
    
    func calculateTimer(){
        countDownMinutes = countDownTotalSeconds / 60
        countDownSecondsTens = (countDownTotalSeconds - (countDownMinutes * 60)) / 10
        countDownSecondOnes = (countDownTotalSeconds - (countDownMinutes * 60)) - (countDownSecondsTens * 10)
        
        print("Minutes: \(countDownMinutes)")
        print("Tens: \(countDownSecondsTens)")
        print("Ones: \(countDownSecondOnes)")
        
        minuteLabel.text = "\(countDownMinutes)"
        tensLabel.text = "\(countDownSecondsTens)"
        onesLabel.text = "\(countDownSecondOnes)"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        refreshImage.rotate360Degrees()
        
    }
    
    @objc func animateDidYouKnows(){
        self.didYouLabel.text = ""
        self.didYouLabel.alpha = 0.0
        UIView.animate(withDuration: 1.5) {
            self.didYouLabel.alpha = 1.0
            self.didYouKnowCounter += 1
            if self.didYouKnowCounter == self.didYouKnows.count{self.didYouKnowCounter = 0}
            
            self.didYouLabel.text = self.didYouKnows[self.didYouKnowCounter]
        }
    }
    
    @objc func rotateRefresh(){
        self.refreshImage.transform = self.refreshImage.transform.rotated(by: CGFloat(Double.pi/2))
        UIView.animate(withDuration: 0.35) {
            self.updateViewConstraints()
        }
        
    }
    
    @objc func updateCounter() {
        
        if countDownSecondOnes == 0 && countDownSecondsTens == 0 && countDownMinutes == 0{
            performSegue(withIdentifier: "next", sender: nil)
            timer.invalidate()
            timerLabel.invalidate()
            return
        }
        
        if countDownSecondOnes == 0 && countDownSecondsTens == 0 && (countDownMinutes != 0){
            countDownMinutes -= 1
            countDownSecondsTens = 5
            countDownSecondOnes = 9
            tensLabel.text = "\(countDownSecondsTens)"
            onesLabel.text = "\(countDownSecondOnes)"
            minuteLabel.text = "\(countDownMinutes)"
            return
        }
        
        if countDownSecondOnes == 0{
            if countDownSecondsTens != 0{
                countDownSecondsTens -= 1
                if countDownSecondsTens == 0{
                    countDownSecondOnes = 9
                    tensLabel.text = "\(countDownSecondsTens)"
                    onesLabel.text = "\(countDownSecondOnes)"
                    return
                }else{
                    countDownSecondOnes = 9
                    onesLabel.text = "\(countDownSecondOnes)"
                    tensLabel.text = "\(countDownSecondsTens)"
                    return
                }
            }else{
                if countDownMinutes != 0{
                    countDownMinutes -= 1
                    countDownSecondsTens = 9
                    minuteLabel.text = "\(countDownMinutes)"
                    return
                }
            }
        }else{
            countDownSecondOnes -= 1
            onesLabel.text = "\(countDownSecondOnes)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let vc = segue.destination as! TeaReadyVC
            vc.selectedTea = selectedTea
        }
    }

}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}




