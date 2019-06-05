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
    var carros : Array<Carro> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //título
        self.title = "Carros"
        //delegate
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register (UITableViewCell.self, forCellReuseIdentifier: "cell")
        //adicionar os carros do array criado de varios carros
        self.carros = CarroService.getCarros()
        //registrar no tableview que sera utilizado o CarroCell.xib
        let xib = UINib(nibName: "CarroCell", bundle: nil)
        self.tableView.register(xib, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let linha = indexPath.row
        let carro = carros[linha]
        //chama o xib carrocell que é a celula personalizada
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CarroCell
        
        cell.cellNome.text = carro.nome
        cell.cellDesc.text = carro.desc
        cell.cellImg.image = UIImage(named: carro.url_foto)
        
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
