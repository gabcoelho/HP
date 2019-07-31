//
//  LaunchScreenViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 17/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import SwiftyGif

class LaunchScreenViewController: UIViewController {
    
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationView)
        animationView.pinEdgesToSuperView()
        animationView.logoGifImageView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView.logoGifImageView.startAnimatingGif()
    }
}

extension LaunchScreenViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        animationView.isHidden = true
        let loginViewController = LoginViewController().newInstance()
        loginViewController.modalTransitionStyle = .crossDissolve
        view.addSubview(loginViewController.view)
        addChild(loginViewController)
        loginViewController.didMove(toParent: self)
    }
}
