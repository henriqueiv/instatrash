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

enum PostType: Int {
    case Normal
}

class TimelinePresenter {
    
    var postList: [PostType:[AnyObject]] = [PostType:[AnyObject]]()
    var delegate: TimelinePresenterDelegate?
    
    // MARK: Public
    
    func totalNumberOfPosts() -> Int {
        var total = 0
        for (_,postsOfType) in postList {
            total += postsOfType.count
        }
        return total
    }
    
    func loadPosts() {
        postList[PostType.Normal] = [AnyObject]()
        notifyDelegateFinishedLoadingData()
    }
    
    func numberOfPostTypes() -> Int {
        return postList.count
    }
    
    func numberOfPostsOfType(type: PostType) -> Int {
        if let postsOfType = postList[type] {
            return postsOfType.count
        }
        return 0
    }
    
    func post(type: PostType, index: Int) -> AnyObject? {
        if let postsOfType = postList[type] {
            return postsOfType[index]
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
