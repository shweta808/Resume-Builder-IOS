//
//  DatabaseService.swift
//  Resume Builder
//
//  Created by MyBook on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    let resumeData = Database.database().reference().child("Resume Data")
    //let resumeImages = Storage.storage().reference().child("Resume Images")
}
    

