//
//  ViewModel.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 14.01.2021.
//

import UIKit
import RxSwift
import RxRelay

protocol ViewModel: AnyObject {
    var movies: BehaviorRelay<[Movie]> { get }
    var updateData: (() -> Void)? { get set }
    func loadMovie()
    func willDisplayCell(_ cell: TableViewCell, withIndex index: Int)
    func showDetail(view: UIViewController, model: Movie?)
    func loadImage(forIndex index: Int) -> Observable<UIImage?>
}

final class ViewModelImpl: ViewModel {
    private let disposeBag = DisposeBag()
    private var networkService: NetworkService?
    private var imageDownloader: ImageDownloader?
    private var router: Router?
    var movies = BehaviorRelay<[Movie]>(value: [])

    var updateData: (() -> Void)?
    
    init(networkService: NetworkService?, imageDownloader: ImageDownloader?, router: Router?) {
        self.networkService = networkService
        self.imageDownloader = imageDownloader
        self.router = router
        subscribeOnMovies()
    }
    
    func loadMovie() {
        networkService?
            .fetchMovies()
            .subscribe(onNext: { [weak self] movies in
                self?.movies.accept(movies)
            }).disposed(by: disposeBag)
    }
    
    func willDisplayCell(_ cell: TableViewCell, withIndex index: Int) {
        let tableViewModel = TableCellViewModel(
            title: movies.value[index].title,
            releaseDate: movies.value[index].releaseDate,
            rating: movies.value[index].voteAverage
        )
        cell.configurView(withModel: tableViewModel)
        cell.bindImage(loadImage(forIndex: index))
    }
    
    func loadImage(forIndex index: Int) -> Observable<UIImage?> {
        guard let imagePath = movies.value[index].posterPath,
              let image = imageDownloader?.loadImage(urlString: imagePath) else { fatalError() }
        return image
    }
    
    func showDetail(view: UIViewController, model: Movie?) {
        router?.toDetailView(view: view, model: model)
    }
    
    private func subscribeOnMovies() {
       movies
            .observe(on: MainScheduler.init())
            .subscribe(onNext: { [weak self] _ in
                self?.updateData?()
            }).disposed(by: disposeBag)
    }
}
