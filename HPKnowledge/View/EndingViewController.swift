//
//  EndingViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 30/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import RxSwift

protocol EndingViewControllerDelegate {
    func textForEndingViewController() -> String
}

class EndingViewController: UIViewController {

    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    
    var endingDelegate: EndingViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.accessibilityIdentifier = "PlayAgainButton"
        bindButtons()
        setupResultsLabel()
    }
}

// MARK: - Binding
private extension EndingViewController {
    func setupResultsLabel() {
        resultsLabel.text = endingDelegate?.textForEndingViewController()
    }
    
    func bindButtons() {
        playAgainButton.layer.cornerRadius = 6
        playAgainButton.rx.controlEvent(.touchUpInside)
            .asDriver()
            .drive(onNext: { _ in
                self.view.removeFromSuperview()
                self.loadHomeViewController()
            }).disposed(by: disposeBag)
    }
    
    func loadHomeViewController() {
        let containerViewController = ContainerViewController()
        containerViewController.modalTransitionStyle = .crossDissolve
        self.present(containerViewController, animated: true, completion: nil)
    }
}
