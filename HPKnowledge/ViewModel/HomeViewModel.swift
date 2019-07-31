//
//  HomeViewModel.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 14/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    private(set) var quizData = BehaviorRelay<[Quiz]>(value: [])
    private(set) var numberOfPages = BehaviorSubject<Int>(value: 0)
    private(set) var successRate = BehaviorRelay<Float>(value: 0)
    private(set) var nextQuestionButtonIsHidden = BehaviorRelay<Bool>(value: false)
    private(set) var resultsButtonIsHidden = BehaviorRelay<Bool>(value: true)
    private(set) var currentQuestion = BehaviorRelay<Int>(value: 0)
    private(set) var nextQuestion = 0
    
    private(set) var maximumProgress = Float(0)
    let disposeBag = DisposeBag()
    
    init() {
        fetchQuizData()
    }
    
    // MARK: - Service
    private func fetchQuizData() {
        NetworkDispatcher.shared.quizData().subscribe(onNext: { (quiz) in
            guard let quiz = quiz else {
                return
            }
            self.quizData.accept(quiz)
            self.numberOfPages.onNext(self.quizData.value.count)
            self.maximumProgress = Float(self.quizData.value.count)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Update Question for Scroll to Item, wouldn't work with RX bind
    func updateQuestion() {
        if nextQuestion < quizData.value.count-1 {
            nextQuestion = nextQuestion + 1
        }
    }
    
    func updateProgressSlider() {
        successRate.accept(successRate.value + Float(1))
    }
    
    func updateCurrentQuestionIndex(with index: Int) {
        currentQuestion.accept(index)
    }
    
    func nextButtonQuestion() {
        currentQuestion.asObservable()
            .subscribe(onNext: { (index) in
                self.nextQuestionButtonIsHidden.accept(index < self.quizData.value.count-1 ? false : true)
                self.resultsButtonIsHidden.accept(index < self.quizData.value.count-1 ? true : false)
            }).disposed(by: disposeBag)
    }
    
    func resetData() {
        nextQuestion = 0
        currentQuestion.accept(nextQuestion)
        successRate.accept(Float(0))
    }
}


extension HomeViewModel {
    func dataForEndingViewController() -> String {
        let value = successRate.value
        if value <= Float(maximumProgress * 0.25) {
            return Results.disappointed
        } else if value > Float(maximumProgress * 0.25) && value <= Float(maximumProgress * 0.50) {
            return Results.meh
        } else if value > Float(maximumProgress * 0.50) && value <= Float(maximumProgress * 0.75) {
            return Results.exceed
        } else {
            return Results.owl
        }
    }
}

private extension HomeViewModel {
    struct Results {
        static let ops = "We marauders are sorry to inform that we lost track of you horrible results, please try again."
        static let disappointed = "Wow, an T for you, because you sucked. Moony is disappointed."
        static let meh = "Meh, you get an A for that"
        static let exceed = "Ok, you exceed our expectations. Prongs, lets give an E to the kid."
        static let owl = "FINALLY! An O! Not exactly newt level but congrats!"
    }
}
