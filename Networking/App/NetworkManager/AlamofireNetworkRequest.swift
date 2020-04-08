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
    
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
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
    
    static func downloadImage(url: String, completion: @escaping(_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else { return }
        AF.request(url).responseData { (responceData)  in
            switch responceData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
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
    
    static func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else { return }
        AF.request(url).validate().downloadProgress { (progress) in
            print("TotalUnitCount: ", progress.totalUnitCount)
            print("CompletedUnitCount: ", progress.completedUnitCount)
            print("FractionCompleted: ", progress.fractionCompleted)
            print("LocalizedDescription: ", progress.localizedDescription ?? "")
            print("------------------------------------------")
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
        }.response { (responce) in
            guard let data = responce.data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    static func postRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        guard let url = URL(string: url) else { return }
        let userData: [String: Any] = ["name": "Network Request",
                                       "link": "http://swiftbook.ru/contents/oour-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
                                       "numberOfLessons": "18",
                                       "numberOfTests": "10"]
        AF.request(url, method: .post, parameters: userData).responseJSON { (responceJSON) in
            guard let statusCode = responceJSON.response?.statusCode else { return }
            print("ststusCode", statusCode)
            
            switch responceJSON.result {
            case.success(let value):
                print(value)
                guard let jsonObject = value as? [String: Any],
                    let course = Course(json: jsonObject)
                    else { return }
                var courses = [Course]()
                courses.append(course)
                completion(courses)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func putRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        guard let url = URL(string: url) else { return }
        let userData: [String: Any] = ["name": "Network Request",
                                       "link": "http://swiftbook.ru/contents/oour-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
                                       "numberOfLessons": "18",
                                       "numberOfTests": "10"]
        AF.request(url, method: .put, parameters: userData).responseJSON { (responceJSON) in
            guard let statusCode = responceJSON.response?.statusCode else { return }
            print("ststusCode", statusCode)
            
            switch responceJSON.result {
            case.success(let value):
                print(value)
                guard let jsonObject = value as? [String: Any],
                    let course = Course(json: jsonObject)
                    else { return }
                var courses = [Course]()
                courses.append(course)
                completion(courses)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
