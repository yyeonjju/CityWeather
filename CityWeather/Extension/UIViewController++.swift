//
//  UIViewController++.swift
//  CityWeather
//
//  Created by 하연주 on 7/13/24.
//

import UIKit

extension UIViewController {
    enum TransitionType {
        case push
        case present
        case presentNavigation
        case presentFullNavigation
    }
    
    func pageTransition(to viewController : UIViewController, type : TransitionType) {
        switch type {
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
        case .present:
            present(viewController, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
        
    }
    
    func configureNavigationBackButtonItem() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popToPrevPage))
        backButton.tintColor = Assets.Color.white
        navigationItem.leftBarButtonItems = [backButton]
    }
    
    @objc private func popToPrevPage() {
        navigationController?.popViewController(animated: true)
    }
    
}

