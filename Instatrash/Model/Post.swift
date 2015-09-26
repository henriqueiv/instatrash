//
//  Post.swift
//  Instatrash
//
//  Created by Henrique Valcanaia on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import Foundation
import Parse

class Post: PFObject, PFSubclassing {
    
    @NSManaged var user:PFUser!
    @NSManaged var text:String!
    @NSManaged var image:PFFile!
    
    static func parseClassName() -> String {
        return "Post"
    }
}
