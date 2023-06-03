//
//  FlowTest.swift
//  TDDQuizEngineTests
//
//  Created by Денис Трясунов on 03.06.2023.
//

import Foundation
import XCTest
@testable import TDDQuizEngine

class FlowTest: XCTestCase {

    func test_start_withNoQuestions_doesNotRouteToQuestion() {

        let router = RouterSpy()

        // 'sut' stands for "System under Test"
        let sut = Flow(router: router, questions: [])
        sut.start()

        XCTAssertEqual(router.routedQuestionsCount, 0)
    }

    func test_start_with1Question_routesToQuestion() {

        let router = RouterSpy()

        // 'sut' stands for "System under Test"
        let sut = Flow(router: router, questions: ["Q1"])
        sut.start()

        XCTAssertEqual(router.routedQuestionsCount, 1)
    }

    func test_start_with1Question_routesToCorrectQuestion() {

        let router = RouterSpy()

        // 'sut' stands for "System under Test"
        let sut = Flow(router: router, questions: ["Q1"])
        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }

    class RouterSpy: Router {
        var routedQuestionsCount: Int = 0
        var routedQuestion: String?

        func routeTo(question: String) {
            routedQuestion = question
            routedQuestionsCount += 1
        }
    }
}
