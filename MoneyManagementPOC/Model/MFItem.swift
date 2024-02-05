//
//  MFItem.swift
//  MoneyManagementPOC
//
//  Created by Amey Dalvi on 04/02/24.
//

import Foundation
import UIKit
class MFItem
{
    var id = ""
    var name = ""
    var subItemList = [MFItem]()
    var isSelected = false
    
    required init(id : String, name : String, sublist: [MFItem]? = nil, isSelected:Bool? = false) {
        self.id = id
        self.name = name
        self.subItemList = sublist  ?? [MFItem]()
        self.isSelected = isSelected ?? false
    }
    
    required init()
    {
    }
}
