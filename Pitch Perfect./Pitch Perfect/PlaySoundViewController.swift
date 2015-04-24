//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Sharifah Nazreen Ashraff ali on 3/23/15.
//  Copyright (c) 2015 Syed Ariff. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioplayer : AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioplayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl , error: nil )
        audioplayer.enableRate=true
        audioplayer.prepareToPlay()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl,error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySnail(sender: UIButton) {
        audioplayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioplayer.rate = 0.5
        audioplayer.play()
    }

    @IBAction func PlayChipmunk(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioplayer.rate=2.0
        audioplayer.play()
    }
    @IBAction func StopPlaying(sender: UIButton) {
        audioplayer.stop()
    }
    
    @IBAction func playDarthVaderaudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func playChipmunkaudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
    }
    func playAudioWithVariablePitch(pitch : Float){
        audioplayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        var audioplayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioplayerNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioplayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioplayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioplayerNode.play()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
