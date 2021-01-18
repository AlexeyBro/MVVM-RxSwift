//
//  NetworkService.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 14.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol NetworkService {
    func fetchMovies() -> Observable<[Movie]>
}

final class NetworkServiceImpl: NetworkService {
    
    weak var moviesStorage: MoviesStorage?
    
    func fetchMovies() -> Observable<[Movie]> {
        let urlString = EdbAPI.host + EdbAPI.body + EdbAPI.apiKey
        guard let url = URL(string: urlString) else { fatalError() }
        let request = URLRequest(url: url)
        
        return Observable.create { obs in
            URLSession.shared.rx.response(request: request).debug("r").subscribe(
                onNext: { response in
                    if let movieData = Serializer.decode(type: MovieData.self, data: response.data) {
                        self.moviesStorage?.setData(data: response.data)
                        return obs.onNext(movieData.results)
                    } else if let data = self.moviesStorage?.provideData() {
                        let movieData = Serializer.decode(type: MovieData.self, data: response.data)
                        return obs.onNext(movieData?.results ?? [])
                    }
                },
                onError: {error in
                    obs.onError(error)
                })
        }
    }
}
