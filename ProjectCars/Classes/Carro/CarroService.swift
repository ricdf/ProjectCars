//
//  CarroService.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 05/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import Foundation

class CarroService{
    
    class func getCarros() -> Array<Carro>{
        
        var carros : Array<Carro> = []
        
        for i in 1...20 {
            let c = Carro()
            c.nome = "Ferrari " + String(i)
            c.desc = "Ferrari Carro " + String(i)
            c.url_foto = "ferrari_ff.png"
            //adiciona o carro no array
            carros.append(c)
        }
        
        return carros
    }
}
