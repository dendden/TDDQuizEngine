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

    typealias AnswerCallback = (String) -> Void

    func routeTo(
        question: String,
        answerCallback: @escaping AnswerCallback
    )
}

class Flow {

    private let router: Router
    private let questions: [String]

    init(router: Router, questions: [String]) {
        self.router = router
        self.questions = questions
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion) { [weak self] _ in
                self?.routeToNext(from: firstQuestion)
            }
        }
    }

    private func routeToNext(from question: String) {
        if
            let currentQuestionIndex = questions.firstIndex(of: question),
            currentQuestionIndex + 1 < questions.count {
            let nextQuestion = questions[currentQuestionIndex+1]
            self.router.routeTo(question: nextQuestion) { [weak self] _ in
                self?.routeToNext(from: nextQuestion)
            }
        }
    }
}
