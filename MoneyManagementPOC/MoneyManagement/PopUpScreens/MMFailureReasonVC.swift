//
//  MMFailureReasonVC.swift
//  Minty
//
//  Created by Ameya on 12/01/24.
//

import UIKit

class MMFailureReasonVC: BaseviewVC{

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imgTitleIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stackDetailTask: UIStackView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lblDes1: UILabel!

    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var lblDes2: UILabel!
    
    @IBOutlet weak var btnOk: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        //MMStepCell
        self.viewCard.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        self.viewCard.clipsToBounds = true
       
    }
    
    @IBAction func onOkPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
}
