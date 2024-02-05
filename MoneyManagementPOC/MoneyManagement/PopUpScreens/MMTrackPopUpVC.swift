//
//  MMTrackPopUpVC.swift
//  Minty
//
//  Created by Ameya on 04/01/24.
//

import UIKit
import DropDown
protocol MMTrackDelegate{
    func declinedPressed()
    func approvedPressed()
}
class MMTrackPopUpVC: BaseviewVC {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewCard: UIView!
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var imgViewTitle: UIImageView!
    @IBOutlet weak var lblTItle: UILabel!
    
    @IBOutlet weak var lblDesText: UILabel!
    
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var viewInnerDetails: UIView!
    
    @IBOutlet weak var lblValPurpose: UILabel!
    @IBOutlet weak var lblValDateRange: UILabel!
    @IBOutlet weak var lblValMaxUpdateLimit: UILabel!
    @IBOutlet weak var lblConsentExpirationDate: UILabel!
    @IBOutlet weak var lblValAccountInfo: UILabel!
    @IBOutlet weak var lblValAccountType: UILabel!
    
    @IBOutlet weak var viewFrequency: UIView!
    @IBOutlet weak var lblValFrequency: UILabel!
    
    
    @IBOutlet weak var btnDeny: UIButton!
    @IBOutlet weak var btnApprove: UIButton!
    
    @IBOutlet weak var imgCross: UIImageView!
    
    var arrFreq = ["3 Months", "6 Months", "9 Months", "1 Year"]
    var frequencyDropDown = DropDown()
    var callBack : MMTrackDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
    }
    
    func setUI(){
        self.viewCard.roundCorners(corners:[.topLeft, .topRight], radius: 20)
        self.viewCard.clipsToBounds = true
        
        self.viewInnerDetails.layer.borderColor = UIColor.init(hex: "#D9D9D9").cgColor
        self.viewInnerDetails.layer.borderWidth = 1
        self.viewInnerDetails.layer.cornerRadius = 15
        self.lblDesText.justifyContent()
        self.btnDeny.setDefaultBorderBlueBtn()
        self.btnApprove.setDefaultBlueBtn()
//        self.setUpDropDown()
//        self.imgCross.TapLisner {
//            self.dismiss(animated: true)
//        }
    }
    
    func setUpDropDown()
    {
    

        self.frequencyDropDown.anchorView = viewFrequency
        self.frequencyDropDown.dataSource = arrFreq
        self.frequencyDropDown.width = self.viewFrequency.bounds.size.width + 50
        self.frequencyDropDown.bottomOffset = CGPoint(x: 0, y:(frequencyDropDown.anchorView?.plainView.bounds.height)! + 5)
        self.frequencyDropDown.direction = .bottom
        self.frequencyDropDown.cellNib = UINib(nibName: "DropCell", bundle: nil)
        self.frequencyDropDown.setupCornerRadius(10)
        self.frequencyDropDown.cellHeight = 40
        self.frequencyDropDown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? DropCell else{
                return
            }
            let item = self.arrFreq[index]
            
            cell.lbl.text = item
            cell.lbl.textColor = UIColor.blue
    
        }
        
        let attributedString = NSMutableAttributedString(string: "1 Year")
                attributedString.setUnderlineForText("1 Year", with: .single)
        self.lblValFrequency.attributedText = attributedString
        
        self.frequencyDropDown.selectionAction = { [self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            let attributedString = NSMutableAttributedString(string: item)
                    attributedString.setUnderlineForText(item, with: .single)
            self.lblValFrequency.attributedText = attributedString
        }
        
        self.viewFrequency.TapLisner {
            self.frequencyDropDown.show()
        }
    }
    
    @IBAction func denyPressed(_ sender: Any) {
        self.dismiss(animated: true){
            self.callBack?.declinedPressed()
        }
    }
    
    @IBAction func approvePressed(_ sender: Any) {
        self.dismiss(animated: true){
            self.callBack?.approvedPressed()
        }
    }
}
