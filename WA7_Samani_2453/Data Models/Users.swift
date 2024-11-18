//
//  Users.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import Foundation

struct Users: Codable{
    var name:String?
    var email:String?
    var token:String?
    var auth:Bool?
    
    init(name: String? = nil, email: String? = nil, token: String? = nil, auth: Bool? = nil) {
        self.name = name
        self.email = email
        self.token = token
        self.auth = auth
    }
    
}
