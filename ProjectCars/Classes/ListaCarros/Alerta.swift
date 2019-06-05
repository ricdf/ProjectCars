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
        
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
        
    }
}
