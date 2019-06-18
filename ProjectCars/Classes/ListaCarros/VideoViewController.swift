//
//  VideoViewController.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 16/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var carro: Carro?
    @IBOutlet var webView : UIWebView!
    let videoUtil = VideoUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = self.carro!.url_video.url()
            
            // 1 ) video com WebView
       //     let request = URLRequest(url: url)
       //     self.webView.loadRequest(request)
            
            // 2 ) reproduz o video sobre uma view de marcacao
        self.videoUtil.playUrl(url, view: self.webView)
        
            // 3 ) direto com a view especializada de videos , est ano detalhes
        
        //notificacao para o fim do video
        NotificationCenter.default.addObserver(self, selector: #selector(VideoViewController.videoFim), name:Notification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(VideoViewController.videoFim), name: NSNotification.Name(rawValue: "MPMoviePlayerDidExitFullscreenNotification"), object: nil)
    }
    
    @objc func videoFim(){
        print("Fim do Vídeo")
        //fechar o controller pq o video ja acabou
       self.navigationController!.popViewController(animated: true)
    }

}
