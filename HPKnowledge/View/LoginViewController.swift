//
//  ViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 10/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoginButton()
    }
    
    func newInstance() -> LoginViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return controller
    }
    
    // MARK: - Alert Func
    private func showAlert(for error: String) {
        let alertController = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Binding
    private func bindLoginButton() {
        loginButton.rx.controlEvent(.touchUpInside)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.viewModel.validatePassword(self.password.text, completion: { (isValid) in
                    if isValid {
                        self.password.endEditing(true)
                        let containerViewController = ContainerViewController()
                        containerViewController.modalTransitionStyle = .crossDissolve
                        self.view.addSubview(containerViewController.view)
                        self.addChild(containerViewController)
                        containerViewController.didMove(toParent: self)
                        containerViewController.view.bounds = UIScreen.main.bounds
                    } else {
                        self.showAlert(for: self.viewModel.errorMessage)
                    }
                })
            }).disposed(by: disposeBag)
    }
}



// MARK: - TextField Functions
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 250)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 250)

    }
    
    func animateViewMoving(up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame =  self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}




// FRASES

//O Sr. Aluado apresenta seus cumprimentos ao Prof. Snape e pede que ele não meta seu nariz anormalmente grande no que não é de sua conta."
//"O Sr. Pontas concorda com o Sr. Aluado e gostaria de acrescentar que o Prof. Snape é um safado mal acabado."
//"O Sr. Almofadinhas gostaria de deixar registrado o seu espanto de que um idiota desse calibre tenha chegado a professor."
//"O Sr. Rabicho deseja ao Prof. Snape um bom dia e aconselha a esse seboso que lave os cabelos.
//
////
//"Mr Moony presents his compliments to Professor Snape and begs him to keep his abnormally large nose out of other people's business.
//Mr Prongs agrees with Mr Moony and would like to add that Professor Snape is an ugly git.
//Mr Padfoot would like to register his astonishment that an idiot like that ever became a Professor.
//Mr Wormtail bids Professor Snape good day, and advises him to wash his hair, the slime-ball."
//Messers, Moony, Wormtail, Padfoot and Prongs offer their compliments to Professor Snape and request he keep his abnormally large nose out of other people's business.
