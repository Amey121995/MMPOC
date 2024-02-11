//
//  MMChangeMobNoVC.swift
//  Amey
//
//  Created by Amey on 12/01/24.
//

import UIKit

class MMChangeMobNoVC: BaseviewVC {
    
    @IBOutlet weak var tblViewMobList: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    
    var commonHeaderDelegate : MMCommonHeadrDelegate?
    var selectedNumber = ""
    var isAddMemberPressed = false
    var arrPhone = [MFItem(id: "", name: "+ 91 9876543211", isSelected: false),
                    MFItem(id: "", name: "+ 91 9646362621", isSelected: false)]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTblView()
        self.btnContinue.setDefaultBlueBtn()
        // Do any additional setup after loading the view.
    }
    func setTblView(){
        self.tblViewMobList.register(UINib(nibName: "MMRadioMobileCell", bundle: nil), forCellReuseIdentifier: "MMRadioMobileCell")
        self.tblViewMobList.register(UINib(nibName: "MMAddAnotherMobCell", bundle: nil), forCellReuseIdentifier: "MMAddAnotherMobCell")
        self.tblViewMobList.register(UINib(nibName: "MMAddPhoneTextCell", bundle: nil), forCellReuseIdentifier: "MMAddPhoneTextCell")
        self.tblViewMobList.dataSource = self
        self.tblViewMobList.delegate = self
        self.tblViewMobList.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.tblViewMobList.separatorStyle = .none
    }
    
    @IBAction func onContinuePressed(_ sender: Any) {
        if isAddMemberPressed{
            let str = self.selectedNumber.trimmingCharacters(in: .whitespacesAndNewlines)
            if str.count < 10{
                self.showToast(message: "Kindly enter correct mobile number.")
            }
            else{
                self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMVerifyMobileVC")
            }
        }
        else{
            let str = self.selectedNumber.trimmingCharacters(in: .whitespacesAndNewlines)
            if str.isEmpty{
                self.showToast(message: "Select or add mobile number.")
            }
            else if str.count < 10{
                self.showToast(message: "Kindly enter correct mobile number.")
            }
            else {
                self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMVerifyMobileVC")
            }
        }
    }

}

extension MMChangeMobNoVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPhone.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.arrPhone.count
        {
            if self.isAddMemberPressed
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MMAddPhoneTextCell", for: indexPath) as! MMAddPhoneTextCell
                cell.tfAddNumber.addTarget(self, action: #selector(textDidChange(_ :)), for: .editingChanged)
                cell.tfAddNumber.keyboardType = .phonePad
                cell.tfAddNumber.delegate = self
                cell.tfAddNumber.maxLength = 10
                cell.tfAddNumber.text = ""
                self.selectedNumber = ""
                cell.tfAddNumber.becomeFirstResponder()
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MMAddAnotherMobCell", for: indexPath) as! MMAddAnotherMobCell
                return cell
            }
        }
        else {
            let item = arrPhone[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "MMRadioMobileCell", for: indexPath) as! MMRadioMobileCell
            cell.lblText.text = item.name
            if item.isSelected{
                cell.imgRadio.tintColor = UIColor.blue
            }
            else{
                cell.imgRadio.tintColor = UIColor.lightGray
            }
            return cell
        }
    }
}
extension MMChangeMobNoVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  indexPath.row == self.arrPhone.count, !self.isAddMemberPressed
        {
            for i in 0...(self.arrPhone.count - 1)
            {
                self.arrPhone[i].isSelected = false
            }
            
            self.isAddMemberPressed = true
            self.tblViewMobList.reloadData()
        }
        else if indexPath.row == self.arrPhone.count, self.isAddMemberPressed{
            
        }
        else {
            
            for i in 0...(self.arrPhone.count - 1)
            {
                if i == indexPath.row{
                    self.isAddMemberPressed = false
                    self.arrPhone[i].isSelected = true
                    self.selectedNumber = self.arrPhone[i].name
                    self.selectedNumber = self.selectedNumber.replacingOccurrences(of: "+ 91 ", with: "")
                }
                else{
                    self.arrPhone[i].isSelected = false
                }
            }
            self.tblViewMobList.reloadData()
        }
    }
}

extension MMChangeMobNoVC: UITextFieldDelegate{
    @objc func textDidChange(_ sender: UITextField) {
        if isAddMemberPressed{
            self.selectedNumber = sender.text?.replacingOccurrences(of: " ", with: "") ?? ""
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
