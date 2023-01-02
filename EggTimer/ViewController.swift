//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var label: UILabel!
    let eggTime : [String : Int] = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    @IBAction func button(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        progressBar.progress = 0.0
        secondsPassed = 0
        label.text = hardness
        totalTime = eggTime[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1
        } else {
            timer.invalidate()
            label.text = "Done"
            progressBar.progress = 1
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
