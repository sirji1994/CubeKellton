//
//  SecondScreen.swift
//  CubeKellton
//
//  Created by piyush.singh on 14/06/17.
//  Copyright © 2017 piyush.singh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class SecondScreen: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var scoreView: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var grid: UICollectionView!
    var timer = Timer()
    var audioPlayer:AVAudioPlayer!
    var isTimerActive = false
    var seconds = 0
    var score = 0
    var gridLayout:GridLayout!
    var cellCol:UIColor?
    var check1 = Bool()
    var step = String()
    var newTime = String()
    var array2:NSMutableArray = []
    var index:NSMutableArray=[]
   var array:NSMutableArray = [UIColor.red,UIColor.green,UIColor.blue,UIColor.yellow,UIColor.green,UIColor.red,UIColor.yellow,UIColor.blue,UIColor.green,UIColor.yellow,UIColor.blue,UIColor.red,UIColor.yellow,UIColor.green,UIColor.blue,UIColor.red]
    
    var newArr:NSMutableArray = []
    var audioPass = Bool()
    override func viewDidLoad() {
    super.viewDidLoad()
        gridLayout = GridLayout(columns: 4,rows :4)
        grid.collectionViewLayout = gridLayout
        grid.reloadData()
        if( check1 == false)
        {
       random()
        }
        let sv = HomePage()
        registernib()
            
        self.title = "Cube Kellton"
        
        if isTimerActive == false{
            runTimer()
           

        }
            
        
        scoreView.text = sv.steps
            
        scoreView.text = String(score)
            
            self.navigationItem.hidesBackButton = true
            let back = UIBarButtonItem(title:"Back", style: UIBarButtonItemStyle.plain, target: self, action:#selector(SecondScreen.backButton(sender:)) )
            self.navigationItem.leftBarButtonItem = back
            
            

        // Do any additional setup after loading the view.
    }
    func runTimer()  {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SecondScreen.updateCounter)), userInfo: nil, repeats: true)
        isTimerActive = true
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 16
    }
    @IBAction func reset(_ sender: Any) {
        score = 0
        scoreView.text=String(score)
        timer.invalidate()
        seconds = 0
        time.text = timeFormat(time: TimeInterval(seconds))
        isTimerActive = false
        runTimer()
        self.grid.reloadData()
        random()
        
        
    }
    func backButton(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Alert", message: "Do You want to pause the game", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"No", style: .default, handler: {(action: UIAlertAction)in
        alert.dismiss(animated: true, completion: nil)}))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{(action: UIAlertAction)in
        UserDefaults.standard.set(self.scoreView.text, forKey: "scoreView")
        UserDefaults.standard.set(self.seconds, forKey: "time")
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:self.newArr), forKey: "Color")
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        present(alert,animated: true,completion: nil)
        
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:Cell = grid.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        
       cell.contentView.backgroundColor = newArr[indexPath.row] as! UIColor
        
       
    
        return cell
    }
    func timeFormat(time:TimeInterval) -> String
    {
        let minutes = Int(time)/60
        let seconds = Int(time)%60
        return String(format:"%02i:%02i",minutes, seconds)
    }
    func updateCounter() {
        seconds += 1
        time.text = timeFormat(time: TimeInterval(seconds))
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        score = score+1
        scoreView.text=String(score)
      
        
                let cell = grid.cellForItem(at: indexPath) as! Cell
        if (cell.isSelected && (cell.contentView.backgroundColor)! == UIColor.red)
        {
            sound()
            cellCol = UIColor.blue
            
               }
        else if (cell.isSelected && (cell.contentView.backgroundColor)! == UIColor.blue)
        {
            sound()
            cellCol = UIColor.green
           
        }
        else if (cell.isSelected && (cell.contentView.backgroundColor)! == UIColor.green)
        {
           sound()
            cellCol = UIColor.yellow
            

                    }
       else if (cell.isSelected && (cell.contentView.backgroundColor)! == UIColor.yellow)
        {
            sound()
            cellCol = UIColor.red
           
        }
        
        cell.contentView.backgroundColor = cellCol
        newArr.replaceObject(at:indexPath.row, with:cellCol!)
        print(newArr)

         var countColor = 0
        
        for color1 in newArr{
            let selColor = color1 as! UIColor
            if(selColor == cellCol){
                countColor += 1

            }}
        if(countColor==newArr.count)
        {
            let path = Bundle.main.path(forResource: "congratulations-you-won", ofType:"mp3")!
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                
                
                if(audioPlayer.prepareToPlay())
                {
                    audioPlayer.play()
                }
            } catch {
                
            }

            let alert = UIAlertController(title: "Congrats", message: " You Won!" , preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title:"New Game", style:.cancel , handler: {(action: UIAlertAction)in
                self.navigationController?.popViewController(animated: true)}))
            
            self.present(alert, animated: true, completion: nil)
            
        }

        
            }
    
   

    func sound()
    {
        audioPass = UserDefaults.standard.bool(forKey:"yes")
        if(audioPass == true){
        let path = Bundle.main.path(forResource: "demo", ofType:"m4a")!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            
            if(audioPlayer.prepareToPlay())
            {
                audioPlayer.play()
            }
        } catch {
            
            }}
        else{
            if(audioPlayer != nil)
            {
                audioPlayer.stop()
                audioPlayer=nil
            }
        }

    }
    func random()
    {
        
        for i in 0...15{
            let n = Int(arc4random_uniform(16))
            newArr[i] = array[n]
        }
        print("new",newArr)
        print(index)
    }
    
    func registernib()  {
         grid?.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")    }
    
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
