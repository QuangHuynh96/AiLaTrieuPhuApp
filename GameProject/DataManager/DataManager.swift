//
//  DataManager.swift
//  GameProject
//
//  Created by Nhất Minh on 03/10/2022.
//

import UIKit
import FirebaseFirestore
class DataManager {
    static let shared = DataManager()
    var collection: String?
    let fireStore = Firestore.firestore()
    let levelOne: String = "LevelOne"
    var results: [Result] = []
    func getDataAllLevelFirestore(collection: String, completion: @escaping() -> Void) {
        var results: [Result] = []
             fireStore.collection(collection).addSnapshotListener { snapshot, error in
                 guard let documents = snapshot?.documents,
                       error == nil else {
                     return
                 }
                 documents.forEach { document in
                     if let question = document["question"] as? String,
                        let correct = document["correct"] as? String,
                        let incorrect = document["incorrect"] as? [String] {
                         results.append(Result(
                            idDocument: document.documentID,
                            question: question,
                            correct: correct,
                            incorrect: incorrect
                         ))
                     }
                 }
                 self.results = results
                 completion()
             }
    }

    // Get DataRamdom and Shuffle return model AllAnswer
    func getDataRamdom(completion: @escaping (AllAnswer) -> Void) {
        let ramdomIndex = Int.random(in: 0..<results.count)
        let result = results[ramdomIndex]
        results.remove(at: ramdomIndex)
        var container: [String] = []
        container.append(result.correct)
        result.incorrect.forEach { string in
            container.append(string)
        }
        let answer = AllAnswer(question: result.question, correct: result.correct, answer: container.shuffled())
        completion(answer)
    }
}
