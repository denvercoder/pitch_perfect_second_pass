//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Timothy Myers on 6/27/17.
//  Copyright © 2017 DenverCoder. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: RecordSoundsViewController : UIViewController, AVAudioRecorderDelegate

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var recordingLabel: UILabel!;
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    //MARK: - Global Variables
    var audioRecorder: AVAudioRecorder!
    
    //MARK:  - Class Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(recording: false)
    }
    
    //MARK: - AUDIO FUNCTIONS
    @IBAction func stopRecording(_ sender: Any) {
        
        setupUI(recording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        
        setupUI(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    //MARK: - Audio Recorder Delegate -
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not successful, please try again.")
        }
    }
    
    //MARK: - Code Based Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudio = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudio
        }
    }
    
    //MARK: - Abstract UI Code
    func setupUI(recording: Bool){
        if recording{
            recordingLabel.text = "Recording in progress"
            recordButton.isEnabled = false
            stopRecordingButton.isEnabled = true
        } else {
            recordingLabel.text = "Tap to Record"
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
        }
    }
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}





