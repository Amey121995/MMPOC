//
//  ItemData.swift
//  MoneyManagementPOC
//
//  Created by Amey Dalvi on 04/02/24.
//

import Foundation
import UIKit

class ItemData
{
    var itemID:String?
    var itemName:String?
    var itemDes:String?
    var itemImage:UIImage?
    var collapsed: Bool?
    required init() {
        self.itemName = ""
        self.itemImage = UIImage()
    }
    
    required init(id: String? = nil , name:String? = nil,image:UIImage? = nil) {
        self.itemID = id
        self.itemName = name ?? ""
        self.itemImage = image ?? UIImage()
    }
    
    required init(id: String? = nil , name:String? = nil,image:UIImage? = nil, collapsed: Bool = false) {
        self.itemID = id
        self.itemName = name ?? ""
        self.itemImage = image ?? UIImage()
        self.collapsed = collapsed
    }
    
    required init(id: String? = nil , name:String? = nil, des:String? = nil ,image:UIImage? = nil){
        self.itemID = id
        self.itemName = name ?? ""
        self.itemDes = des ?? ""
        self.itemImage = image ?? UIImage()
    }
}

