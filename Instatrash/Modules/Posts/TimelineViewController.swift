//
//  TimelineViewController.swift
//  Instatrash
//
//  Created by William Hass on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyStateView: UIView!
    let CellReuseIdentifier = "PostTableViewCell"
    let HeaderReuseIdentifier = "PostTableViewCell"
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
        tableView.registerNib(UINib(nibName: String(PostTableViewCell), bundle: nil), forCellReuseIdentifier: CellReuseIdentifier)
        tableView.registerNib(UINib(nibName: String(TimelineTableSectionHeader), bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderReuseIdentifier)
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
    
}

extension TimelineViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let presenter = self.presenter {
            return presenter.numberOfUsers()
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let presenter = self.presenter {
            return presenter.numberOfPostsOfUser(section)
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier)!
        
        return cell
    }
    
}

extension TimelineViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderReuseIdentifier) as! TimelineTableSectionHeader
        
        return header
        
    }
    
}

extension TimelineViewController : TimelinePresenterDelegate {
    
    func presenterFinishedLoadingData(numberOfPosts: Int) {
        refreshViewState()
    }
    
}