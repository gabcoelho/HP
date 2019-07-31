//
//  File.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 14/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SpellsViewModel {
    
    private(set) var spellsList = BehaviorRelay<[Spell]>(value: [])
    private(set) var disposeBag = DisposeBag()
    
    init() {
        fetchSpells { (spells) in
            guard let spells = spells else {
                return
            }
            self.spellsList.accept(spells)
        }
    }
    
    func fetchSpells(completion: @escaping (_ spells: [Spell]?) -> ()) {
        SpellService().getSpellsList().subscribe(onNext: { (spells) in
            completion(spells!)
        }).disposed(by: disposeBag)
    }
    
    func listOfSpells() -> [Spell] {
        return spellsList.value
    }
    
    func getSpell(at indexPath: IndexPath) -> Spell {
        return spellsList.value[indexPath.row]
    }
    
}
