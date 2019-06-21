//
//  DetalhesCarroViewController.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 04/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

class DetalhesCarroViewController: UIViewController, UISplitViewControllerDelegate {

    @IBOutlet var img : DownloadImageView!
    @IBOutlet var tDesc : UITextView!
    
    @IBAction func visualizarMapa(bt: UIButton){
        
        let vc = GpsMapViewController(nibName: "MapViewController", bundle: nil)
        vc.carro = self.carro
        if(Utils.isIphone()){
            self.navigationController!.pushViewController(vc, animated: true)
        } else {
            
            print("Mostra no popover")
            // Tamanho da janela
            vc.preferredContentSize = CGSize(width: 500, height: 300)
            vc.modalPresentationStyle = UIModalPresentationStyle.popover;
            // Origem do popover
            let popoverPresentationController = vc.popoverPresentationController
            popoverPresentationController?.sourceView = bt
            // Mostra o view controller como popover
            present(vc, animated: true, completion: nil)
        
        }
    }
    @IBAction func visualizarVideo(bt: UIButton){

        if(Utils.isIphone()){
            let videoUtil = VideoUtil()
            let url = self.carro!.url_video.url()
            print("Video URL \(url)")
            videoUtil.playUrlFullScreen(url, viewController: self)
        } else {

            print("Mostra no popover")
            let vc = VideoViewController(nibName: "VideoViewController", bundle: nil)
            vc.carro = self.carro
            // Tamanho da janela
            vc.preferredContentSize = CGSize(width: 550, height: 250)
            vc.modalPresentationStyle = UIModalPresentationStyle.popover;
            // Origem do popover
            let popoverPresentationController = vc.popoverPresentationController
            popoverPresentationController?.sourceView = bt
            // Mostra o view controller como popover
            present(vc, animated: true, completion: nil)

        }
    }
    
    let imgDeleta = UIImage(named: "deleta.png")?.withRenderingMode(.alwaysOriginal)

    
    var carro : Carro?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let c = carro{
            self.title = c.nome
            self.tDesc.text = c.desc
            self.img.setUrl(c.url_foto)
            //para atualizar o carro selecionado quando for ipad
            updateCarro(c)
            //inserir botao de deletar na navigation bar
            let btDeleta = UIBarButtonItem(image: imgDeleta, style: .plain, target: self, action: #selector(DetalhesCarroViewController.onClickDeletar))
            self.navigationItem.rightBarButtonItem = btDeleta
        }
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
    
    func updateCarro(_ c: Carro) {
        
        self.carro = c
        self.title = c.nome
        self.tDesc.text = c.desc;
        self.img.setUrl(c.url_foto)
    }
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
        
        let vertical = displayMode == UISplitViewController.DisplayMode.primaryHidden
        if (vertical){
            
            //insere o botao na navigation bar
            let btPopover = UIBarButtonItem(title: "Lista", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DetalhesCarroViewController.onClickPopover))
            self.navigationItem.leftBarButtonItem = btPopover
        }else{
            
            //remove o botao se esta na horizontal
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    @IBAction func onClickPopover() {

        //mostrar o view controller no popover
        let bt = self.navigationItem.leftBarButtonItem!
        let vc = ListaCarrosViewController()
        
        //mostra o popover ancorado no botao de navgation bar
        PopoverUtil.show(self, viewController: vc, source: bt, width: 400, height: 800)
        
    }
    

}
