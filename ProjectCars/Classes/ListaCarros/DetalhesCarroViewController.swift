//
//  DetalhesCarroViewController.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 04/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

class DetalhesCarroViewController: UIViewController {

    @IBOutlet var img : DownloadImageView!
    @IBOutlet var tDesc : UITextView!
    
    var carro : Carro?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let c = carro{
            self.title = c.nome
            self.tDesc.text = c.desc
            self.img.setUrl(c.url_foto)
        }
    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var text=""
        switch UIDevice.current.orientation{
        case .portrait:
            text="Portrait"
        case .portraitUpsideDown:
            text="PortraitUpsideDown"
        case .landscapeLeft:
            text="LandscapeLeft"
        case .landscapeRight:
            text="LandscapeRight"
        default:
            text="Another"
        }
        NSLog("You have moved: \(text)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
