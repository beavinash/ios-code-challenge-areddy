//
//  DentalHygiene.swift
//  DentalHygieneReport
//
//  Created by Avinash Reddy on 3/1/20.
//  Copyright © 2020 Avinash Reddy. All rights reserved.
//

import Foundation

struct DentalHygiene: Codable {
    let timestamp: Int
    let numberOfPeople: Int
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "t"
        case numberOfPeople = "y"
    }
}
