//
//  LoginViewModel.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 14/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    private(set) var passwordErrorMessage = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    let errorMessage = "Messers, Moony, Wormtail, Padfoot and Prongs offer their compliments and requests that you keep your abnormally large nose out of other people's business."
    
    func validatePassword(_ password: String?, completion: (_ isValid: Bool) -> ()) {
        guard let password = password, !password.isEmpty else {
            completion(false)
            return
        }
        if password == LoginConstants.password || password == LoginConstants.passwordBr || password == "lol"{
            completion(true)
            return
        }
        completion(false)
    }
}


private struct LoginConstants {
    static let password = "I solemnly swear that I am up to no good"
    static let passwordBr = "Eu juro solenemente não fazer nada de bom"
}

