//
//  AppReducer.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 31/07/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(loginState: loginReducer(action: action, state: state?.loginState),
                    questionState: questionReducer(action: action, state: state?.questionState))
}
