//
//  File.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import Foundation

let urlItems = "http://141.51.114.20:8080/items/"

func updateItem(id: String, name: String, amount: Int, price: Double) {
    
    guard let url = URL(string: urlItems) else {
        print("Invalid url...")
        return
    }
    let itembody = Item( id: id, name: name, amount: amount, price: price)
    print(id)
    guard let token = Webservice().getRefreshToken() else {
        print("no token")
                 return
             }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.httpBody = try? JSONEncoder().encode(itembody)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)",  forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: request) {
        data, response, error in
        
        let httpresponse = response as? HTTPURLResponse
        print(httpresponse?.statusCode as Any)
        
    }.resume()
    
}

func createItem(name: String, price: Double) {
    
    guard let url = URL(string: urlItems) else {
        return
    }
    
    let createItemId = String(items1.count + 1000000)
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
        
        let httpresponse = response as? HTTPURLResponse
        print(httpresponse?.statusCode as Any)
    }.resume()
}

func deleteItem(id: String) {
    guard let url = URL(string: urlItems + "/" + id) else {
        return
    }
    
    guard let token = Webservice().getRefreshToken() else {
                 return
             }
    print(id)
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)",  forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: request) {
        data, response, error in
        
        let httpresponse = response as? HTTPURLResponse
        print(httpresponse?.statusCode as Any)
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
    let timeInterval: TimeInterval = TimeInterval(timeStamp)
    let date = Date(timeIntervalSince1970: timeInterval)
    let dformat = DateFormatter()
    dformat.dateFormat = "dd.MM.yyyy HH:mm:ss"
    return dformat.string(from: date)
}

func getDate(timeStamp: Int) -> String {
    let timeInterval: TimeInterval = TimeInterval(timeStamp)
    let date = Date(timeIntervalSince1970: timeInterval)
    let dformat = DateFormatter()
    dformat.dateFormat = "dd.MM.yy"
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
            if (itemPurchaseSumme[his.itemName!] == nil) {
                itemPurchaseSumme[his.itemName!] = (-his.value)
            } else {
                itemPurchaseSumme[his.itemName!]! += (-his.value)
            }
        }
    }
}

func getMostpopularItems() -> [String] {
    var itemSummeList = [Double](itemPurchaseSumme.values)
    var itemNames: [String] = []
    var othersSummeCount: Double = 0.0
    var othersAmountCount = 0
    itemSummeList.sort(by: >)
    var count = 0
    while (count < 8) {
        for (key, value) in itemPurchaseSumme {
            if (value == itemSummeList[count]) {
                itemNames.append(key)
            } else {
                if (itemSummeList.firstIndex(of: value)! >= 8) {
                    othersSummeCount += value
                }
            }
        }
        count += 1
    }
    itemPurchaseSumme["others"] = othersSummeCount
    
    for (key, value) in itemPurchaseCount {
        if (!itemNames.contains(key)) {
            othersAmountCount += value
        }
    }
    itemPurchaseCount["others"] = othersAmountCount
    return itemNames
}

func analysisOfTime() {
    var s = 5
    let timeInterval:TimeInterval = Date().timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    while (s > 0) {
        let old = timeStamp-myTimeInterval*s
        s -= 1
        let recent = timeStamp-myTimeInterval*s
        for his in histories {
            if (his.timestamp/1000 > old && his.timestamp/1000 <= recent) {
                if (amountInTime[String(s)] == nil) {
                    amountInTime[String(s)] = his.amount ?? 0
                } else {
                    amountInTime[String(s)]! += his.amount ?? 0
                }
                if (summeInTime[String(s)] == nil) {
                    summeInTime[String(s)] = his.value
                } else {
                    summeInTime[String(s)]! += his.value
                }
            }
        }
    }
}
