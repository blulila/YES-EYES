//
//  Cart.swift
//  YES_EYES
//
//  Created by 반예원 on 2021/08/18.
//
import Foundation

class Cart {
    
    private(set) var items : [CartItem] = []
}

extension Cart {
    
 
    
    var totalQuantity : Int {
        get { return items.reduce(0) { value, item in
            value + item.quantity
            }
        }
    }
    
    func updateCart(with product: CU1Model) {
        if !self.contains(product: product) {
            self.add(product: product)
        } else {
            self.remove(product: product)
        }
    }
    
    func updateCart() {
        
        for item in self.items {
            if item.quantity == 0 {
                updateCart(with: item.item)
            }
        }
    }
    
    func add(product: CU1Model) {
        let item = items.filter { $0.item == product }
        
        if item.first != nil {
            item.first!.quantity += 1
        } else {
            items.append(CartItem(item: product))
        }
    }
    
    func remove(product: CU1Model) {
        guard let index = items.index(where: { $0.item == product }) else { return}
        items.remove(at: index)
    }
    
    func contains(product: CU1Model) -> Bool {
        let item = items.filter { $0.item == product }
        return item.first != nil
    }
}
