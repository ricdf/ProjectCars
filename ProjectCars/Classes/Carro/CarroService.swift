//
//  CarroService.swift
//  Carros
//
//  Created by Ricardo Lecheta on 7/12/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation

class CarroService {
    
    class func getCarrosByTipo(_ tipo: String, cache:Bool, callback: @escaping (_ carros:Array<Carro>?, _ error:Error?) -> Void) {
        
        var db = CarroDB()
        //let carros = db.getCarrosByTipo(tipo)//busca os carros no banco de dados
        //db.close()
        //busca os carros do bd ou cria um array vazio para os dados virem do web service
        let carros : Array<Carro> = cache ? db.getCarrosByTipo(tipo) : []
        //se existir no banco de dados retorna
        if(carros.count > 0) {
            db.close()
            
            for c in carros {
                print(c.nome)
                print(c.url_foto)
            }
            
            // Retorna os carros pela função de retorno
            callback(carros, nil)
            print("Retornando carros \(tipo) do banco")
            return
        }
        // Cria a URL e Request do web service
        let http = URLSession.shared
        let url = URL(string:"http://www.livroiphone.com.br/carros/carros_"+tipo+".json")!
        let request = URLRequest(url: url)
        
        // Faz a requisicao HTTP
        let task = http.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if(error != nil) {
                // Chama o callback de erro
                callback(nil, error!)
            } else {
                // Faz parser de JSON. Cria lista de carros.
                let carros = CarroService.parserJson(data!)
                
                if(carros.count > 0) {
                    db = CarroDB()
                    
                    db.deleteCarrosTipo(tipo)
                    
                    for c in carros {
                        // Salva o tipo do carro
                        c.tipo = tipo
                        // Salva o carro no banco
                        db.save(c)
                    }
                    db.close()
                }
                
                DispatchQueue.main.sync(execute: {
                    callback(carros, nil)
                })
                
            }
        })
        task.resume()
    }
    //salvar os carros no banco de dados
    class func saveCarros(_ carros: Array<Carro>, tipo:String ) {
        if(carros.count > 0){
            let db = CarroDB()
            db.deleteCarrosTipo(tipo)
            for c in carros{
                c.tipo = tipo
                db.save(c)
            }
            db.close()
        }
    }
    
    // Parser JSON
    // Parser JSON
    class func parserJson(_ data: Data) -> Array<Carro> {
        
        var carros : Array<Carro> = []
        
        // Faz a leitura do JSON, converte para dictionary
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            // Dictionary para todos os carros
            let jsonCarros: NSDictionary = dict["carros"] as! NSDictionary
            let arrayCarros: NSArray = jsonCarros["carro"] as! NSArray
            
            // Array de carros
            for obj in arrayCarros {
                let dict = obj as! NSDictionary
                let carro = Carro()
                carro.nome = dict["nome"] as! String
                carro.desc = dict["desc"] as! String
                carro.url_info = dict["url_info"] as! String
                carro.url_foto = dict["url_foto"] as! String
                carro.url_video = dict["url_video"] as! String
                carro.latitude = dict["latitude"] as! String
                carro.longitude = dict["longitude"] as! String
                carros.append(carro)
            }
        } catch let error as NSError {
            print("Erro ao ler JSON \(error)")
        }
        // Retorna a lista de carros
        return carros
    }
    

    
    
    // Retorna um array de carros de forma simples
    class func getCarros() -> Array<Carro> {
        
        var carros : Array<Carro> = []
        
        for i in 1...20 {
            let c = Carro()
            c.nome = "Ferrari " + String(i)
            c.desc = "Desc Carro " + String(i)
            c.url_foto = "Ferrari_FF.png"
            c.url_info = "http://www.google.com.br"
            
            // Adiciona o carro no array
            carros.append(c)
        }
        
        return carros
    }
}
