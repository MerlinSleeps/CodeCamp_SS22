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

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

class Webservice : ObservableObject{
      
let urlCC1 = "http://141.51.114.20:8080"
var items = [Item]()
    
    func login(id: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
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
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
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
            let millis : Int = defaults.integer(forKey: "tokenrefresh")
            if(getCurrentMillis() - millis > 4*60){
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
                defaults.setValue(token, forKey: "jsonwebtoken")
                defaults.setValue(self.getCurrentMillis(), forKey: "tokenrefresh")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        return defaults.string(forKey: "jsonwebtoken")
    }
}
