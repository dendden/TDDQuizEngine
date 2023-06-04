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

    let router = RouterSpy()

    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()

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
        makeSUT(questions: ["Q1"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_with2Questions_routesToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startTwice_with2Questions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }

    func test_startAndAnswerQuestions1and2_with3Questions_routesToQuestion3() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        // answer questions:
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }

    func test_startAndAnswerQuestion1_with1Question_doesNotRouteToNextQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        // answer question:
        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_withNoQuestions_routesToResult() {
        makeSUT(questions: []).start()

        XCTAssertEqual(router.routedResult, [:])
    }

    func test_start_with1Question_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()

        XCTAssertNil(router.routedResult)
    }

    func test_startAndAnswerQuestions1and2_with2Questions_routesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        // answer questions:
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResult!, ["Q1": "A1", "Q2": "A2"])
    }

    func test_startAndAnswerQuestion1_with2Questions_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        // answer questions:
        router.answerCallback("A1")

        XCTAssertNil(router.routedResult)
    }

    // MARK: - Helpers

    // 'sut' stands for "System under Test"
    func makeSUT(questions: [String]) -> Flow {
        Flow(router: router, questions: questions)
    }

    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: AnswerCallback = { _ in }
        var routedResult: [String: String]? = nil

        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }

        func routeTo(result: [String : String]) {
            routedResult = result
        }
    }
}
