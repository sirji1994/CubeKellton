//
//  Settings.swift
//  CubeKellton
//
//  Created by piyush.singh on 15/06/17.
//  Copyright © 2017 piyush.singh. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    @IBOutlet weak var `switch`: UISwitch!
    var check = Bool()
    
//let av = SecondScreen()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
                      // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
   
    @IBAction func backs(_ sender: Any) {
        UserDefaults.standard.set(check, forKey: "yes")
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func changeSound(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
            check = true
            //av.audioPass = check
            //
        }
        else{
            check = false
            // av.audioPass = check
            
        }
    }

    
   
}
