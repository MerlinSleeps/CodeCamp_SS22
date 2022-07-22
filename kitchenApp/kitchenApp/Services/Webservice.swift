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

struct SignUpRequestBody: Codable {
    let id: String
    let name: String
    let password: String
}

struct Token: Codable {
    let token: String
    let expiration: Int64
}

struct UpdateUserRequestBody: Codable {
    let name: String
    let password: String
}

struct newFunding: Codable {
    let amount: Double
}

struct pruchaseItemBody: Codable {
    let itemId: String
    let amount: Int
}

struct sendMoneyBody: Codable {
    let amount: Double
    let recipientId: String
}

struct updateAdminBody: Codable {
    let id: String
    let name: String
    let isAdmin: Bool
    let password: String
}

struct nilBody: Codable {
}

class Webservice : ObservableObject{
      
    //URL + ROUTES
    let URLCC1 = "http://141.51.114.20:8080"
    let USERS = "/users"
    let LOGIN = "/login"
    let ITEMS = "/items"
    let USERS_ = "/users/"
    let REFUND = "/refund"
    let FUNDING = "/funding"
    let PURCHASES = "/purchases"
    let SEND_MONEY = "/sendMoney"

    //URL PARAMETER
    let USER_ID = "userID"
    let USER_PASSWORD = "userPassword"
    
    //HTTP_METHOD
    let PUT = "PUT"
    let POST = "POST"
    
    //ERROR MESSAGES
    let ERROR_MESSAGE_NO_DATA = "No data"
    let ERROR_MESSAGE_BAD_URL = "URL is not correct"
    
