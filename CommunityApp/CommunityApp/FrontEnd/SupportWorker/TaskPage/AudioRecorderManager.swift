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
    var volumeComparator: Int!
    @IBOutlet var recorderView: UIView!
    @IBOutlet weak var volumeName: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var volumeAnimation: UIImageView!
    @IBOutlet weak var progressTimer: UILabel!
    @IBOutlet weak var recorderStart: UIButton!
    @IBOutlet weak var play: UIButton!
    var secCount: Double! = 0
    var clock: Int! = 15
    var width: CGFloat!
    var height: CGFloat!
    var lastOrientation: UIDeviceOrientation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastOrientation = UIDevice.current.orientation
        let lastInterfaceOrientation = UIApplication.shared.statusBarOrientation
        progressTimer.text = "15"
        if lastInterfaceOrientation.isPortrait {
            width = recorderView.frame.size.width
            height = recorderView.frame.size.height
            setLayout(deviceWidth: width, deviceHeight: height)
        }
        if lastInterfaceOrientation.isLandscape {
            height = recorderView.frame.size.width
            width = recorderView.frame.size.height
            setLayout(deviceWidth: height, deviceHeight: width)
        }
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(detectOrientationChange), name:NSNotification.Name.UIDeviceOrientationDidChange, object:nil)
        
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
        if task.ifFileExists(filePath: .audio) {
            let alert = UIAlertController(title: "", message: "If you record a new audio, the existing audio will be replaced!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        volumeComparator = 1000
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayout(deviceWidth: CGFloat, deviceHeight: CGFloat) {
        volumeName.frame = CGRect(x: deviceWidth / 2 - 0.081 * deviceHeight, y: 0.107 * deviceHeight, width: 0.081 * deviceHeight, height: 0.025 * deviceHeight)
        volumeName.font = UIFont.boldSystemFont(ofSize: 0.021 * deviceHeight)
        volume.frame = CGRect(x: deviceWidth / 2 + 0.081 * deviceHeight, y: 0.107 * deviceHeight, width: 0.081 * deviceHeight, height: 0.025 * deviceHeight)
        volume.font = UIFont.boldSystemFont(ofSize: 0.021 * deviceHeight)
        volumeAnimation.frame = CGRect(x: (deviceWidth - 0.315 * deviceHeight) / 2, y: 0.141 * deviceHeight, width: 0.315 * deviceHeight, height: 0.247 * deviceHeight)
//        progress.frame.origin = CGPoint(x: (deviceWidth - progress.frame.size.width * 0.001 * deviceHeight) / 2, y: 0.441 * deviceHeight)
//        progress.frame = CGRect(x: (deviceWidth - progress.frame.size.width * 0.001 * deviceHeight) / 2, y: 0.441 * deviceHeight, width: 0.146 * deviceHeight, height: 0.003 * deviceHeight)
        progressTimer.frame = CGRect(x: (deviceWidth - 0.0645 * deviceHeight) / 2, y: 0.462 * deviceHeight, width: 0.0645 * deviceHeight, height: 0.029 * deviceHeight)
        progressTimer.font = UIFont.boldSystemFont(ofSize: 0.025 * deviceHeight)
        recorderStart.frame = CGRect(x: (deviceWidth - 0.188 * deviceHeight) / 2, y: 0.528 * deviceHeight, width: 0.188 * deviceHeight, height: 0.188 * deviceHeight)
        play.frame = CGRect(x: (deviceWidth - 0.097 * deviceHeight) / 2, y: 0.802 * deviceHeight, width: 0.097 * deviceHeight, height: 0.091 * deviceHeight)
    }
    
    @objc func detectOrientationChange() {
        let currentOrientation: UIDeviceOrientation = UIDevice.current.orientation
        guard UIDeviceOrientationIsLandscape(currentOrientation) || UIDeviceOrientationIsPortrait(currentOrientation) else {
            return
        }
        guard currentOrientation != lastOrientation else {
            return
        }
        lastOrientation = currentOrientation
        if currentOrientation == .landscapeLeft || currentOrientation == .landscapeRight {
            print("landscape")
            setLayout(deviceWidth: height, deviceHeight: width)
        }
        if currentOrientation == .portrait {
            print("portrait")
            setLayout(deviceWidth: width, deviceHeight: height)
        }
    }
  
    @IBAction func recordButtonTouchDown(_ sender: UIButton) {
        secCount = 0
        clock = 15
        sender.setImage(#imageLiteral(resourceName: "record2Start2"), for: .normal)
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
    
    @IBAction func recordButtonTouchUp(_ sender: UIButton) {
        sender.setImage(#imageLiteral(resourceName: "record2"), for: .normal)
        recorder?.stop()
        recorder = nil
        volumeTimer.invalidate()
        volumeTimer = nil
        volume.text = "0"
        volumeAnimation.image = #imageLiteral(resourceName: "volumeBar8")
        volumeComparator = 1000
        progressTimer.text = "15"
    }
    
    @IBAction func recordButtonTouchUp2(_ sender: UIButton) {
        sender.setImage(#imageLiteral(resourceName: "record2"), for: .normal)
        recorder?.stop()
        recorder = nil
        volumeTimer.invalidate()
        volumeTimer = nil;
        volume.text = "0"
        volumeAnimation.image = #imageLiteral(resourceName: "volumeBar8")
        volumeComparator = 1000
        progressTimer.text = "15"
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
        secCount = secCount + 1
        if secCount == 10 {
            if clock > 0 {
                clock = (clock - 1)
            }
            secCount = 0
        }
        recorder!.updateMeters()
        let maxVolume:Float = recorder!.peakPower(forChannel: 0)
        let result = Int(100 * pow(Double(10), Double(0.05*maxVolume)))
        volume.text = "\(result)"
        if result >= volumeComparator + 5 || result <= volumeComparator - 5 {
            switch result {
            case 0...7:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar1")
            case 8...15:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar2")
            case 16...23:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar3")
            case 24...31:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar4")
            case 32...39:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar5")
            case 40...47:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar6")
            case 48...55:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar7")
            case 56...63:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar8")
            default:
                volumeAnimation.image = #imageLiteral(resourceName: "volumeBar8")
            }
            volumeComparator = result
        }
        progressTimer.text = "\(clock!)"
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


