//
//  String+Extensions.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 16/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import Foundation

extension String{
    
    func url() -> URL {
        
        // facilitar criar uma url a partir de uma string
        return URL(string: self)!
    
    }
    
}
