//
//  CharactersViewModel.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 14/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class CharactersViewModel {

    enum State {
        case loading(Bool)
    }
    
    private(set) var charactersList = BehaviorRelay<[Characters]>(value: [])
    private(set) var disposeBag = DisposeBag()
    private(set) var isLoading = PublishSubject<State>()
    
    init() {
        fetchList { (characters) in
            self.charactersList.accept(characters)
        }
    }
    
    func fetchList(completion: @escaping (_ characters: [Characters]) -> () ) {
        isLoading.onNext(.loading(true))
        CharacterService().getCharactersList().subscribe(onNext: { (characters) in
            guard let characters = characters, characters.count > 0 else {
                return
            }
            self.isLoading.onNext(.loading(false))
            completion(characters)
        }).disposed(by: disposeBag)
    }
    
    func getCharacter(at indexPath: IndexPath) -> Characters {
        return charactersList.value[indexPath.row]
    }
    
}
