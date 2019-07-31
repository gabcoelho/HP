//
//  QuizViewModel.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 14/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum Value: String {
    case noice = "NOICE"
    case wrong = "Ooops, wrong. Go to the next question."
}

class QuizCollectionViewCellViewModel {
    
    // MARK: - Rx Variables
    private(set) var hideAnswer = BehaviorRelay<Bool>(value: true)
    private(set) var noiceValue = BehaviorRelay<Value>(value: .noice)
    private(set) var hideNoice = BehaviorRelay<Bool>(value: true)
    private(set) var optionAButtonEnabled = BehaviorSubject<Bool>(value: true)
    private(set) var optionBButtonEnabled = BehaviorSubject<Bool>(value: true)
    private(set) var optionCButtonEnabled = BehaviorSubject<Bool>(value: true)
    private(set) var optionDButtonEnabled = BehaviorSubject<Bool>(value: true)


    private var disposeBag = DisposeBag()
    
    // MARK: - Initial Values Setup
    func initialValues() {
        hideAnswer.accept(true)
        hideNoice.accept(true)
        optionAButtonEnabled.onNext(true)
        optionBButtonEnabled.onNext(true)
        optionCButtonEnabled.onNext(true)
        optionDButtonEnabled.onNext(true)
    }
    
    // MARK: - Verify user answer function
    func verifyAnswer(with option: String?, rightAnswer: String?, completion: (_ receivedAnswer: Bool) -> ()) {
        disableOptionButtons()
        guard let option = option, let rightAnswer = rightAnswer  else {
            hideAnswer.accept(true)
            hideNoice.accept(true)
            completion(false)
            return
        }
        if option == rightAnswer {
            hideAnswer.accept(false)
            hideNoice.accept(false)
            noiceValue.accept(.noice)
            completion(true)
        } else {
            hideAnswer.accept(true)
            hideNoice.accept(false)
            noiceValue.accept(.wrong)
            completion(false)
        }
    }
    
    func disableOptionButtons() {
        optionAButtonEnabled.onNext(false)
        optionBButtonEnabled.onNext(false)
        optionCButtonEnabled.onNext(false)
        optionDButtonEnabled.onNext(false)
    }
    

}
