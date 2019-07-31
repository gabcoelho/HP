//
//  ContainerViewController.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 16/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    enum SideMenuState {
        case collapsed
        case leftSideExpanded
    }
    
    var centerNavigationViewController: UINavigationController!
    var homeViewController: HomeViewController!
    var leftSideMenuViewController: SideMenuViewController!
    var currentSideMenuState: SideMenuState = .collapsed {
        didSet {
            let shouldShowShadow = currentSideMenuState != .collapsed
            shadowForHomeViewController(shouldShowShadow)
        }
    }
    
    // Expanding Constants
    var centerExpandedOffset: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - View Functions
    private func setupViews() {
        homeViewController = UIStoryboard.homeViewController()
        homeViewController.delegate = self
        centerNavigationViewController = UINavigationController(rootViewController: homeViewController)
        view.addSubview(centerNavigationViewController.view)
        addChild(centerNavigationViewController)
        centerNavigationViewController.didMove(toParent: self)
        homeViewController.view.bounds = UIScreen.main.bounds
    }
}


// MARK: - Side Menu Funtions
extension ContainerViewController: HomeViewControllerDelegate {
    func toggleLeftSideMenu() {
        let notExpanded = currentSideMenuState != .leftSideExpanded
        if notExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notExpanded)
    }
    
    func addLeftPanelViewController() {
        guard leftSideMenuViewController == nil, let viewController = UIStoryboard.leftViewController() else {
            return
        }
        addChildSideMenuController(viewController)
        leftSideMenuViewController = viewController
    }
    
    func addChildSideMenuController(_ sideMenu: SideMenuViewController) {
        view.insertSubview(sideMenu.view, at: 0)
        addChild(sideMenu)
        sideMenu.didMove(toParent: self)
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentSideMenuState = .leftSideExpanded
            animateCenterPanelXPosition(targetPosition: centerNavigationViewController.view.frame.width - centerExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { (finished) in
                self.currentSideMenuState = .collapsed
                self.leftSideMenuViewController.view.removeFromSuperview()
                self.leftSideMenuViewController = nil
            }
        }
    }
    
    // MARK: - Animation functions
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationViewController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }

    func shadowForHomeViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            centerNavigationViewController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationViewController.view.layer.shadowOpacity = 0
        }
    }
    
    
}

// MARK: - UIStoryboard
extension UIStoryboard {
    
    static func home() -> UIStoryboard { return UIStoryboard(name: "Home", bundle: nil) }
    
    static func leftViewController() -> SideMenuViewController? {
        return home().instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
    }
    
    static func homeViewController() -> HomeViewController? {
        return home().instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
    }
}
