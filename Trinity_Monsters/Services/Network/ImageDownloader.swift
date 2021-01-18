//
//  ImageDownloader.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 15.01.2021.
//

import UIKit
import RxSwift

protocol ImageDownloader {
    func loadImage(urlString: String) -> Observable<UIImage?> 
}

final class ImageDownloaderImpl: ImageDownloader {
    
    func loadImage(urlString: String) -> Observable<UIImage?> {
        guard let url = URL(string: TmdbAPI.host + TmdbAPI.body + urlString) else { fatalError() }
        let request = URLRequest(url: url)
        
        return Observable.create { obs in
            URLSession.shared.rx.response(request: request).debug("r").subscribe(
                onNext: { response in
                    return obs.onNext(UIImage(data: response.data))
                },
                onError: {error in
                    obs.onError(error)
                })
        }
    }
}
