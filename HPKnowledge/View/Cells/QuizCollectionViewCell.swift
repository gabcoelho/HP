//
//  QuizCollectionViewCell.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 23/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol QuizCollectionViewCellDelegate {
    func updateSuccessRate()
    func shakeView()
}

class QuizCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet weak var rightAnswer: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var quizView: UIView!
    @IBOutlet weak var nice: UILabel!
    
    private let disposeBag = DisposeBag()
    var viewModel = QuizCollectionViewCellViewModel()
    var delegate: QuizCollectionViewCellDelegate?
    
    // MARK: - Setup Functions
    func configureCell(with quiz: Quiz) {
        viewModel.initialValues()
        question.text = quiz.question
        optionA.setTitle(quiz.options[0], for: .normal)
        optionB.setTitle(quiz.options[1], for: .normal)
        optionC.setTitle(quiz.options[2], for: .normal)
        optionD.setTitle(quiz.options[3], for: .normal)
        rightAnswer.text = quiz.rightAnswer
        questionImage.image = UIImage(named: quiz.imagem)
    }

    func setupButton() {
        optionA.accessibilityIdentifier = "OptionAButton"
        optionB.accessibilityIdentifier = "OptionBButton"
        optionC.accessibilityIdentifier = "OptionCButton"
        optionD.accessibilityIdentifier = "OptionDButton"
        optionA.layer.cornerRadius = 7
        optionB.layer.cornerRadius = 7
        optionC.layer.cornerRadius = 7
        optionD.layer.cornerRadius = 7
    }
}



// MARK: - Binding Functions
extension QuizCollectionViewCell {
    
    func bindAnswer() {
        viewModel.hideAnswer.asObservable()
            .bind(to: self.rightAnswer.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.hideNoice.asObservable()
            .bind(to: self.nice.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.noiceValue.asObservable()
            .subscribe(onNext: { (value) in
            self.nice.text = value.rawValue
        }).disposed(by: disposeBag)
        
    }
    
    func bindButtons() {
        setupButton()
        bindEnablingButtons()
        var receivedAnswer = false
        optionA.rx.controlEvent( .touchUpInside )
            .asDriver()
            .drive(onNext: { _ in
                guard let title = self.optionA.titleLabel else {
                    return
                }
                if !receivedAnswer {
                    receivedAnswer = true
                    self.viewModel.verifyAnswer(with: title.text, rightAnswer: self.rightAnswer.text, completion: { (isValid) in
                        if isValid {
                            self.delegate?.updateSuccessRate()
                            return
                        } else {
                            self.delegate?.shakeView()
                        }
                    })
                }
            }).disposed(by: disposeBag)
        
        optionB.rx.controlEvent( .touchUpInside )
            .asDriver()
            .drive(onNext: { _ in
                guard let title = self.optionB.titleLabel else {
                    return
                }
                if !receivedAnswer {
                    receivedAnswer = true
                    self.viewModel.verifyAnswer(with: title.text, rightAnswer: self.rightAnswer.text, completion: { (isValid) in
                        if isValid {
                            self.delegate?.updateSuccessRate()
                        } else {
                            self.delegate?.shakeView()
                        }
                    })
                }
            }).disposed(by: disposeBag)
        
        optionC.rx.controlEvent( .touchUpInside )
            .asDriver()
            .drive(onNext: { _ in
                guard let title = self.optionC.titleLabel else {
                    return
                }
                if !receivedAnswer {
                    receivedAnswer = true
                    self.viewModel.verifyAnswer(with: title.text, rightAnswer: self.rightAnswer.text, completion: { (isValid) in
                        if isValid {
                            self.delegate?.updateSuccessRate()
                        } else {
                            self.delegate?.shakeView()
                        }
                    })
                }
            }).disposed(by: disposeBag)
        
        optionD.rx.controlEvent( .touchUpInside )
            .asDriver()
            .drive(onNext: { _ in
                guard let title = self.optionD.titleLabel else {
                    return
                }
                if !receivedAnswer {
                    receivedAnswer = true
                    self.viewModel.verifyAnswer(with: title.text, rightAnswer: self.rightAnswer.text, completion: { (isValid) in
                        if isValid {
                            self.delegate?.updateSuccessRate()
                        } else {
                            self.delegate?.shakeView()
                        }
                    })
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindEnablingButtons() {
        viewModel.optionAButtonEnabled.asObservable()
            .bind(to: self.optionA.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.optionBButtonEnabled.asObservable()
            .bind(to: self.optionB.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.optionCButtonEnabled.asObservable()
            .bind(to: self.optionC.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.optionDButtonEnabled.asObservable()
            .bind(to: self.optionD.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}


