//
//  ViewController.swift
//  MoneyManagementPOC
//
//  Created by Amey Dalvi on 04/02/24.
//

import UIKit

class ViewController: BaseviewVC {

    @IBOutlet var btnDemo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func demoBtn(_ sender: Any) {
        let destVC = MMSelectMeberVC()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
}

