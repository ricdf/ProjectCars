//
//  ListaCarrosViewController.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 04/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

class ListaCarrosViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
   
    @IBOutlet var tableView : UITableView!
    @IBOutlet var progress : UIActivityIndicatorView!
    @IBOutlet var segmentControl : UISegmentedControl!
    
    var carros : Array<Carro> = []
    var tipo : String = "classicos"
    let imgRefresh = UIImage(named: "refresh.png")?.withRenderingMode(.alwaysOriginal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //título
        self.title = "Carros"
        //delegate
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register (UITableViewCell.self, forCellReuseIdentifier: "cell")

        //registrar no tableview que sera utilizado o CarroCell.xib
        let xib = UINib(nibName: "CarroCell", bundle: nil)
        self.tableView.register(xib, forCellReuseIdentifier: "cell")
        self.buscarCarros(true) //busca carro com cache
        
        //botao refresh na navigation bar
        let btAtualizar = UIBarButtonItem(image: imgRefresh, style: .plain, target: self, action: #selector(ListaCarrosViewController.atualizar))
        self.navigationItem.rightBarButtonItem = btAtualizar
        
        //recuperar o tipo salvo nas preferencia, tipo do carro do usuario que deixou na ultima vez q usou o app
        let idx = Prefs.getInt("tipoIdx")
        let s = Prefs.getString("tipoString")
        if(s != nil){ // a string é opcional , precisamos testar antes
            self.tipo = s!
        }
         self.segmentControl.selectedSegmentIndex = idx
       // self.buscarCarros(true) //busca carro com cache
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
           self.buscarCarros(true) //busca carro com cache, sempre q a tela é exibida ao usuario
        print(carros.count)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //chama o xib carrocell que é a celula personalizada
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CarroCell
        let linha = indexPath.row
        let carro = self.carros[linha]
        cell.cellNome.text = carro.nome
        cell.cellDesc.text = carro.desc
        cell.cellImg.setUrl(carro.url_foto)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let linha = indexPath.row
        let carro = self.carros[linha]
        //criar view controller para navegar para a tela de detalhes
        let vc = DetalhesCarroViewController(nibName: "DetalhesCarroViewController", bundle: nil)
        vc.carro = carro
        self.navigationController!.pushViewController(vc, animated: true)
       // Alerta.alerta("Clicou no carro \(carro.nome)", viewController: self)
    }
    
    @IBAction func alteraTipo(sender: UISegmentedControl){
        let idx = sender.selectedSegmentIndex
        
        switch(idx){
        case 0:
            self.tipo = "classicos"
        case 1:
            self.tipo = "esportivos"
        default:
            self.tipo = "luxo"
        }
        
        //salvar o tipo nas prefs
        Prefs.setInt(idx, chave: "tipoIdx")
        Prefs.setString(tipo, chave: "tipoString")
        
        //buscar os carros pelo tipo selecionado
        self.buscarCarros(true) //busca carro com cache
    }
    
    func buscarCarros(_ cache: Bool){
        progress.startAnimating()
        let callback = { (_ carros: Array<Carro>?, error:Error?) -> Void in
       // CarroService.getCarrosByTipo(tipo, { (_ carros: Array<Carro>?, error:Error?) -> Void in
        
            if let carros = carros{
                self.carros = carros
                self.tableView.reloadData()
                self.progress.stopAnimating()
            }else if let error = error{
                Alerta.alerta("Erro: " + error.localizedDescription, viewController: self)
            }
        }
        CarroService.getCarrosByTipo(tipo, cache, callback)
    }
        
    @objc func atualizar(){
        buscarCarros(false)
    }
}
        


