//
//  History+CoreDataProperties.swift
//  GameProject
//
//  Created by HuynhLQ on 06/10/2022.
//
//

import Foundation
import CoreData

extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var scores: Double
    @NSManaged public var name: String?

    static func insertNewContact(
        name: String,
        scores: Double
        ) -> History? {
        let history = NSEntityDescription.insertNewObject(
            forEntityName: "History",
            into: AppDelegate.managedObjectContext!) as? History
        history?.name = name
        history?.scores = scores
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("insert fail: \(nserror)")
            return nil
        }
        print("insert successful")
        return history
    }

    static func getAllHistory() -> [History] {
        var result = [History]()
        do {
            result = try AppDelegate.managedObjectContext?.fetch(History.fetchRequest()) as? [History] ?? []
        } catch {
            return result
        }
        return result
    }
}

extension History: Identifiable {

}