    //REQUEST CONTENT
    let BEARER_ = "Bearer "
    let JWT = "jsonwebtoken"
    let EXPIRATION = "expiration"
    let CONTENT_TYPE = "Content-Type"
    let TOKEN_REFRESH = "tokenrefresh"
    let AUTHORIZATION = "Authorization"
    let APPLICATION_JSON = "application/json"

    
    func createRequest<T: Encodable>(url: URL, body: T, httpMethod: String, auth: Bool = false,
                                     token: String = "", hasBody: Bool = true) -> URLRequest {
        var request = URLRequest(url: url )
        request.httpMethod = httpMethod
        request.addValue(APPLICATION_JSON, forHTTPHeaderField: CONTENT_TYPE)
        if hasBody {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        if auth {
            request.addValue(BEARER_ + "\(token)",  forHTTPHeaderField: AUTHORIZATION)
        }
        
        return request
    }
    
    func login(id: String, password: String, completion: @escaping (Result<Token, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: URLCC1 + LOGIN) else {
            completion(.failure(.custom(errorMessage: ERROR_MESSAGE_BAD_URL)))
            return
        }
        
        let body = LoginRequestBody(id: id, password: password)
        
        let request = createRequest(url: url, body: body, httpMethod: POST)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: self.ERROR_MESSAGE_NO_DATA)))
                return
            }
            
            guard let token = try? JSONDecoder().decode(Token.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            print(token)
            
           completion(.success(token))
            
        }.resume()
    }
    
    
    func signUP(id: String, name: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: URLCC1 + USERS) else {
            completion(.failure(.custom(errorMessage: ERROR_MESSAGE_BAD_URL)))
            return
        }
        
        let body = SignUpRequestBody(id: id, name: name, password: password)
        
        let request = createRequest(url: url, body: body, httpMethod: POST)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: self.ERROR_MESSAGE_NO_DATA)))
                return
            }
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                completion(.failure(.custom(errorMessage: "ooo...")))
                return
            }
    
            
            let str = String(decoding: data, as: UTF8.self)
            
           completion(.success(str))
            
        }.resume()
    }
    
    
    func getItems(completion:@escaping ([Item]) -> ()) {
        
        guard let url = URL(string: URLCC1 + ITEMS) else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
    
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            let items = try! JSONDecoder().decode([Item].self, from: data!)
            
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
        
        let token = defaults.string(forKey: JWT)
        
        if(token == nil){
            needRefresh = true
        } else {
            let expiration : Int = defaults.integer(forKey: EXPIRATION)
            if(getCurrentMillis() > expiration){
                needRefresh = true
            }
        }
        
        if(!needRefresh){
            return token
        }
        
       let id = defaults.string(forKey: USER_ID)!
       let password = defaults.string(forKey: USER_PASSWORD)!

        
        Webservice().login(id: id, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token.token, forKey: self.JWT)
                defaults.setValue(token.expiration/1000, forKey: self.TOKEN_REFRESH)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        return defaults.string(forKey: JWT)
    }
    
    
    func getAllUser(completion:@escaping ([User]) -> ()) {
        
        guard let url = URL(string: URLCC1 + USERS) else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            let users = try! JSONDecoder().decode([User].self, from: data!)
            
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()
        
    }
    
    func updateUser(id: String, name: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void){
        
        
        guard let url = URL(string: URLCC1 + USERS_ + id) else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        
       guard let token = getRefreshToken() else {
                    completion(.failure(.noData))
                    return
                }

        
        let body = UpdateUserRequestBody(name: name, password: password)

        let request = createRequest(url: url, body: body, httpMethod: PUT, auth: true, token: token)
        

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                completion(.failure(.decodingError))
            }
            
            completion(.success(()))
            
        }.resume()
        
        
    }
    
    func updateAdmin(id: String, name: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void){
        
        
        guard let url = URL(string: URLCC1 + USERS_ + "admin") else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        
       guard let token = getRefreshToken() else {
                    completion(.failure(.noData))
                    return
                }

        
        let body = updateAdminBody(id: id, name: name, isAdmin: true, password: password)

        let request = createRequest(url: url, body: body, httpMethod: PUT, auth: true, token: token)
        

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                completion(.failure(.decodingError))
            }
            
            completion(.success(()))
            
        }.resume()
        
        
    }
    
    func getUserData(id: String, token: String, completion: @escaping (Result<UserProfile, NetworkError>) -> Void){

        guard let url = URL(string: URLCC1 + USERS_ + id) else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.addValue(BEARER_ + "\(token)",  forHTTPHeaderField: AUTHORIZATION)
        request.setValue(APPLICATION_JSON, forHTTPHeaderField: CONTENT_TYPE)

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
        
        
        guard let url = URL(string: URLCC1 + USERS_ + id + FUNDING) else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        
       guard let token = getRefreshToken() else {
                    return
                }

        
        let body = newFunding(amount: amount)

        let request = createRequest(url: url, body: body, httpMethod: POST, auth: true, token: token)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                print(httpResponse?.statusCode as Any)
                //completion(.failure(.decodingError))
            }
            
            //completion(.success(()))
            
        }.resume()
    }
    
    func purchaseItem(id: String, itemId: String, amount: Int, completion: @escaping (Result<Void, NetworkError>) -> Void)
    {
        
        
        guard let url = URL(string: URLCC1 + USERS_ + id + PURCHASES) else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        
       guard let token = getRefreshToken() else {
                    completion(.failure(.noData))
                    return
                }

        
        let body = pruchaseItemBody(itemId: itemId, amount: amount)

        let request = createRequest(url: url, body: body, httpMethod: POST, auth: true, token: token)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                print(httpResponse?.statusCode as Any)
                completion(.failure(.noData))
                return
            }
            
            completion(.success(()))
        }.resume()
    }
    
    func refundPurchase(id: String){
        
        guard let url = URL(string: URLCC1 + USERS_ + id + PURCHASES + REFUND) else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        
       guard let token = getRefreshToken() else {
                    //completion(.failure(.noData))
                    return
                }
   
        let body = nilBody()
        
        let request = createRequest(url: url, body: body, httpMethod: POST, auth: true, token: token, hasBody: false )
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                print(httpResponse?.statusCode as Any)
                //completion(.failure(.decodingError))
            }
            
            //completion(.success(()))
            
        }.resume()
    }
    
    func sendMoney(id: String, recipientId: String, amount: Double){
        
        
        guard let url = URL(string: URLCC1 + USERS_ + id + SEND_MONEY) else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        
       guard let token = getRefreshToken() else {
                    //completion(.failure(.noData))
                    return
                }

        
        let body = sendMoneyBody(amount: amount, recipientId: recipientId)

        let request = createRequest(url: url, body: body, httpMethod: POST, auth: true, token: token)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode != 200){
                print(httpResponse?.statusCode as Any)
                //completion(.failure(.decodingError))
            }
            
            //completion(.success(()))
            
        }.resume()
    }
    
    func getTransactions(id: String, completion:@escaping ([History]) -> ()) {
        guard let url = URL(string: URLCC1 + USERS_ + id + "/transactions") else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        guard let token = getRefreshToken() else {
            //completion(.failure(.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(BEARER_ + "\(token)",  forHTTPHeaderField: AUTHORIZATION)
        request.setValue(APPLICATION_JSON, forHTTPHeaderField: CONTENT_TYPE)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse?.statusCode as Any)
            
            let histories = try! JSONDecoder().decode([History].self, from: data!)
            
            DispatchQueue.main.async {
                completion(histories)
            }
            print(histories)
        }.resume()
    }
    
    func createAccountAdmin(id: String, name: String, isAdmin: Bool, password: String) {
        
        
        guard let url = URL(string: URLCC1 + USERS_ + "admin") else {
            print(ERROR_MESSAGE_BAD_URL)
            return
        }
        
        
        let token = getRefreshToken()!
        
        
        let body = updateAdminBody(id: id, name: name, isAdmin: isAdmin, password: password)
        
        let request = createRequest(url: url, body: body, httpMethod: POST, auth: true, token: token)
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
                
            if(httpResponse?.statusCode == 409){
                print("This ID is already used!")
            }
        }.resume()
        
        
    }
}
