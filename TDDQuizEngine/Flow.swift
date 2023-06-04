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

    func routeTo(result: [String: String])
}

class Flow {

    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]

    init(router: Router, questions: [String]) {
        self.router = router
        self.questions = questions
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(
                question: firstQuestion,
                answerCallback: routeToNext(from: firstQuestion)
            )
        } else {
            router.routeTo(result: result)
        }
    }

    private func routeToNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] answer in
            self?.storeResultAndRouteNext(currentQuestion: question, currentAnswer: answer)
        }
    }

    private func storeResultAndRouteNext(currentQuestion: String, currentAnswer: String) {
        if let currentQuestionIndex = questions.firstIndex(of: currentQuestion) {
            result[currentQuestion] = currentAnswer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(
                    question: nextQuestion,
                    answerCallback: routeToNext(from: nextQuestion)
                )
            } else {
                router.routeTo(result: result)
            }
        }
    }
}
