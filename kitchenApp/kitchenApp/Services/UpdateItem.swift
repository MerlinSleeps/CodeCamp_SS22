//
//  File.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import Foundation

let urlCC1 = "http://141.51.114.20:8080"

func updateItem(id: String, name: String, amount: Int, price: Double) {
    
    guard let url = URL(string: urlCC1 + "/items") else {
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
    
    guard let url = URL(string: urlCC1 + "/items") else {
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
    guard let url = URL(string: urlCC1 + "/items/" + id) else {
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

func initHistory() -> [History] {
    var histories : [History] = []
    var items2: [Item] = []
    items2.append(Item(id: "1", name: "i1", amount: 2, price: 3.33))
    items2.append(Item(id: "2", name: "i2", amount: 3, price: 4.44))
    histories.append(History(id: 1, action: "Transfer", time: getTime(), creditchange: -18.5, itemsBought: [], from: "u1", to: "u2"))
    histories.append(History(id: 2, action: "Bought", time: getTime(), creditchange: -33.5, itemsBought: items2, from: "", to: ""))
    return histories
}

func getTime() -> String {
    let now = Date()
    let dformat = DateFormatter()
    dformat.dateFormat = "dd.MM.yyyy HH:mm:ss"
    print(dformat.string(from: now))
    return dformat.string(from: now)
}
