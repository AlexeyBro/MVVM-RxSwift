//
//  Router.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 15.01.2021.
//

import UIKit

protocol Router {
    func initialViewController()
    func toDetailView(view: UIViewController, model: Movie?)
}

final class RouterService: Router {
    
    private var navigationController: UINavigationController?
    private var assembly: Assembly?
    
    init(navigationController: UINavigationController?, assembly: Assembly?) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let listViewController = assembly?.makeModule(module: .mainView, model: nil, router: self) else { return }
            navigationController.viewControllers = [listViewController]
        }
    }
    
    func toDetailView(view: UIViewController, model: Movie?) {
        guard let detailViewController = assembly?.makeModule(module: .detailView, model: model, router: nil) else { return }
        view.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
