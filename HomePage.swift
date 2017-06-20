//
//  HomePage.swift
//  CubeKellton
//
//  Created by piyush.singh on 14/06/17.
//  Copyright © 2017 piyush.singh. All rights reserved.
//

import UIKit

class HomePage: UIViewController {
    var time1 = Int()
    var steps = String()
    var colorArr:NSMutableArray = []
        let sc = SecondScreen()
    var check = Bool()
    var count = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        
               // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(_ sender: Any) {
        let sv = SecondScreen()
        sv.audioPass = true
        self.navigationController?.pushViewController(sv, animated: true)
    }

    @IBAction func settings(_ sender: Any) {
        let bc = Settings()
        self.navigationController?.pushViewController(bc, animated: true)
    }
    @IBAction func about(_ sender: Any) {
        let tc = About()
        self.navigationController?.pushViewController(tc, animated: true)
    }
    @IBAction func resume(_ sender: Any) {
        steps = UserDefaults.standard.object(forKey: "scoreView") as! String
        print(steps)
       time1 = UserDefaults.standard.integer(forKey: "time")
        print(time1)
        sc.timeFormat(time: TimeInterval(time1))
        sc.seconds = time1
        let colorsData  = UserDefaults.standard.object(forKey: "Color") as! NSData
        colorArr = NSKeyedUnarchiver.unarchiveObject(with: colorsData as Data) as! NSMutableArray
        sc.newArr = colorArr
        sc.score = Int(steps)!
        sc.check1 = true
        self.navigationController?.pushViewController(sc, animated: true)
        
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
