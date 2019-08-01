//
//  SideMenuViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 16/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReSwift

class SideMenuViewController: UIViewController {
    
    private var viewModel = SideMenuViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.accessibilityIdentifier = "SideMenuTable"
        bindMenuTableView()
    }
    
    func bindMenuTableView() {
        viewModel.items.asObservable()
            .bind(to: self.menuTableView.rx.items) {
                menuTableView, row, cell in
                let cellTable = menuTableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: IndexPath(row: row, section: 0)) as! SideMenuTableViewCell
                let menuItem = self.viewModel.menuItem(at: IndexPath(row: row, section: 0))
                cellTable.configureSideMenuCell(with: menuItem)
                return cellTable
        }.disposed(by: disposeBag)
        
        menuTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let tableViewController = TableViewController(nibName: "TableView", bundle: nil)
                self.present(tableViewController, animated: true, completion: nil)
                tableViewController.item = self.viewModel.menuItem(at: indexPath).title
            }).disposed(by: disposeBag)
    }
    
}
