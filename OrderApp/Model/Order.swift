//
//  Order.swift
//  OrderApp
//
//  Created by ifts 25 on 16/03/23.
//

import Foundation

struct Order {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
