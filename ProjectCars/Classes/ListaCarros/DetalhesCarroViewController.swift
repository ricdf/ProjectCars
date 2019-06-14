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
    let imgDeleta = UIImage(named: "deleta.png")?.withRenderingMode(.alwaysOriginal)

    
    var carro : Carro?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let c = carro{
            self.title = c.nome
            self.tDesc.text = c.desc
            self.img.setUrl(c.url_foto)
            //inserir botao de deletar na navigation bar
            let btDeleta = UIBarButtonItem(image: imgDeleta, style: .plain, target: self, action: #selector(DetalhesCarroViewController.onClickDeletar))
            self.navigationItem.rightBarButtonItem = btDeleta
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

    @objc func  onClickDeletar() {
        let alert = UIAlertController(title: "Confirma ? ", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {(alert: UIAlertAction!) in self.deletar()}))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: {(alert: UIAlertAction!) in}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deletar(){
        let db = CarroDB()
        db.delete(self.carro!)
        print()
        //mostrar um alerta
        Alerta.alerta("Carro excluído com sucesso!", viewController: self, action:
            {
                (UIAlertAction) -> Void in
                self.goBack()
        })
    }
    
    func goBack(){
        self.navigationController!.popViewController(animated: true)
    }

}
