//
//  VideoUtil.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 17/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class VideoUtil {
    
    var player : AVPlayer?
    var playerViewController : AVPlayerViewController?
    
    //reproduzir um video file com um player utilizando uma view como container
    func playFile(_ file: String, view: UIView) {
        
        //converte o nome do arquivo em url
        let path = Bundle.main.path(forResource: file, ofType: nil)
        if(path != nil){
            let url = URL(fileURLWithPath: path!)
            self.playUrl(url, view: view)
        }
    }
    
    //reproduz um video url com um player ultilizando uma view como container
    func playUrl(_ url: URL!, view : UIView) {

        //cria o componente que gerencia o video
        if(self.player == nil){
            self.player = AVPlayer(url: url)
            let  playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            view.layer.addSublayer(playerLayer)
        }
        self.player!.play() //inicia o video
    }
    
    //pausar o video
    func pause(){
        if let player = player{
            player.pause()
        }
    }
    
    //parar o video
    func stop(){
        if let player = player{
            player.pause() //AVPlayer nao possui stop
        }
    }
    
    //reproduzir um video file em tela cheia
    func playFileFullScreen(_ file: String, viewController: UIViewController){
        
        //converte o nome do arquivo em URL
        let path = Bundle.main.path(forResource: file, ofType: nil)
        if(path != nil){
            let url = URL(fileURLWithPath: path!)
            self.playUrlFullScreen(url, viewController : viewController)
        }
    }
    
    //reproduz um video com url em tela cheia
    func  playUrlFullScreen(_ url: URL!, viewController : UIViewController){
        
        // cria o controller especializado e, reproduzir video
        if (self.playerViewController == nil){
            self.player = AVPlayer(url: url)
            self.playerViewController = AVPlayerViewController()
            self.playerViewController!.player = player
            viewController.present(self.playerViewController!, animated: true){
                self.playerViewController!.player!.play()
            }
        }
    }
    
}
