//
//  MoviesStorage.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 15.01.2021.
//

import Foundation
import RxSwift

protocol MoviesStorage: AnyObject {
    func provideData() -> Data
    func setData(data: Data)
}

final class MoviesStorageImpl: MoviesStorage {
    
    private var movies: Data {
        get {
            return UserDefaults.standard.array(forKey: "movies") as? Data ?? Data()
        }
        set {
            return UserDefaults.standard.setValue(newValue, forKey: "movies")
        }
    }
    
    func provideData() -> Data {
        movies
    }
    
    func setData(data: Data) {
        movies = data
    }
}
