//
//  File.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import Foundation
var w = Webservice()

func updateItem(id: String, name: String, amount: Int, price: Double) {
    print("Edited!")
    w.editItemRequest(id: id, name: name, amount: amount, price: price)
}

func createItem(name: String, price: Double) {
    print("Created!")
    w.addItemRequest(name: name, price: price)
}

func deleteItem(id: String) {
    print("Deleted!")
    w.deleteItemRequest(id: id)
}

func findItem(name: String) -> Item {
    for i in items1 {
        if (i.name == name) {
            return i
        }
    }
    return Item(id: "Null", name: "Null", amount: 0, price: 0)
}
