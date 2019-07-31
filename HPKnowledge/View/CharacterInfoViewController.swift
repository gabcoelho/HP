//
//  CharacterInfoViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 23/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import RxSwift

class CharacterInfoViewController: UIViewController {

    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var house: UILabel!
    @IBOutlet weak var bloodStatus: UILabel!
    @IBOutlet weak var deathEater: UILabel!
    @IBOutlet weak var orderOfThePhoenix: UILabel!
    @IBOutlet weak var dumbledoresArmy: UILabel!
    @IBOutlet weak var closeButton: UIButton!

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
        closeButton.accessibilityIdentifier = "FecharCharacterInfo"
        modalView.layer.cornerRadius = 20
        modalView.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configureView(with character: Characters) {
        name.text = character.name
        role.text = character.role != nil ? character.role?.capitalized : "Not informed"
        bloodStatus.text = character.bloodStatus.capitalized
        deathEater.text = character.deathEater.description.capitalized
        dumbledoresArmy.text = character.dumbledoresArmy.description.capitalized
        house.text = character.house != nil ? character.house?.capitalized : "Not informed"
        orderOfThePhoenix.text = character.orderOfThePhoenix.description.capitalized
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
