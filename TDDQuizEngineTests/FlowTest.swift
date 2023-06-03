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

        XCTAssertTrue(router.routedQuestions.isEmpty)
    }

    // redundant against next test since array of `routedQuestions`
    // was introduced.
//    func test_start_with1Question_routesToQuestion() {
        /*
        let router = RouterSpy()

        // 'sut' stands for "System under Test"
        let sut = Flow(router: router, questions: ["Q1"])
        sut.start()

//        XCTAssertEqual(router.routedQuestionsCount, 1)
        XCTAssertEqual(router.routedQuestions, ["Q1"])
        */
//    }

    func test_start_with1Question_routesToCorrectQuestion() {

        let router = RouterSpy()

        // 'sut' stands for "System under Test"
        let sut = Flow(router: router, questions: ["Q1"])
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_with2Questions_routesToFirstQuestion() {

        let router = RouterSpy()

        // 'sut' stands for "System under Test"
        let sut = Flow(router: router, questions: ["Q1", "Q2"])
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startTwice_with2Questions_routesToFirstQuestionTwice() {

        let router = RouterSpy()

        // 'sut' stands for "System under Test"
        let sut = Flow(router: router, questions: ["Q1", "Q2"])
        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }

    func test_startAndAnswerFirstQuestion_with2Questions_routesToSecondQuestion() {

        let router = RouterSpy()

        // 'sut' stands for "System under Test"
        let sut = Flow(router: router, questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }

    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: (String) -> Void = { _ in }

        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
