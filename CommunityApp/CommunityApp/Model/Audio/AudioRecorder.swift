//
//  AudioRecorder.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-22.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


/*
class AudioRecorder: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    //declare instance variable
    var audioRecorder:AVAudioRecorder!
    func record(){
        var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioSession.setActive(true, error: nil)
        
        var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        var str =  documents.stringByAppendingPathComponent("recordTest.caf")
        var url = NSURL.fileURLWithPath(str as String)
        
        var recordSettings = [AVFormatIDKey:kAudioFormatAppleIMA4,
                              AVSampleRateKey:44100.0,
                              AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
                              AVLinearPCMBitDepthKey:16,
                              AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue]
        
        println("url : \(url)")
        var error: NSError?
        
        audioRecorder = AVAudioRecorder(URL:url, settings: recordSettings, error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            audioRecorder.record()
        }
    }
    
    
   var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var recordingSession: AVAudioSession!
    
    
    func setupRecorder() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        
        let audioFilename = documentDirectory.appendingPathComponent("audioFile.m4a")
        
        let settings = [
            AVFormatIDKey : Int(kAudioFormatAppleLossless),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 32000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
            ] as [String: Any]
        
        var error: NSError?
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
        } catch {
            audioRecorder = nil
        }
        
        if let err = error {
            print("Recorder error: \(err.localizedDescription)")
        } else {
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        }
    }
    
    func preparePlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileURL())
            
            audioPlayer.delegate = self
            audioPlayer.volume = 1.0
        } catch {
            if let err = error as Error? {
                print("Player error: \(err.localizedDescription)")
                audioPlayer = nil
            }
        }
    }
    
    @IBAction func recordAudio(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" {
            audioRecorder.record()
            sender.setTitle("Stop", for: .normal)
            // disableMPCButtons()
        } else {
            audioRecorder.stop()
            sender.setTitle("Record", for: .normal)
        }
    }
    
    @IBAction func onePlay(_ sender: UIButton) {
        if sender.titleLabel?.text == "Play" {
            // recordButton.isEnabled = false
            sender.setTitle("Stop", for: .normal)
            preparePlayer()
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            sender.setTitle("Play", for: .normal)
        }
    }
    
    
    
    func getFileURL() -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as URL
        let fileName = "audioFile.m4a"
        let soundURL = documentDirectory.appendingPathComponent(fileName)
        return soundURL
    }

    
    
 
    
    
    
}
  */
