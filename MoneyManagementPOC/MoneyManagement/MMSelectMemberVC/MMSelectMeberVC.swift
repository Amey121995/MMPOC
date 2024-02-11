//
//  Money Management
//  MMSelectMeberVC.swift
//  Amey
//
//  Created by Amey on 02/01/24.
//

import UIKit
import DropDown

class MMSelectMeberVC: BaseviewVC {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var imgViewBanner: UIImageView!
    @IBOutlet weak var viewSelectMember: UIView!
    @IBOutlet weak var lblSelectMemberTitle: UILabel!
    
    @IBOutlet weak var viewMemebarDropDown: UIView!
    @IBOutlet weak var tfMemberDropDown: UITextField!
    
    @IBOutlet weak var btnTrackAcoount: UIButton!
    @IBOutlet weak var lblKnowItWorks: UILabel!
    
    
    let userMembersDropDown = DropDown()
    var userList = [MemberDetails]()
    var selectedMember = MemberDetails()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackButtonWithoutCart()
        self.title = "ASSETS"
        
        self.setUI()
        
    }


    func setUI()
    {
        self.viewSelectMember.layer.borderWidth = 1
        self.viewSelectMember.layer.borderColor = UIColor.green.cgColor
        self.viewSelectMember.layer.cornerRadius = 15
        
        self.viewMemebarDropDown.layer.cornerRadius = self.viewMemebarDropDown.bounds.size.height / 2.1
        self.viewMemebarDropDown.layer.borderWidth = 0.5
        self.viewMemebarDropDown.layer.borderColor = UIColor.lightGray.cgColor
        self.viewMemebarDropDown.layer.shadowOpacity = 0.18
        self.viewMemebarDropDown.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.viewMemebarDropDown.layer.shadowRadius = 0.8
        self.viewMemebarDropDown.layer.shadowColor = UIColor.black.cgColor
        self.viewMemebarDropDown.layer.masksToBounds = false
        self.viewMemebarDropDown.clipsToBounds = true

        self.getMemberList { list in
            self.userList = list
            self.setUpDropDown()
           
        }
        
        let attributedString = NSMutableAttributedString(string: "Know how it works?")
                attributedString.setUnderlineForText("Know how it works?", with: .single)
        self.lblKnowItWorks.attributedText = attributedString
        
        self.lblKnowItWorks.TapLisner {
            let destVC = MMStepsPopUpVC()//MMTrackPopUpVC()
            destVC.modalPresentationStyle = .overFullScreen
            self.present(destVC, animated: true)
        }
    }
    
    func setUpDropDown()
    {
        var userMembersList : [String] = []
        for member in userList
        {
            userMembersList.append("\(member.name ?? "Null Name")")
        }
        

        self.tfMemberDropDown.isUserInteractionEnabled = false
        self.userMembersDropDown.anchorView = viewMemebarDropDown
        self.userMembersDropDown.dataSource = userMembersList
        self.userMembersDropDown.width = self.viewMemebarDropDown.bounds.size.width - 10
        self.userMembersDropDown.bottomOffset = CGPoint(x: 5, y:(userMembersDropDown.anchorView?.plainView.bounds.height)! + 5)
        self.userMembersDropDown.direction = .bottom
        self.userMembersDropDown.cellNib = UINib(nibName: "DropCell", bundle: nil)
        self.userMembersDropDown.setupCornerRadius(10)
        self.userMembersDropDown.cellHeight = 40
        self.userMembersDropDown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? DropCell else{
                return
            }
            var item = self.userList[index]
            
            cell.lbl.text = "  \(item.name ?? "Null Name")"
            cell.lbl.textColor = UIColor.blue
            
        }
        
        self.userMembersDropDown.selectionAction = { [self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedMember = self.userList[index]
            self.tfMemberDropDown.text = item
        }
        
        self.viewMemebarDropDown.TapLisner {
            self.userMembersDropDown.show()
        }
    }
    
    @IBAction func trackPressed(_ sender: Any) {
        if self.selectedMember.id == nil
        {
            self.showToast(message: "Please select member.")
        }
        else if self.selectedMember.id == "0"
        {
            self.showToast(message: "Please select member.")
        }
        else{
            let destVC = MMTrackPopUpVC()
            destVC.callBack = self
            destVC.modalPresentationStyle = .overFullScreen
            self.present(destVC, animated: true)
        }
        
        
    }

}

extension NSMutableAttributedString {
    func setUnderlineForText(_ textToFind: String, with underlineStyle: NSUnderlineStyle) {
        let range = NSString(string: self.string).range(of: textToFind)
        if range.location != NSNotFound {
            self.addAttributes([NSAttributedString.Key.underlineStyle: underlineStyle.rawValue], range: range)
        }
    }
}
extension MMSelectMeberVC : MMTrackDelegate{
    func declinedPressed() {
        let destVC = MMGenericPopUpVC()
        destVC.callBack = self
        destVC.titles = "Consent Denied"
        destVC.subTitle = "Are you sure you want to denied the consent? You are almost Done."
        destVC.btn1text = "Yes"
        destVC.btn2text = "No"
        destVC.modalPresentationStyle = .overFullScreen
        self.present(destVC, animated: true)
    }
    
    func approvedPressed() {
        let destVC = MMCommonHeadrVC()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    
}

extension MMSelectMeberVC: BankRequestDelegate{
    func isBankResponse(isSuccess: Bool) {
        let destVC = MMCommonHeadrVC()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}
extension MMSelectMeberVC : MMGenericProto{
    func btnPressed(isBtn1Pressed: Bool) {
        if isBtn1Pressed{
          
        }
        else{
            let destVC = MMTrackPopUpVC()
            destVC.callBack = self
            destVC.modalPresentationStyle = .overFullScreen
            self.present(destVC, animated: true)
        }
    }
}
