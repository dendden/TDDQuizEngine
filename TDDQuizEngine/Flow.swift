//
//  Flow.swift
//  TDDQuizEngine
//
//  Created by Денис Трясунов on 03.06.2023.
//

import Foundation

// Can have various implementations, e.g. on iOS - a
// NavigationController or Storyboard Segue Coordinator
protocol Router {

    func routeTo(question: String)
}

class Flow {

    let router: Router
    let questions: [String]

    init(router: Router, questions: [String]) {
        self.router = router
        self.questions = questions
    }

    func start() {
        questions.forEach {
            router.routeTo(question: $0)
        }
    }
}
