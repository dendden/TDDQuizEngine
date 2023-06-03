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

    func routeTo(
        question: String,
        answerCallback: @escaping (String) -> Void
    )
}

class Flow {

    let router: Router
    let questions: [String]

    init(router: Router, questions: [String]) {
        self.router = router
        self.questions = questions
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(
                question: firstQuestion
            ) { [weak self] _ in
                guard let self else { return }
                let firstQuestionIndex = self.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = self.questions[firstQuestionIndex+1]
                self.router.routeTo(
                    question: nextQuestion
                ) { _ in }
            }
        }
//        questions.forEach {
//            router.routeTo(question: $0)
//        }
    }
}
