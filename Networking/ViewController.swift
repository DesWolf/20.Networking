//
//  MainViewController.swift
//  test
//
//  Created by Максим Окунеев on 12/20/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func getRequest(_ sender: Any) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, responce, error) in
         
            guard let responce = responce, let data = data else { return }
           // print(responce)
           // print(data)
            do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
            } catch {
            print(error)
            }
            }.resume()
    }
    
    @IBAction func postRequest(_ sender: Any) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        let userdata = ["Course": "Networking", "Lessons": "GET and POST Request"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userdata, options: [])
            else { return }
    
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) {( data, response, error ) in
        
            guard let response = response, let data = data else { return }
            //print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
