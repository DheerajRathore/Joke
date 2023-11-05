//
//  JokesListPresenter.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 31/10/23.
//

import Foundation


protocol JokesListPresenterProtocol: AnyObject {
    func refreshList()
    func showError(withErrorMessage: String)
}


protocol JokesListPresenterInputProtocol: AnyObject {
    func viewDidLoad()
}

final class JokesListPresenter {
    // MARK: PROPERTIES.
    private weak var view: JokesListPresenterProtocol?
    private(set) var model: JokeListModel
    var jokeList: [Joke] = []
    
    // MARK: METHODS.
    init(view: JokesListPresenterProtocol, model: JokeListModel){
        self.view = view
        self.model = model
    }
    
    private func saveJoke(message: String?) {
        guard let msg = message else {
            return
        }
        model.saveJoke(message: msg)
    }
}

extension JokesListPresenter{
    func fetchJoke() {
        // check for internet connection.
        if Reachability().isNetworkAvailable() == false {
            self.view?.showError(withErrorMessage: StringConstant.internetNotFound)
        }
        JokeListService().getJokesFromServer { [weak self] joke, httpResponse, apiError in
            //check for error.
            if  apiError != nil  {
                self?.view?.showError(withErrorMessage: apiError?.customDescription ?? StringConstant.someThingWentWrong)
                return
            }
            
            guard let self = self else {
                return
            }
            
            guard let meesage = joke else {
                return
            }
            
            // create instance from data
            let message = String(decoding: meesage, as: UTF8.self)
            
            // save current fetch joke to Core data.
            self.saveJoke(message: message)
            
            // create joke object to add in list.
            let tempJoke = Joke(entity: Joke.entity(), insertInto: nil)
            tempJoke.message = message
            //add latest jokes to first position.
            self.jokeList.insert(tempJoke, at: 0)
            
            // delete last record if list is having more than 10 objects.
            if self.jokeList.count > 10 {
                self.jokeList.removeLast()
            }
            
            self.view?.refreshList()
        }
    }
}

extension JokesListPresenter: JokesListPresenterInputProtocol {
    func viewDidLoad() {
        // fetch previously save jokes from core data, when view is loading.
        model.fetchAllJokes { [weak self] list in
            guard let self =  self else {
                return
            }
            self.jokeList = list ?? []
            self.view?.refreshList()
        }
        
        // fetch the list from the server.
        self.fetchJoke()
    }
}
