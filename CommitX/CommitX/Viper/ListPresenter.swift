//
//  ListPresenter.swift
//  CommitX
//
//  Created by Milan Shah on 1/31/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ListPresenter: ListViewToPresenterProtocol {

    var view: ListPresenterToViewProtocol?
    var interactor: ListPresenterToInteractorProtocol?
    var router: ListPresenterToRouterProtocol?
    var dataManager: ListInteractorToDataManagerProtocol?
    
    func startFetchingCommits() {
        interactor?.fetchCommits()
    }
}

extension ListPresenter: ListInteractorToPresenterProtocol {
    
    func fetchedCommitSuccess(_ commits: [CommitsModel]) {
        view?.showCommits(commits)
    }
    
    func fetchCommitsFailed() {
        view?.showError()
    }
    
}
