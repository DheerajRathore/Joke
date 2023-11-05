//
//  Joke+CoreDataClass.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 05/11/23.
//
//

import Foundation
import CoreData

@objc(Joke)
public class Joke: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        createdAt = Date()
    }
}
