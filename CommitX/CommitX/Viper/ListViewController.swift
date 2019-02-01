//
//  ListViewController.swift
//  CommitX
//
//  Created by Milan Shah on 1/31/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class ListViewController: UIViewController {

    @IBOutlet weak var commitsTableView: UITableView!
    var presenter: ListViewToPresenterProtocol?
    var commits: [CommitsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commitsTableView.delegate = self
        self.commitsTableView.dataSource = self
        self.commitsTableView.isHidden = true
        
        showProgressIndicator(view: self.view)
        self.navigationItem.title = "Commits List"
        presenter?.startFetchingCommits()
    }
}

extension ListViewController: ListPresenterToViewProtocol {
    
    func showCommits(_ commits: [CommitsModel]) {
        hideProgressIndicator(view: self.view)
        self.commitsTableView.isHidden = false
        self.commits = commits
        self.commitsTableView.reloadData()
    }
    
    func showError() {
        
        hideProgressIndicator(view: self.view)
        
        // Show error
        let errorAlert = UIAlertController(title: "Oops", message: "Something went wrong. Please see logs.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let totalCommits = commits?.count {
            return totalCommits
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitsCell", for: indexPath) as! CommitsCell
        
        cell.nameLabelView.layer.masksToBounds = true
        cell.nameLabelView.layer.cornerRadius = 5.0
        cell.nameLabelView.text = "Name"
        
        cell.dateLabelView.layer.masksToBounds = true
        cell.dateLabelView.layer.cornerRadius = 5.0
        cell.dateLabelView.text = "Date"
        
        cell.messageLabel.layer.masksToBounds = true
        cell.messageLabel.layer.cornerRadius = 5.0
        
        if let commitAtIndex = commits?[indexPath.row] {
            cell.dateLabel.text = commitAtIndex.date.getFormattedDateString()
            cell.nameLabel.text = commitAtIndex.name
            cell.messageTextView.text = commitAtIndex.message.removeSpaces()
        }
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        return cell
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedCommit = commits?[indexPath.row] {
            if let url = URL(string: selectedCommit.url),UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    */
}

class CommitsCell: UITableViewCell {

    @IBOutlet weak var dateLabelView: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabelView: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    
}
