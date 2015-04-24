//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Sharifah Nazreen Ashraff ali on 3/20/15.
//  Copyright (c) 2015 Syed Ariff. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate {
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordinginProgress: UILabel!
    @IBOutlet weak var TaptoRecord: UILabel!
    var audioRecorder:AVAudioRecorder!
    var recordedaudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden=true
        recordButton.enabled=true
        
    
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        recordinginProgress.hidden=false
        TaptoRecord.hidden=true
        stopButton.hidden=false
        recordButton.enabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        

    }
    
    func audioRecorderDidFinishRecording(recorder : AVAudioRecorder!, successfully flag : Bool){
        if(flag){
            recordedaudio = RecordedAudio(filePathUrl:recorder.url,title:recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedaudio)
        }
        else{
            println("Recording didn't recorded succesfully")
            recordButton.enabled = false
            stopButton.hidden = true
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
            let playSoundsVC:PlaySoundViewController =  segue.destinationViewController as PlaySoundViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    @IBAction func stopAudio(sender: UIButton) {
        recordinginProgress.hidden=true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance();
        audioSession.setActive(false,error:nil)
    }
    
}

