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
    
    private var courses = [Course]()
    private var courseName: String?
    private var courseURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        
        let jsonURLString =  "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        guard let url = URL(string: jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, errror) in
            guard let data = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decoder.decode([Course].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("Error serrialization Jason", error)
            }
        }.resume()
    }
    
    
    private func configureCell(cell: TableViewCell, for indexpath: IndexPath) {
        
        let course = courses[indexpath.row]
        cell.courseNameLabel.text = course.name
        
        if let numberOfLessons = course.numberOfLessons {
            cell.numberOfLessons.text = "Number of lessons \(numberOfLessons)"
        }
        
        if let numberOfTests = course.numberOfTests {
            cell.numberOfTests.text = "Number of lessons \(numberOfTests)"
        }
        DispatchQueue.global().async {
            guard let imageURL = URL(string: course.imageUrl!) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                cell.courseImage.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let webViewController = segue.destination as! WebViewController
           webViewController.selectedCourse = courseName
           
           if let url = courseURL {
               webViewController.courseURL = url
           }
       }
}
// MARK: Table View Data Source

extension CoursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        configureCell(cell: cell, for: indexPath)
        return cell
    }
}

// MARK: Table View Delegate
extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let course = courses[indexPath.row]
        courseURL = course.link
        courseName = course.name
        performSegue(withIdentifier: "Description", sender: self)
    }
}

