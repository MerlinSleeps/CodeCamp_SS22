//
//  File.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import Foundation

let urlItems = "http://141.51.114.20:8080/items"

func updateItem(id: String, name: String, amount: Int, price: Double) {
    
    guard let url = URL(string: urlItems) else {
        print("Invalid url...")
        return
    }
    let itembody = Item( id: id, name: name, amount: amount, price: price)
    
    guard let token = Webservice().getRefreshToken() else {
        print("no token")
                 return
             }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.httpBody = try? JSONEncoder().encode(itembody)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)",  forHTTPHeaderField: "Authorization")
    
    print(request)
    
    URLSession.shared.dataTask(with: request) {
        data, response, error in
        
        let httpresponse = response as? HTTPURLResponse
        print(httpresponse?.statusCode)
        
    }.resume()
    
    print("Edited!")
}

func createItem(name: String, price: Double) {
    print("Created!")
    
    guard let url = URL(string: urlItems) else {
        return
    }
    
    let createItemId = String(items1.count + 1)
    let itembody = Item(id: createItemId, name: name, amount: 9, price: price)

    guard let token = Webservice().getRefreshToken() else {
                 return
             }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONEncoder().encode(itembody)
    request.addValue("Bearer \(token)",  forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) {
        data, response, error in
    }.resume()
}

func deleteItem(id: String) {
    print("Deleted!")
    guard let url = URL(string: urlItems + id) else {
        return
    }
    
    guard let token = Webservice().getRefreshToken() else {
                 return
             }

    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)",  forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: request) {
        data, response, error in
    }.resume()
}

func findItem(name: String) -> Item {
    for i in items1 {
        if (i.name == name) {
            return i
        }
    }
    return Item(id: "Null", name: "Null", amount: 0, price: 0)
}

func getTime(timeStamp: Int) -> String {
    let timeInterval: TimeInterval = TimeInterval(timeStamp/1000)
    let date = Date(timeIntervalSince1970: timeInterval)
    let dformat = DateFormatter()
    dformat.dateFormat = "dd.MM.yyyy HH:mm:ss"
    print(date)
    print(timeStamp)
    return dformat.string(from: date)
}

func getDate(timeStamp: Int) -> String {
    let timeInterval: TimeInterval = TimeInterval(timeStamp/1000)
    let date = Date(timeIntervalSince1970: timeInterval)
    let dformat = DateFormatter()
    dformat.dateFormat = "dd.MM.yyyy"
    print(timeStamp)
    return dformat.string(from: date)
}

func statistic() {
    for his in histories {
        if (his.type == "purchase") {
            if (itemPurchaseCount[his.itemName!] == nil) {
                itemPurchaseCount[his.itemName!] = his.amount!
            } else {
                itemPurchaseCount[his.itemName!]! += his.amount!
            }
        }
    }
}

func getMostpopularItems() -> [String] {
    var itemAmountList = [Int](itemPurchaseCount.values)
    var itemNames: [String] = []
    var othersCount = 0
    itemAmountList.sort(by: >)
    for (key, value) in itemPurchaseCount {
        if (value == itemAmountList[0] || value == itemAmountList[1] || value == itemAmountList[2] || value == itemAmountList[3] || value == itemAmountList[4]) {
            itemNames.append(key)
        }
    }

    return itemNames
}

