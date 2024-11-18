//
//  Notes.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import Foundation

struct Note: Codable{
    let _id:String
    let text: String
}

struct Notes: Codable{
    let notes: [Note]
}
