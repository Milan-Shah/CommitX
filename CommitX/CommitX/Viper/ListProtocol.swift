//
//  ListProtocol.swift
//  CommitX
//
//  Created by Milan Shah on 1/31/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import RealmSwift

protocol ListViewToPresenterProtocol: class {
    
    var view: ListPresenterToViewProtocol? { get set }
    var interactor: ListPresenterToInteractorProtocol? { get set }
    var router: ListPresenterToRouterProtocol? { get set }
    func startFetchingCommits()
    
}

protocol ListPresenterToViewProtocol: class {
    func showCommits(_ commits: [CommitsModel])
    func showError()
}

protocol ListPresenterToRouterProtocol: class {
    static func createModule()-> ListViewController
}

protocol ListPresenterToInteractorProtocol: class {
    var presenter:ListInteractorToPresenterProtocol? { get set }
    var dataManager: ListInteractorToDataManagerProtocol? { get set }
    func fetchCommits()
}

protocol ListInteractorToPresenterProtocol {
    func fetchedCommitSuccess(_ commits: [CommitsModel])
    func fetchCommitsFailed()
}

protocol ListInteractorToDataManagerProtocol {
    func retrieveSavedCommits() -> [CommitsModel]?
    func saveFetchedContacts(commits: [CommitsModel])
}
