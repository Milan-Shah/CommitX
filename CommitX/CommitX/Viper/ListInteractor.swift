//
//  ListInteractor.swift
//  CommitX
//
//  Created by Milan Shah on 1/31/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import Realm

class ListInteractor: ListPresenterToInteractorProtocol {
    
    var presenter: ListInteractorToPresenterProtocol?

    func fetchCommits() {
        
        if let savedCommits = self.retrieveSavedCommits() {
            print("Loading saved contacts from Realm")
            self.presenter?.fetchedCommitSuccess(savedCommits)
            return
        }
        
        let contactsQueue = DispatchQueue(label: "commits.get.request-queue", qos: .utility, attributes: [.concurrent])
        let mainQueue = DispatchQueue.main
        
        Alamofire.request(CoreAPIs.commits.getCommits.url).responseJSON(queue: contactsQueue, options: .mutableLeaves) { (response) in
            
            guard let data = response.data else {
                mainQueue.async {
                    // Going back on Main to update View
                    print("Bad response: \(String(describing: response))")
                    self.presenter?.fetchCommitsFailed()
                }
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                guard json is [AnyObject] else {
                    assert(false, "Failed to parse")
                    return
                }
                
                // Modeled [CommitsModel]
                let commits = try jsonDecoder.decode([CommitsModel].self, from: data)
                
                mainQueue.async {
                    print("Recieved all the commits. Persisting with Realm")
                    self.saveFetchedCommits(commits)
                    
                    if let savedCommits = self.retrieveSavedCommits() {
                        print("Loading saved commits from Realm")
                        self.presenter?.fetchedCommitSuccess(savedCommits)
                        return
                    }
                    
                }
                
            } catch let error {
                print(error.localizedDescription)
                mainQueue.async {
                    // Going back on Main to update View
                    print("Bad response: \(String(describing: response))")
                    self.presenter?.fetchCommitsFailed()
                }
            }
            
        }
        
    }
    
    
}

extension ListInteractor {
    
    func saveFetchedCommits(_ commits: [CommitsModel]) {
        
        let realm = try! Realm()
        
        for commit in commits {
            try! realm.write {
                realm.add(commit, update: true)
            }
        }
    }
    
    func retrieveSavedCommits() -> [CommitsModel]? {
        
        let realm = try! Realm()
        let savedCommits = realm.objects(CommitsModel.self)
        
        var commits: [CommitsModel] = []
        
        for commit in savedCommits {
            commits.append(commit)
        }
        
        if !commits.isEmpty {
            return commits
        }
        
        return nil
    }
    
}
