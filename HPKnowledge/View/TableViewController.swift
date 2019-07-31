//
//  GenericTableViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 15/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Selected: String {
    case characters = "Characters"
    case spells = "Spells"
    case quiz = "Quiz"
    
    var title: String {
        return rawValue
    }
}

class TableViewController: UIViewController {

    @IBOutlet weak var genericTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    
    private var charactersViewModel = CharactersViewModel()
    private var spellsViewModel = SpellsViewModel()
    private var charactersData = [Characters]()
    private var spellsData = [Spell]()
    var item: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loader.startAnimating()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backButton.accessibilityIdentifier = "Voltar"
        genericTableView.accessibilityIdentifier = "GenericTable"
        bindTableView()
        genericTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        bindViewModels()
        bindButton()
        genericTableView.rowHeight = 65
    }
}

// MARK: - TableView DataSource + Delegate
private extension TableViewController {
    
    func bindButton() {
        backButton.rx.controlEvent( .touchUpInside )
            .asDriver()
            .drive(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    func bindViewModels() {
        
        charactersViewModel.isLoading.observeOn(MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: { (state) in
                switch state {
                case .loading(let loading):
                    while loading {
                        self.loader.isHidden = false
                        self.loader.startAnimating()
                    }
                    self.loader.isHidden = true
                    self.loader.stopAnimating()
                }
            }).disposed(by: disposeBag)
    }
    
    func bindTableView() {
        itemSelected(item)
    }
    
    func itemSelected(_ item: String) {
        if Selected.characters.title == item {
            charactersViewModel.charactersList
                .bind(to: genericTableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)) {
                    row, character, cell in
                    cell.setLabel(with: character.name)
                }.disposed(by: disposeBag)

            genericTableView.rx.itemSelected
                .subscribe(onNext: { indexPath in
                    let character = self.charactersViewModel.getCharacter(at: indexPath)
                    let characterinfoVC = CharacterInfoViewController(nibName: "CharacterInfoView", bundle: nil)
                    self.addChild(characterinfoVC)
                    characterinfoVC.view.frame = self.view.frame
                    self.view.addSubview(characterinfoVC.view)
                    characterinfoVC.didMove(toParent: self)
                    characterinfoVC.configureView(with: character)
                    self.genericTableView.deselectRow(at: indexPath, animated: true)
                }).disposed(by: disposeBag)
            
        } else if Selected.spells.title == item {
            spellsViewModel.spellsList
                .bind(to: genericTableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)) {
                    row, spell, cell in
                    cell.setLabel(with: spell.spell)
                }.disposed(by: disposeBag)
            
            genericTableView.rx.itemSelected
                .subscribe(onNext: { indexPath in
                    let spell = self.spellsViewModel.getSpell(at: indexPath)
                    let spellInfoVC = SpellInfoViewController(nibName: "SpellInformationView", bundle: nil)
                    self.addChild(spellInfoVC)
                    spellInfoVC.view.frame = self.view.frame
                    self.view.addSubview(spellInfoVC.view)
                    spellInfoVC.didMove(toParent: self)
                    spellInfoVC.configureView(with: spell)
                    self.genericTableView.deselectRow(at: indexPath, animated: true)
                }).disposed(by: disposeBag)
            
        }
    }
}
