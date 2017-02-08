//
//  ViewController.swift
//  LocalJsonTest
//
//  Created by Shinkangsan on 2/6/17.
//  Copyright © 2017 Sheldon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jsonLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var plistLabel: UILabel!
    
    
    @IBOutlet weak var writeTextField: UITextField!
    @IBOutlet weak var finalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func readJsonTapped(_ sender: Any) {
        
        let path = Bundle.main.path(forResource: "package", ofType: "json")
        print(path!)
        
        let url = URL(fileURLWithPath: path!)
        print(url)
        
        
        let data = try! Data(contentsOf: url)
        let obj = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        print(obj)
        
        if let str = (obj as! NSDictionary).value(forKey: "message") {
            self.jsonLabel.text = str as? String ?? ""
        }
    }
    
    @IBAction func readTxtTapped(_ sender: Any) {
        
        let path = Bundle.main.path(forResource: "package", ofType: "txt")
        print(path!)
        
        let url = URL(fileURLWithPath: path!)
        print(url)
        
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        print(contentString)
        
        let msgString = contentString.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        
        self.textLabel.text = msgString
        
    }
    
    @IBAction func readPlistTapped(_ sender: Any) {
        
        let path = Bundle.main.path(forResource: "package", ofType: "plist")
        print(path!)
        
        let url = URL(fileURLWithPath: path!)
        print(url)
        
        let obj = NSDictionary(contentsOf: url)
        
        if let str = obj!.value(forKey: "message") {
            self.plistLabel.text = str as? String ?? ""
        }

    }
    
    @IBAction func writeNReadTapped(_ sender: Any) {
        
        //write
        let path = Bundle.main.path(forResource: "package", ofType: "plist")
        print(path!)
        
        let url = URL(fileURLWithPath: path!)
        print(url.absoluteString)

        let str = writeTextField.text
        let dict = NSMutableDictionary()
        dict.setValue(str, forKey: "message")
        
        dict.write(to: url, atomically: true)
        
        //read
        let obj = NSDictionary(contentsOf: url)
        
        if let str = obj!.value(forKey: "message") {
            self.finalLabel.text = str as? String ?? ""
        }

        
    }
    
    
    
    
}

