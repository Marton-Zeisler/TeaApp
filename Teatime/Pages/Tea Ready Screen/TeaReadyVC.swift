//
//  TeaReadyVC.swift
//  Teatime
//
//  Created by Marton Zeisler on 2018. 04. 30..
//  Copyright © 2018. marton. All rights reserved.
//

import UIKit
import AVFoundation

class TeaReadyVC: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var selectedTea: Tea!
    
    var player: AVAudioPlayer?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        
        blink()
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            guard let player = player else { return }
            
            player.play()
            player.numberOfLoops = -1
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    func blink(){
        backgroundImage.alpha = 0.0
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.backgroundImage.alpha = 1.0
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            player?.stop()
        }
    }

}


