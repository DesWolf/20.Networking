//
//  Course.swift
//  test
//
//  Created by Максим Окунеев on 12/20/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import Foundation

struct Course: Decodable {
    
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
    
}
