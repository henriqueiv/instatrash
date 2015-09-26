//
//  TimelineViewController.swift
//  Instatrash
//
//  Created by William Hass on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TimelinePresenterDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyStateView: UIView!
    let CellReuseIdentifier = "Cell"
    var presenter: TimelinePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialState()
        setupTableView()
        setupPresenter()
    }
    
    // MARK: Private Methods
    
    func setupPresenter() {
        presenter = TimelinePresenter()
        presenter!.delegate = self
        presenter!.loadPosts()
    }
    
    // MARK: View Methods
    
    func setupInitialState() {
        emptyStateView.hidden = true
        tableView.hidden = false
    }
    
    func setupTableView() {
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellReuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    func refreshViewState() {
        if let presenter = self.presenter {
            if presenter.totalNumberOfPosts() > 0 {
                
                tableView.hidden = false
                emptyStateView.hidden = true
            } else {
                
                tableView.hidden = true
                emptyStateView.hidden = false
            }
        }
    }
    
    // MARK: IBActions
    
    @IBAction func reloadDataButtonTapped() {
        if let presenter = self.presenter {
            presenter.loadPosts()
        }
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let presenter = self.presenter {
            return presenter.numberOfPostTypes()
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let type = PostType(rawValue: section) {
            if let presenter = self.presenter {
                return presenter.numberOfPostsOfType(type)
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier)!
        
        return cell
    }
    
    // MARK: PostsPresenterDelegate
    func presenterFinishedLoadingData(numberOfPosts: Int) {
        refreshViewState()
    }
    
}
