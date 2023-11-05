//
//  JokeListModel.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 04/11/23.
//

import Foundation
import CoreData

// protocol for handling the data base task.
protocol JokeListModelProtocol {
    func fetchAllJokes(completion: @escaping ([Joke]?) -> ())
    func saveJoke(message: String)
}

final class JokeListModel: JokeListModelProtocol {
    // MARK: PROPERTIES.
    private let moContext: NSManagedObjectContext
    init(moContext: NSManagedObjectContext) {
        self.moContext = moContext
    }

    // MARK: JokeListModelProtocol Definition.
    func fetchAllJokes(completion: @escaping ([Joke]?) -> ()) {
        let request = NSFetchRequest<Joke>(entityName: "Joke")
        // fetch upto 10 jokes only from the core data.
        request.fetchLimit = 10
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Joke.createdAt, ascending: false)
        ]
    
        if let jokes = try? moContext.fetch(request) {
            completion(jokes)
        } else {
            completion(nil)
        }
    }

    func saveJoke(message: String) {
        let joke = NSEntityDescription.insertNewObject(forEntityName: "Joke", into: moContext) as! Joke
        joke.message = message

        if moContext.hasChanges {
            do {
                try moContext.save()
            } catch let error as NSError {
                print("Core Data Error: \(error), \(error.userInfo)")
            }
        }
    }
}
