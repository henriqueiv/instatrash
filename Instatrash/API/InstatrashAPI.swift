//
//  InstatrashAPI.swift
//  Instatrash
//
//  Created by Henrique Valcanaia on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import Parse
import UIKit

class InstatrashAPI {
    
    static let sharedInstance = InstatrashAPI()
    private var indexLastDownloadedPost = 0
    
    func createPost(post:Post, withBlock block:PFBooleanResultBlock){
        post.saveInBackgroundWithBlock { (sucSaveModel:Bool, errorSaveModel:NSError?) -> Void in
            block(sucSaveModel, errorSaveModel)
        }
    }
    
    func likePost(post:Post, withBlock block:PFBooleanResultBlock){
        let like = Like()
        like.user = PFUser.currentUser()
        like.post = post
        like.saveInBackgroundWithBlock { (suc: Bool, error: NSError?) -> Void in
            block(suc, error)
        }
    }
    
    let InstrashErrorDomain = "io.instrash"
    enum InstrashError: Int{
        case ExceededLimitOfPostsToSkip, ExceededLimitOfPostsToDownload, ConvertToArrayOfPosts
    }
    
    typealias PostsReturnBlock = (([Post]?, NSError?) -> ())
    func loadPosts(numberOfPosts:Int = 10, withBlock block: PostsReturnBlock){
        let limitOfPostsToDownload = 1000
        if numberOfPosts > limitOfPostsToDownload{
            block(nil, NSError(domain: InstrashErrorDomain, code: InstrashError.ExceededLimitOfPostsToDownload.rawValue, userInfo: [NSLocalizedDescriptionKey : "Number of posts to download cannot be greater than \(limitOfPostsToDownload)"]))
        }
        
        let limitOfPostsToSkip = 10000
        if indexLastDownloadedPost >= limitOfPostsToSkip{
            block(nil, NSError(domain: InstrashErrorDomain, code: InstrashError.ExceededLimitOfPostsToDownload.rawValue, userInfo: [NSLocalizedDescriptionKey : "Number of posts to skip for download cannot be greater than \(limitOfPostsToSkip)"]))
        }
        
        if let query = Post.query(){
            query.orderByAscending("createdAt")
            query.limit = numberOfPosts
            query.skip = indexLastDownloadedPost
            query.findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, error:NSError?) -> Void in
                if error == nil{
                    if let posts = objects as? [Post]{
                        self.indexLastDownloadedPost += posts.count
                        block(posts, error)
                    }else{
                        block(nil, NSError(domain: self.InstrashErrorDomain, code: InstrashError.ConvertToArrayOfPosts.rawValue, userInfo: [NSLocalizedDescriptionKey : "Error converting retrieved objects to list of Post"]))
                    }
                }else{
                    block(nil, error)
                }
            })
        }
    }
    
    func numberOfLikesForPost(post:Post, withBlock block:PFIntegerResultBlock){
        if let query = Like.query(){
            query.whereKey("post", equalTo: post)
            query.countObjectsInBackgroundWithBlock({ (val:Int32, error:NSError?) -> Void in
                block(val, error)
            })
        }
    }
    
}
