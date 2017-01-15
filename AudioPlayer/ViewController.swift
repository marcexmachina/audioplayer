//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Marc O'Neill on 15/01/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let path = Bundle.main.path(forResource: "parabola", ofType: "mp3")
    var player = AVAudioPlayer()
    var timer = Timer()
    
    //0 for pause, 1 for play
    var state = 0
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var scrubber: UISlider!
    
    @IBAction func sliderMoved(_ sender: Any) {
        player.setVolume(slider.value, fadeDuration: 0)
    }
    
    @IBAction func scrubberMoved(_ sender: Any) {
       player.currentTime = TimeInterval(scrubber.value)
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        
        if state == 0 {
            playPauseButton.setTitle("Pause", for: .normal)
            player.prepareToPlay()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
            player.play()
            state = 1
        } else if state == 1 {
            playPauseButton.setTitle("Play", for: .normal)
            player.pause()
            state = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try player =  AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            player.numberOfLoops = 1
            
            scrubber.minimumValue = 0
            scrubber.maximumValue = Float(player.duration)
            
        } catch {
            print(error)
        }
    }
    
    func updateScrubber() {
        scrubber.setValue(Float(player.currentTime), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

