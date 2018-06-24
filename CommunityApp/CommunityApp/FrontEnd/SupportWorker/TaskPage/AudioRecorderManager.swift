//
//  AudioRecorderManager.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/6/14.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecorderManager: UIViewController {
    var task: Task!
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    var recorderOptionsDic: [String : Any]?
    var volumeTimer: Timer!
    @IBOutlet weak var volume: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        do {
            try session.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        try! session.setActive(true)
        recorderOptionsDic =
            [
                AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                AVEncoderBitRateKey : 320000,
                AVSampleRateKey : 44100.0
            ]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func recordButtonTouchDown(_ sender: Any) {
        recorder = try! AVAudioRecorder(url: URL(string: task.getPath(.audio)!)!, settings: recorderOptionsDic!)
        if recorder != nil {
            recorder?.isMeteringEnabled = true
            recorder?.prepareToRecord()
            recorder?.record()
            volumeTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(AudioRecorderManager.timerSelector), userInfo: nil, repeats: true)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please check your micphone.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func recordButtonTouchUp(_ sender: Any) {
        recorder?.stop()
        recorder = nil
        volumeTimer.invalidate()
        volumeTimer = nil
        volume.text = "0"
    }
    
    @IBAction func playbutton(_ sender: Any) {
        let pathString: String = task.getPath(.audio)!
        print(pathString)
        if CoreDataManager.database.resourceExists(URLString: pathString) {
            player = try! AVAudioPlayer(contentsOf: URL(string: pathString)!)
            if player == nil {
                print("Play Failed!")
            }else{
                player?.play()
            }
        }
    }
    
    @objc func timerSelector(){
        recorder!.updateMeters()
        let maxVolume:Float = recorder!.peakPower(forChannel: 0)
        let result = Int(100 * pow(Double(10), Double(0.05*maxVolume)))
        volume.text = "\(result)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


