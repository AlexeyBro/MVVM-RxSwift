//
//  UIStoryboard.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 15.01.2021.
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T:UIViewController>(_ type: T.Type) -> T? {
        self.instantiateViewController(identifier: String(describing: type.self)) as? T
    }
}
