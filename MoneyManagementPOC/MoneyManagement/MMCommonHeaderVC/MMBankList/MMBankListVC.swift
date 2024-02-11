//
//  MMBankListVC.swift
//  Amey
//
//  Created by Amey on 10/01/24.
//

import UIKit

class MMBankListVC: BaseviewVC {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var collectionPopularBanks: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tblViewBank: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var popularBankListArray = [ItemData(id: "", name: "Axis Bank", des: nil, image: UIImage(named: "blueBank")),
                                ItemData(id: "", name: "Bank of Baroda", des: nil, image: UIImage(named: "blueBank")),
                                ItemData(id: "", name: "Federal Bank", des: nil, image: UIImage(named: "blueBank")),
                                ItemData(id: "", name: "HDFC Bank", des: nil, image: UIImage(named: "blueBank")),
                                ItemData(id: "", name: "ICICI Bank", des: nil, image: UIImage(named: "blueBank")),
                                ItemData(id: "", name: "State Bank of India", des: nil, image: UIImage(named: "blueBank")),
                                ItemData(id: "", name: "IDFC First Bank", des: nil, image: UIImage(named: "blueBank")),
                                ItemData(id: "", name: "Central Bank", des: nil, image: UIImage(named: "blueBank"))]
    var bankListArray = [ItemData(id: "", name: "Axis Bank", des: nil, image: UIImage(named: "blueBank")),
                        ItemData(id: "", name: "Bank of Baroda", des: nil, image: UIImage(named: "blueBank")),
                        ItemData(id: "", name: "Federal Bank", des: nil, image: UIImage(named: "blueBank")),
                        ItemData(id: "", name: "HDFC Bank", des: nil, image: UIImage(named: "blueBank")),
                        ItemData(id: "", name: "ICICI Bank", des: nil, image: UIImage(named: "blueBank")),
                        ItemData(id: "", name: "State Bank of India", des: nil, image: UIImage(named: "blueBank")),
                        ItemData(id: "", name: "IDFC First Bank", des: nil, image: UIImage(named: "blueBank")),
                        ItemData(id: "", name: "Central Bank", des: nil, image: UIImage(named: "blueBank"))]
    
    var commonHeaderDelegate :MMCommonHeadrDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setBackButtonWithoutCart()
        self.tfSearch.setLeftIcon(UIImage(named: "icon-search - 1") ?? UIImage(), tint: UIColor.blue)
        self.setCollection()
        self.setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  self.showHeaderView(title: "Select Bank Account", des: "Track your balances with 100% accuracy, get insights on your expenses!", step: 1)
    }
    

    func setCollection(){
        self.collectionPopularBanks.register(UINib(nibName: "MMDashCell", bundle: nil), forCellWithReuseIdentifier: "MMDashCell")
        self.collectionPopularBanks.dataSource = self
        self.collectionPopularBanks.delegate = self
       
    }
    
    func setTableView(){
        self.tblViewBank.register(UINib(nibName: "MMBankTblCell", bundle: nil), forCellReuseIdentifier: "MMBankTblCell")
        self.tblViewBank.dataSource = self
        self.tblViewBank.delegate = self
        self.tblViewBank.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.tblViewBank.separatorStyle = .none
    }
}
extension MMBankListVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.popularBankListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.popularBankListArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMDashCell", for: indexPath) as! MMDashCell
        cell.lblName.text = item.itemName
        cell.lblName.font = UIFont(name: "RedHatText-Medium", size: 12)
        cell.imgArrow.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = MMLowSuccessRatePopUpVC()
        destVC.delegate = self
        destVC.modalPresentationStyle = .overFullScreen
        self.present(destVC, animated: true)
    }
   
}

extension MMBankListVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 2) - 5, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let height:CGFloat = collectionPopularBanks.collectionViewLayout.collectionViewContentSize.height
        self.collectionViewHeight.constant = height + 10
        self.view.layoutIfNeeded()
    }
}

extension MMBankListVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bankListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.bankListArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMBankTblCell", for: indexPath) as! MMBankTblCell
        cell.lblName.text = item.itemName
        return cell
    }
    
    
}


extension MMBankListVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        self.viewWillLayoutSubviews()
       
        
       
    }
    
    override func viewWillLayoutSubviews() {
        
        super.updateViewConstraints()
        DispatchQueue.main.async {
            
            self.tableViewHeight.constant = self.tblViewBank.contentSize.height + 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = MMLowSuccessRatePopUpVC()
        destVC.delegate = self
        destVC.modalPresentationStyle = .overFullScreen
        self.present(destVC, animated: true)
    }
    
}


extension MMBankListVC : MMLowSussessProto{
    func cancelPressed() {
        
    }
    
    func continuePressed() {
        self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMVerifyMobileVC")
    }
    
    
}
