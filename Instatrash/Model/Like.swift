//
//  Like.swift
//  Instatrash
//
//  Created by Henrique Valcanaia on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import Foundation
import Parse

class Like: PFObject, PFSubclassing {
    
    @NSManaged var user:PFUser!
    @NSManaged var post:Post!
    
    static func parseClassName() -> String {
        return "Like"
    }

}
