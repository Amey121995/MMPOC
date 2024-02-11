//
//  MMVerifyMobileVC.swift
//  Amey
//
//  Created by Amey on 11/01/24.
//

import UIKit
import OTPFieldView
class MMVerifyMobileVC: BaseviewVC {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var otpView: OTPFieldView!
    @IBOutlet weak var stackError: UIStackView!
    @IBOutlet weak var lblErrorPhone: UILabel!
    @IBOutlet weak var imgErrorInfo: UIImageView!
    
    @IBOutlet weak var stackResend: UIStackView!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    
    @IBOutlet weak var lblChangeNumber: UILabel!
    
    @IBOutlet weak var btnContinue: UIButton!
    
    var sentOTP = "123456"
    var count = 60
    var email = ""
    var mobile = ""
    var country_code = "+91"
    var resendTimer = Timer()
    var startDate = Date()
    var userEnterOtp = ""
    var shouldGenerateOtp = false
    var expiryCount = (5 * 60) - 1 // (5 * 60) - 1
    var expireTimer = Timer()
    var hasEnteredAll = false
    var sentCount = 0
    var commonHeaderDelegate : MMCommonHeadrDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupOtp()
        self.resendOtpTimer()
        self.btnContinue.setDefaultBlueBtn()
      
        self.lblChangeNumber.TapLisner {
            self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMChangeMobNoVC")
        }
       
    }
    
    func setupOtp(){
        self.otpView.contentMode = .scaleAspectFill
        self.otpView.fieldsCount = 6
        self.otpView.otpInputType = .numeric
        self.otpView.fieldBorderWidth = 1
        self.otpView.defaultBackgroundColor = .white
        self.otpView.filledBackgroundColor = .white
        self.otpView.defaultBorderColor = UIColor.gray
        self.otpView.filledBorderColor = UIColor.blue
        self.otpView.cursorColor = UIColor.blue
        self.otpView.displayType = .square
        self.otpView.fieldSize = 40
        self.otpView.separatorSpace = 10
        self.otpView.shouldAllowIntermediateEditing = true
        self.otpView.delegate = self
        self.otpView.initializeUI()
        
        view.endEditing(true)
        self.imgErrorInfo.TapLisner {
            let destVC = MMFailureReasonVC()
            destVC.modalPresentationStyle = .overFullScreen
            self.present(destVC,animated: true)
        }
    }
    
    @IBAction func resendPressed(_ sender: Any) {
        self.otpView.resetOTPTexts()
        if self.sentCount < 3 {
            self.sentCount += 1
            self.resendOtpTimer()
            
        }
        else {
            self.showToast(message: "Resend OTP Attempts Exhausted.")
        }
        
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        if self.hasEnteredAll{
            if self.userEnterOtp == self.sentOTP{
                self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMTrackBankAccVC")
            }
            else{
                self.showToast(message: "Kindly Enter Correct OTP")
            }
        }
        else{
            self.showToast(message: "Kindly Enter Correct OTP")
        }
    }
    
//    @IBAction func onChangePressed(_ sender: Any) {
//        self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMChangeMobNoVC")
//    }
    
}

extension MMVerifyMobileVC: OTPFieldViewDelegate{
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        self.userEnterOtp = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        self.hasEnteredAll =  hasEnteredAll
        return hasEnteredAll
    }
    
}

extension MMVerifyMobileVC {
    @objc func resendOtpTimer() {
        resendTimer.invalidate()
        reExpireOtp()
        startDate = Date()
        self.lblResend.isHidden = false
        self.lblResend.textColor = .red
        self.lblResend.text = "Resend OTP in \(timeString(time: TimeInterval(count)))".replacingOccurrences(of: "-", with: "")
        self.btnResend.isHidden = true
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
       
    }
    
    @objc func updateTimerLabel()  {
        
        let interval = -Int(startDate.timeIntervalSinceNow) - count
        self.lblResend.textColor = .red
        if interval <= -1{
            self.lblResend.text = "Resend OTP in \(timeString(time: TimeInterval(-(interval))))".replacingOccurrences(of: "-", with: "")
//
        }else{
            self.btnResend.isHidden = false
            self.lblResend.text = "Didn’t get the code ?"
            self.lblResend.textColor = UIColor.lightGray
            self.btnResend.isUserInteractionEnabled = true
            self.resendTimer.invalidate()
            self.count = (60) - 1
            
        }
    }
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

extension MMVerifyMobileVC {
    @objc func reExpireOtp(){
        expireTimer.invalidate()
        self.expiryCount = (5 * 60) - 1 // (5 * 60) - 1
        expireTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(shouldexpireOtp), userInfo: nil, repeats: true)
    }
    
    @objc func shouldexpireOtp(){
        let interval = -Int(startDate.timeIntervalSinceNow) - expiryCount
       
        if interval <= -1{
//            print("Expire Timer Running with \(interval)")
//
        }else{
            expireOTP()
            self.expireTimer.invalidate()
            self.expiryCount = (5 * 60) - 1  // (5 * 60) - 1
        }
    }
    func expireOTP(){
        self.shouldGenerateOtp = true
        self.sentOTP = "123456"
        print("otp reset")
    }
}
