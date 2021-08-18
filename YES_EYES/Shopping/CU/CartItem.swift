//
//  CartItem.swift
//  YES_EYES
//
//  Created by 반예원 on 2021/08/18.
//

import Foundation

class CartItem {
    
    var quantity : Int = 1
    var item : CU1Model
    
    
    init(item: CU1Model) {
        self.item = item
    }
}
