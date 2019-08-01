//
//  QuestionState.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 31/07/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import ReSwift

struct QuestionState: StateType {
    var isAnswered: Bool
 
    init() {
        isAnswered = false
    }
}
