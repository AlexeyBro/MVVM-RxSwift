//
//  DetailViewModel.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 14.01.2021.
//

import UIKit
import RxSwift

protocol DetailViewModel {
    var updateData: ((Movie?) -> Void)? { get set }
    var updateBackdrop: ((Observable<UIImage?>) -> Void)? { get set }
    func setMovie()
    func loadImage()
}

final class DetailViewModelImpl: DetailViewModel {
    var updateData: ((Movie?) -> Void)?
    var updateBackdrop: ((Observable<UIImage?>) -> Void)?
    private var movies: Movie?
    private var networkService: NetworkService?
    private var imageDownloader: ImageDownloader?
    
    init(movies: Movie?, networkService: NetworkService?, imageDownloader: ImageDownloader?) {
        self.movies = movies
        self.networkService = networkService
        self.imageDownloader = imageDownloader
    }
    
    func setMovie() {
        updateData?(movies)
    }
    
    func loadImage() {
        guard let backdropPath = movies?.backdropPath,
              let image = imageDownloader?.loadImage(urlString: backdropPath) else { return }
        updateBackdrop?(image)
    }
}
