//
//  ICloudAPI.swift
//  CommunityApp
//
//  Created by Admin on 4/23/19.
//  Copyright © 2019 Javon Luke. All rights reserved.
//


import UIKit
import Foundation
//IMPORTANT:
//You need to have `NSUbiquitousContainerIsDocumentScopePublic=true` in Info.plist before you run the app for the first time

class ICloudAPI {
    
    
    
    let dirName = "Documents"
     // I had to add a new icloud entitlement, because I named the bundle identefier incorrectly.
    let bundleId = "iCloud.com.StepByStep5.try"
    private var ICloudURL: URL!
    init?() {
        if !isICloudContainerAvailable() {
            return nil
        }
        createDirectory()
    }

    
    
    //Create iCloud Drive directory
    // I had to add a new icloud entitlement, because I named the bundle identefier incorrectly.
    func createDirectory(){

        guard let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: bundleId)?.appendingPathComponent(dirName) else {
            print("CreateDirectory: no directory")
            return
        }
      
        ICloudURL = iCloudDocumentsURL
                if (!FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: nil)) {
                    do {
                        try FileManager.default.createDirectory(at: iCloudDocumentsURL, withIntermediateDirectories: true, attributes: nil)
                       
                    }
                    catch {
                        //Error handling
                        print("Error in creating doc")
                    }
                } else {
                    print("Directory already created")
                    
            }

    }
    
    
    
    func writeFile(urlLocation: URL, text: String)  {

        do {
            try text.write(to: urlLocation, atomically: false, encoding: .utf8)
            
        }
        catch {
            /* error handling here */
            print("Error in writing")
        }


    }
    
    func removeFiles() {
        
        
             try! FileManager.default.removeItem(at: ICloudURL)
           
            
      
        createDirectory()
    }
    
    //To check user logged in to iCloud
    func isICloudContainerAvailable() -> Bool {
        return FileManager.default.ubiquityIdentityToken != nil
    }
    
    func fileExists(path: String) -> Bool {
        
      let url = createURL(path)
        
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    func createURL(_ file: String) -> URL {
       
     return ICloudURL.appendingPathComponent(file)
        
    }
    
    
}
    
    
 /*   func readFile(urlLocation: URL) -> NSString? {
        //Reading
        let getText: NSString?
        do {
            getText = try NSString.init(contentsOf: urlLocation, encoding: String.Encoding.utf8.rawValue)
            print(getText)
        }
        catch {
            /* error handling here */
            print("Error in reading")
        }
        return getText
    }
    
 /*   func copyFromLocToICloud(overwrite: Bool = false) {
        if isICloudContainerAvailable() {
            guard let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last else { return }
            
            let fileURL = localDocumentsURL.appendingPathComponent(file)
            
            guard let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents").appendingPathComponent(file) else { return }
            
            var isDir:ObjCBool = false
            
            if FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: &isDir) {
                do {
                    try FileManager.default.removeItem(at: iCloudDocumentsURL)
                }
                catch {
                    //Error handling
                    print("Error in remove item")
                }
            }
            
            do {
                try FileManager.default.copyItem(at: fileURL, to: iCloudDocumentsURL)
            }
            catch {
                //Error handling
                print("Error in copy item")
            }
        }
        else {
            self.present(UIAlertController.init(title: "Oops!", message: "Not logged into iCloud", preferredStyle: .alert), animated: true, completion: nil)
        }
    }
    
    
    */
        
        if isICloudContainerAvailable() {
            do {
                try FileManager.default.copyItem(at: from, to: to)
            }
            catch {
                //Error handling
                print("Error in copy item")
            }
        }
        
        
    }
    
    
    func saveFileLoc(_ fileName: String, ofType: String = "csv") {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directory.appendingPathComponent(file)
        
        
        
    }
    func saveFileCloud(_ fileName: String, ofType: String = "csv"){
        guard let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents").appendingPathComponent(file) else { return }
        
        
        
    }
    func createDirectory(dirName: String = "Documents") {
        
    }
    
    //Copy files from local directory to iCloud Directory
    func copyDocumentsToiCloudDirectory() {
        if isICloudContainerAvailable() {
            guard let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last else { return }
            
            let fileURL = localDocumentsURL.appendingPathComponent(file)
            
            guard let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents").appendingPathComponent(file) else { return }
            
            var isDir:ObjCBool = false
            
            if FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: &isDir) {
                do {
                    try FileManager.default.removeItem(at: iCloudDocumentsURL)
                }
                catch {
                    //Error handling
                    print("Error in remove item")
                }
            }
            
            do {
                try FileManager.default.copyItem(at: fileURL, to: iCloudDocumentsURL)
            }
            catch {
                //Error handling
                print("Error in copy item")
            }
        }
        else {
            self.present(UIAlertController.init(title: "Oops!", message: "Not logged into iCloud", preferredStyle: .alert), animated: true, completion: nil)
        }
    }
    
    
    //To check user logged in to iCloud
    func isICloudContainerAvailable() -> Bool {
        return FileManager.default.ubiquityIdentityToken != nil
    }
    
    
    
    
    func createDirectory() {
        

    let file = "file1.csv" //Text file to save to iCloud
    let text = "sample text" //Text to write into the file

        
    
      
        
    //Create iCloud Drive directory
        func createDirectory(dirName: String = "Documents"){
        if isICloudContainerAvailable() {
            if let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent(dirName) {
                if (!FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: nil)) {
                    do {
                        try FileManager.default.createDirectory(at: iCloudDocumentsURL, withIntermediateDirectories: true, attributes: nil)
                    }
                    catch {
                        //Error handling
                        print("Error in creating doc")
                    }
                }
            }
        }
        else {
            self.present(UIAlertController.init(title: "Oops!", message: "Not logged into iCloud", preferredStyle: .alert), animated: true, completion: nil)
            
        }
    }
        
        
        
    

    
    //Save text file to local directory
    func saveToDirectory(){
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directory.appendingPathComponent(file)
        
        
        guard let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents").appendingPathComponent(file) else { return }
        
        
        
        print(directory)
        //Writing
        do {
            try text.write(to: iCloudDocumentsURL, atomically: false, encoding: .utf8)
        }
        catch {
            /* error handling here */
            print("Error in writing")
        }
        
        //Reading
        do {
            let getText = try String(contentsOf: fileURL, encoding: .utf8)
            print(getText)
        }
        catch {
            /* error handling here */
            print("Error in reading")
        }
    }
    
   
    
    // MARK: - Actions
    @IBAction func btnCreateDiredtory(_ sender: UIButton) {
        self.createDirectory()
    }
    
    @IBAction func btnCopyFiles(_ sender: UIButton) {
        self.copyDocumentsToiCloudDirectory()
    }
    
    
}

*/


