//
//  TimelinePresenter.swift
//  Instatrash
//
//  Created by William Hass on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import Foundation

protocol TimelinePresenterDelegate {
    func presenterFinishedLoadingData(numberOfPosts: Int)
}

class TimelinePresenter {
    
    var usersPost: [Int:[AnyObject]] = [Int:[AnyObject]]()
    var delegate: TimelinePresenterDelegate?
    
    // MARK: Public
    
    func totalNumberOfPosts() -> Int {
        return usersPost.count
    }
    
    func loadPosts() {
        
        usersPost[0] = ["Post"]
        usersPost[1] = ["Post"]
        usersPost[2] = ["Post"]
        usersPost[3] = ["Post"]
        usersPost[4] = ["Post"]
        usersPost[5] = ["Post"]
        usersPost[6] = ["Post"]
        usersPost[7] = ["Post"]
        
        notifyDelegateFinishedLoadingData()
    }
    
    func numberOfUsers() -> Int {
        return usersPost.count
    }
    
    func numberOfPostsOfUser(userIndex: Int) -> Int {
        if let posts = usersPost[userIndex] {
            return posts.count
        }
        return 0
    }
    
    func post(userIndex: Int, index: Int) -> AnyObject? {
        if let posts = usersPost[userIndex] {
            return posts[index]
        }
        return nil
    }
    
    // MARK: Delegate Methods
    
    func notifyDelegateFinishedLoadingData() {
        if let delegate = self.delegate {
            delegate.presenterFinishedLoadingData(totalNumberOfPosts())
        }
    }
}
