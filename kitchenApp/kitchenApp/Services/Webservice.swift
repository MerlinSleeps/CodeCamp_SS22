//
//  Webservice.swift
//  kitchenApp
//
//  Created by Olga Molenova on 15.06.22.
//

import Foundation


enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let id: String
    let password: String
}

struct Token: Codable {
    let token: String
    let expiration: Int64
}

struct newItem: Codable {
    var name: String
    var amount: Int
    var price: Double
}


struct UpdateUserRequestBody: Codable {
    let name: String
    let password: String
}

struct newFunding: Codable {
    let amount: Double
}

class Webservice : ObservableObject{
      
let urlCC1 = "http://141.51.114.20:8080"
var items = [Item]()
    
    
    func login(id: String, password: String, completion: @escaping (Result<Token, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: urlCC1 + "/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(id: id, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let token = try? JSONDecoder().decode(Token.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
           completion(.success(token))
            
        }.resume()
    }
    
    
    func getItems(completion:@escaping ([Item]) -> ()) {
        
        guard let url = URL(string: urlCC1 + "/items") else {
            print("Invalid url...")
            return
        }
        
        print(url)
    
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            let items = try! JSONDecoder().decode([Item].self, from: data!)
            
            print(items)
            DispatchQueue.main.async {
                completion(items)
            }
        }.resume()
        
    }
    
    func getCurrentMillis()->Int{
        return  Int(NSDate().timeIntervalSince1970)
    }

    
    func getRefreshToken()->String?{

        let defaults = UserDefaults.standard
        
        var needRefresh = false;
        
        let token = defaults.string(forKey: "jsonwebtoken")
        
        if(token == nil){
            needRefresh = true
        } else {
            let expiration : Int = defaults.integer(forKey: "expiration")
            if(getCurrentMillis() > expiration){
                needRefresh = true
            }
        }
        
        if(!needRefresh){
            return token
        }
        
       let id = defaults.string(forKey: "userID")!
       let password = defaults.string(forKey: "userPassword")!

        
        Webservice().login(id: id, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token.token, forKey: "jsonwebtoken")
                defaults.setValue(token.expiration/1000, forKey: "tokenrefresh")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        return defaults.string(forKey: "jsonwebtoken")
    }
    
    func addItemRequest(name: String, price: Double) {
        
        guard let url = URL(string: urlCC1 + "/items") else {
            return
        }
        
        let itembody = newItem(name: name, amount: 9, price: price)

        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(itembody)
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
        }.resume()
    }
    
    func editItemRequest(id: String, name: String, amount: Int, price: Double) {
        
        guard let url = URL(string: urlCC1 + "/items") else {
            return
        }
        
        let itembody = Item( id: id, name: name, amount: amount, price: price)

        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONEncoder().encode(itembody)
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
        }.resume()
    }
    
    func deleteItemRequest(id: String) {
        
        guard let url = URL(string: urlCC1 + "/items/" + id) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
        }.resume()
    }
    
    func getAllUser(completion:@escaping ([User]) -> ()) {
        
        guard let url = URL(string: urlCC1 + "/users") else {
            print("Invalid url...")
            return
        }
        
        print(url)
    
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            let users = try! JSONDecoder().decode([User].self, from: data!)
            
            print(users)
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()
        
    }
    
    func updateUser(id: String, name: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void){
        
        
        guard let url = URL(string: urlCC1 + "/users/"+id) else {
            print("Invalid url...")
            return
        }
        
        
       guard let token = getRefreshToken() else {
                    completion(.failure(.noData))
                    return
                }

        
        let body = UpdateUserRequestBody(name: name, password: password)

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        request.addValue("Bearer \(token)",  forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                completion(.failure(.decodingError))
            }
            
            completion(.success(()))
            
        }.resume()
        
        
    }
    
    
    func getUserData(id: String, token: String, completion: @escaping (Result<UserProfile, NetworkError>) -> Void){

        guard let url = URL(string: urlCC1 + "/users/"+id) else {
            print("Invalid url...")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(token)",  forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let userData = try? JSONDecoder().decode(UserProfile.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(userData))
            
        }.resume()
    }
    
    func fundUser(id: String, amount: Double) {
        
        
        guard let url = URL(string: urlCC1 + "/users/" + id + "/funding") else {
            print("Invalid url...")
            return
        }
        
        
       guard let token = getRefreshToken() else {
                    return
                }

        
        let body = newFunding(amount: amount)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        request.addValue("Bearer \(token)",  forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                print(httpResponse?.statusCode)
                //completion(.failure(.decodingError))
            }
            
            //completion(.success(()))
            
        }.resume()
    }
    
    
}
