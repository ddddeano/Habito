//
//  Challenge.swift
//  Habito
//
//  Created by Daniel Watson on 20/01/2021.
//

import Foundation


struct Challenge: Codable {
    let exersize: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
    
}
