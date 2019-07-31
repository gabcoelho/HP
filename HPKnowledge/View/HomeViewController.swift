//
//  HomeViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 14/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


protocol HomeViewControllerDelegate {
    func toggleLeftSideMenu()
}

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var homeViewModel = HomeViewModel()
    private var quizCellViewModel = QuizCollectionViewCellViewModel()
    var delegate: HomeViewControllerDelegate?
    
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var leftSideMenu: UIBarButtonItem!
    @IBOutlet weak var quizCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupPlayAgainReload()
        quizCollectionView.reloadData()
        nextQuestionButton.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let sliderImage = UIImage(named: "circle")
        leftSideMenu.accessibilityIdentifier = "menu"
        quizCollectionView.accessibilityIdentifier = "QuizCollection"
        nextQuestionButton.accessibilityIdentifier = "NextButton"
        resultsButton.accessibilityIdentifier = "ResultsButton"
        progressSlider.setThumbImage(sliderImage, for: .normal)
        progressSlider.maximumValue = homeViewModel.maximumProgress
        quizCollectionView.decelerationRate = .init(rawValue: 0.3)
        quizCollectionView.isScrollEnabled = false
        nextQuestionButton.layer.cornerRadius = 10
        resultsButton.layer.cornerRadius = 10
        setGradient()
        homeViewModel.nextButtonQuestion()
        bindButton()
        bindCollectionView()
        bindSlider()
        bindPageControl()
    }
    
    func setupPlayAgainReload() {
        homeViewModel.resetData()
        quizCollectionView.scrollToItem(at: IndexPath(row: homeViewModel.nextQuestion, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    private func setGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = gradientView.layer.frame
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - EndingViewController Delegate
extension HomeViewController: EndingViewControllerDelegate {
    func textForEndingViewController() -> String {
        return homeViewModel.dataForEndingViewController()
    }
}

// MARK: - QuizCell Delegate
extension HomeViewController: QuizCollectionViewCellDelegate {
    func updateSuccessRate() {
        homeViewModel.updateProgressSlider()
        showNextQuestionButton()
    }
    
    func shakeView() {
        gradientView.shake(count: 3, for: 0.2, withTranslation: 5)
        showNextQuestionButton()
    }
}

// MARK: - Binding
extension HomeViewController {
    private func showNextQuestionButton() {
        nextQuestionButton.alpha = 0
        nextQuestionButton.isHidden = false
        UIView.animate(withDuration: 1.2) {
            self.nextQuestionButton.alpha = 1
        }
    }
    
    private func bindSlider() {
        homeViewModel.successRate.asObservable()
            .bind(to: progressSlider.rx.value)
            .disposed(by: disposeBag)
    }

    private func bindButton() {
        leftSideMenu.rx.tap
            .subscribe { _ in
                self.delegate?.toggleLeftSideMenu()
            }.disposed(by: disposeBag)
        
        homeViewModel.nextQuestionButtonIsHidden.asObservable()
            .bind(to: nextQuestionButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        homeViewModel.resultsButtonIsHidden.asObservable()
            .bind(to: resultsButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        resultsButton.rx.controlEvent( .touchUpInside )
            .asDriver()
            .drive(onNext: { _ in
                let endingViewController = EndingViewController.init(nibName: "EndingView", bundle: nil)
                endingViewController.endingDelegate = self
                endingViewController.modalTransitionStyle = .crossDissolve
                self.addChild(endingViewController)
                endingViewController.view.frame = self.view.frame
                self.view.addSubview(endingViewController.view)
                endingViewController.didMove(toParent: self)
                //self.present(endingViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        nextQuestionButton.rx.controlEvent( .touchUpInside )
            .asDriver()
            .drive(onNext: { _ in
                self.homeViewModel.updateQuestion()
                self.homeViewModel.updateCurrentQuestionIndex(with: self.homeViewModel.nextQuestion)
                self.quizCollectionView.scrollToItem(at: IndexPath(row: self.homeViewModel.nextQuestion, section: 0), at: .centeredHorizontally, animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func bindPageControl() {
        homeViewModel.numberOfPages.asObservable()
            .bind(to: pageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
        
        homeViewModel.currentQuestion.asObservable()
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        homeViewModel.quizData.asObservable()
            .bind(to: quizCollectionView.rx.items(cellIdentifier: "QuizCollectionViewCell", cellType: QuizCollectionViewCell.self)) {
                row, quiz, cell in
                cell.delegate = self
                cell.bindButtons()
                cell.bindAnswer()
                cell.configureCell(with: quiz)
            }.disposed(by: disposeBag)
    }
}


// MARK: - Collection View Delegate
extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pointInView = view.convert(self.view.center, to: self.quizCollectionView)
        guard let indexPath = quizCollectionView.indexPathForItem(at: pointInView) else {
            return
        }
        homeViewModel.updateCurrentQuestionIndex(with: indexPath.row)
    }
}


// MARK: - Shaking view function
extension UIView {
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-translation), y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(translation), y: self.center.y))
        layer.add(animation, forKey: "shake")
    }
}
