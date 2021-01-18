//
//  Constans.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 14.01.2021.
//

import Foundation

enum EdbAPI {
    static let host = "https://api.themoviedb.org/"
    static let body = "3/trending/movie/day"
    static let language = "&language=en-US"
    static let apiKey = "?api_key=78f0a7746725815dee12cb22071cc027"
}

enum TmdbAPI {
    static let host = "https://image.tmdb.org/"
    static let body = "t/p/w500"
}
