//
//  CoursesViewController.swift
//  test
//
//  Created by Максим Окунеев on 12/20/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            fetchData()
        }
    func fetchData() {
        
        //let jsonURLString =  "https://swiftbook.ru//wp-content/uploads/api/api_course"
        //let jsonURLString =  "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        let jsonURLString =  "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
        
        guard let url = URL(string: jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, errror) in
           
            guard let data = data else { return }
        
            do{
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print("\(websiteDescription.websiteName ?? "") \(websiteDescription.websiteDescription ?? "")")
            } catch let error {
                print("Error serrialization Jason", error)
            }
    }.resume()
}
}

    
    // MARK: Table View Data Source

    extension CoursesViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
            
            return cell
        }
    }

    // MARK: Table View Delegate

    extension CoursesViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    }

