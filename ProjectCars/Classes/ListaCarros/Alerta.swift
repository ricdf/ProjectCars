//
//  Alerta.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 04/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

class Alerta{
    
    class func alerta(_ msg : String, viewController : UIViewController){
        Alerta.alerta(msg, viewController: viewController, action: nil)
    }
    
    class func alerta(_ msg : String, viewController: UIViewController, action: ((UIAlertAction?) -> Void)!){
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: action))
        viewController.present(alert, animated: true, completion: nil)
        
    }
}
