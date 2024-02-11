//
//  MMBankRequestLoaderVC.swift
//  Amey
//
//  Created by Amey on 08/01/24.
//

import UIKit
import MBCircularProgressBar
protocol BankRequestDelegate{
    func isBankResponse(isSuccess: Bool)
}

class MMBankRequestLoaderVC: BaseviewVC {
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    
    var hasAddedAnimation = false
    
    var count = 1 * 5
    var resendTimer = Timer()
    var startDate = Date()
    var hasFailed = 0
    var delagate : BankRequestDelegate?
    var commonHeaderDelegate : MMCommonHeadrDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.progressView.maxValue = CGFloat(count)
        self.resetTimer()
        self.setBackButtonWithoutCart()
        self.title = "ASSETS"
        // Do any additional setup after loading the view.
    }

    override func onBackButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Attention!!", message: "Please be aware that clicking the back button will interrupt all on going processes, Do you want to continue?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func resetTimer(){
        resendTimer.invalidate()
        startDate = Date()
       
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    @objc func updateTimerLabel() {
        
        let interval = -Int(startDate.timeIntervalSinceNow) - count
        
        if interval <= -1{
            
//            if interval > -10{
//                addHeartBeat()
//            }
            self.progressView.value = CGFloat(interval)
            
            if -(interval) == 1 {
               
                
                self.navigationController?.popViewController(animated: true)
                //self.delagate?.isBankResponse(isSuccess: true)
                self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMResultVC")
               
            }
            else{}
            
        }else{
            self.resendTimer.invalidate()
           
        
        }
    }
    
    func addHeartBeat(){
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")

            animation.values = [1.0, 1.2, 1.0]
            animation.keyTimes = [0, 0.5, 1]
            animation.duration = 1.0
            animation.repeatCount = Float.infinity
//            progress.add(animation, forKey: "pulse")
        progressView.layer.add(animation, forKey: "pulse")
        hasAddedAnimation = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        resendTimer.invalidate()
    }

}
