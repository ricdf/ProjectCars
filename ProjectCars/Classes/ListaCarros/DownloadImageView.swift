
//  Created by Ricardo Cavalcante on 10/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

class DownloadImageView: UIImageView {
    
    var progress: UIActivityIndicatorView!
    let queue = OperationQueue()
    let mainQueue = OperationQueue.main
    
    // Construtor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createProgress()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createProgress()
    }
    
    // Cria o UIActivityIndicatorView e adiciona por cima da imagem
    func createProgress() {
        progress = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        addSubview(progress)
    }
    
    override func layoutSubviews()  {
        // Posiciona o progress no centro
        progress.center = convert(self.center , from:self.superview)
    }
    
    // Faz o download da URL, default é com cache
    func setUrl(_ url: String) {
        setUrl(url, cache: true)
    }
    
    // Faz o download da URL
    func setUrl(_ url: String, cache: Bool) {
        self.image = nil
        queue.cancelAllOperations()
        // Inicia a animação
        progress.startAnimating()
        // Executa o download em background
        queue.addOperation( { self.downloadImg(url, cache: true) } )
    }
    
    func downloadImg(_ url: String, cache: Bool) {
        var data: Data!
        if(!cache) {
            // Download
            data = try? Data(contentsOf: URL(string: url)!)
        } else {
            // Cria o caminho para ler ou salvar o arquivo
            var path = StringUtils.replace(url, string: "/", withString: "_")
            path = StringUtils.replace(path, string: "\\", withString: "_")
            path = StringUtils.replace(path, string: ":", withString: "_")
            path = NSHomeDirectory() + "/Documents/" + path
            // Se o arquivo existe no cache
            let exists = FileManager.default.fileExists(atPath: path)
            if(exists) {
                // Lê do arquivo
                data = try? Data(contentsOf: URL(fileURLWithPath: path))
            } else {
                // Download
                data = try? Data(contentsOf: URL(string: url)!)
                //                println("url \(url), data \(data)")
                // Salva no arquivo
                if(data != nil) {
                    //data.write(toFile: path, atomically:true)
                    try! data.write(to: URL(fileURLWithPath: path), options:.atomic)
                }
            }
        }
        // Atualiza a view na thread de interface
        if(data != nil) {
            mainQueue.addOperation( {self.showImg(data)} )
        }
    }
    
    // Atualiza a imagem do UIImageView
    func showImg(_ data: Data) {
        if(data.count > 0) {
            self.image = UIImage(data: data)
        }
        // Para a animação
        progress.stopAnimating()
    }
}


