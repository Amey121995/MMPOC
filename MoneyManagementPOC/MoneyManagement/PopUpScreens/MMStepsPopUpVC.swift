//
//  MMStepsPopUpVC.swift
//  Minty
//
//  Created by Ameya on 08/01/24.
//

import UIKit

class MMStepsPopUpVC: BaseviewVC {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgCrossBtn: UIImageView!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblFooter: UILabel!
    
    
    let listStep = [ItemData(id: "1", name: "Select bank account you want to track!", image: nil),
                    ItemData(id: "2", name: "Select your account and verify with OTP", image: nil),
                    ItemData(id: "3", name: "All done! Enjoy seamless tracking", image: nil),]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    func setupUI(){
        //MMStepCell
        self.viewCard.roundCorners(corners:[.topLeft, .topRight], radius: 20)
        self.viewCard.clipsToBounds = true
        
        self.tblView.register(UINib(nibName: "MMStepCell", bundle: nil), forCellReuseIdentifier: "MMStepCell")
        self.tblView.separatorStyle = .none
        self.imgCrossBtn.TapLisner {
            self.dismiss(animated: true)
        }
    }


    

}

extension MMStepsPopUpVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        self.viewWillLayoutSubviews()
       
        
       
    }
    
    override func viewWillLayoutSubviews() {
        
        super.updateViewConstraints()
        DispatchQueue.main.async {
            self.tblViewHeight.constant = self.tblView.contentSize.height
        }
    }
    
}

extension MMStepsPopUpVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listStep.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "MMStepCell", for: indexPath) as! MMStepCell
        let index = indexPath.row
        cell.lblStep.text = "STEP \(index + 1)"
        cell.lblText.text = listStep[index].itemName ?? ""
        if index == self.listStep.count - 1
        {
            cell.imgArrow.isHidden = true
            cell.viewArrowCard.isHidden = true
        }
        else{
            cell.imgArrow.isHidden = false
            cell.viewArrowCard.isHidden = false
        }
        return cell
    }
    
    
}
