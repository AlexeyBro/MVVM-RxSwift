//
//  Assembly.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 15.01.2021.
//

import UIKit

enum Modules {
    case mainView
    case detailView
}

protocol Assembly {
    func makeModule(module: Modules, model: Movie?, router: Router?) -> UIViewController
}

final class AssemblyService: Assembly {
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    private let networkService = NetworkServiceImpl()
    private let imageDownloader = ImageDownloaderImpl()
    private let moviesStorage = MoviesStorageImpl()
    
    init() {
        networkService.moviesStorage = moviesStorage
    }
    
    func makeModule(module: Modules, model: Movie?, router: Router?) -> UIViewController {
        switch module {
        case .mainView:
            return makeMainView(router: router)
        case .detailView:
            return makeDetailView(model: model)
        }
    }
    
    private func makeMainView(router: Router?) -> UIViewController {
        guard let viewController = storyboard.instantiateViewController(ViewController.self) else { return UIViewController() }
        let viewModel = ViewModelImpl(networkService: networkService, imageDownloader: imageDownloader, router: router)
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func makeDetailView(model: Movie?) -> UIViewController {
        guard let detailViewController = storyboard.instantiateViewController(DetailViewController.self) else { return UIViewController() }
        let detailViewModel = DetailViewModelImpl(movies: model, networkService: networkService, imageDownloader: imageDownloader)
        detailViewController.viewModel = detailViewModel
        return detailViewController
    } 
}
