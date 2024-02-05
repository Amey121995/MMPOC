//
//  BaseviewVC.swift
//  MoneyManagementPOC
//
//  Created by Amey Dalvi on 04/02/24.
//

import UIKit

class BaseviewVC: UIViewController {

    var backButton : UIBarButtonItem!
    var btnBack : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backItem()
        // Do any additional setup after loading the view.
    }
    
    func backItem()
    {
        //setting up mode icon for home screen on navigation bar
        btnBack = UIButton(type: .custom)
        btnBack.isUserInteractionEnabled = true
        btnBack.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        btnBack.setImage(UIImage(named: "back_button"), for: .normal)
        btnBack.widthAnchor.constraint(equalToConstant: 48.0).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        btnBack.contentEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        btnBack.imageView?.contentMode = .left
        btnBack.tintColor = .blue
        btnBack.addTarget(self, action: #selector(self.onBackButtonPressed(_:)), for: UIControl.Event.touchUpInside);
        backButton = UIBarButtonItem(customView: btnBack)
        backButton.tintColor = .blue
    }

    

    @objc func onBackButtonPressed(_ sender : UIButton)
    {
        //self.navigationController?.pop(duration: 0.3)
        navigationController?.popViewController(animated: true)
    }

}

extension BaseviewVC{
    func addLeftBarButtonItems(items:[UIBarButtonItem])
    {
        self.navigationItem.leftBarButtonItems = items
    }
    
    func addRightBarButtonItems(items:[UIBarButtonItem])
    {
        self.navigationItem.rightBarButtonItems = items
    }
    
    func setWhiteNavigationBar(color: UIColor? = nil)
    {

        
        //MARK: Amey : Bug in view all in data gathering
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.blue]
        
    }
}

extension BaseviewVC{
    func setBackButtonWithoutCart(){
        addLeftBarButtonItems(items: [backButton])
    }
}

extension BaseviewVC{
    func getMemberList(completion: @escaping(_ userList: [MemberDetails]) -> Void){
        var user : [MemberDetails] = []
        
        user.append(MemberDetails(id: "1",name: "Amey"))
        user.append(MemberDetails(id: "2",name: "Urmila"))
        user.append(MemberDetails(id: "3",name: "Raghunath"))
        user.append(MemberDetails(id: "4",name: "Dalvi"))
        completion(user)
        
    }
}
