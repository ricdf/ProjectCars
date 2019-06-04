//
//  SobreViewController.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 04/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

let URL_SOBRE = "http://www.livroiphone.com.br/carros/sobre.htm"

class SobreViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView : UIWebView!
    @IBOutlet var progress : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        
        self.title = "Sobre"
        
        //iniciar a animaçao do activity indicator
        self.progress.startAnimating()
        //carrega a animacao no webview
        let url = URL(string: URL_SOBRE)
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request)

    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        //parar a animacao
        progress.stopAnimating()
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
