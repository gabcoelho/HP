//
//  InfoViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 22/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import RxSwift
import UIKit

class SpellInfoViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var spellDescription: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var modalView: UIView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        showAnimate()
        bindButton()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        closeButton.accessibilityIdentifier = "FecharSpellsInfo"
        modalView.layer.cornerRadius = 20
        modalView.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configureView(with selected: Spell) {
        name.text = selected.spell
        type.text = selected.type
        spellDescription.text = selected.effect.capitalized
    }
    
    private func bindButton() {
        closeButton.rx.controlEvent(.touchUpInside)
            .asDriver()
            .drive(onNext: { _ in
                self.removeAnimate()
            }).disposed(by: disposeBag)
    }
    
    private func showAnimate() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }

}
