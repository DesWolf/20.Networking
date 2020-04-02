//
//  AlamofireNetworkRequest.swift
//  test
//
//  Created by Максим Окунеев on 4/1/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        
        AF.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                var courses = [Course]()
                courses = Course.getArray(from: value)!
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responceData(url: String) {
        
        AF.request(url).responseData { (responceData) in
            switch responceData.result {
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responceString(url: String) {
        AF.request(url).responseString { (responceString) in
            switch responceString.result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responce(url: String) {
        AF.request(url).response { (responce) in
            guard
                let data = responce.data  ,
                let string = String(data:data, encoding: .utf8)
                else { return }
            print(string)
        }
    }
}
