//
//  AppDelegate.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 04/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var listaController : ListaCarrosViewController?
    var detalhesController : DetalhesCarroViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor.white
        
        //se iPad ou iPhone : para iPad usar Split View
        let iPad = Utils.isIpad()
        if(iPad){
            self.initIpad()
        }else{
            self.initIphone()
        }
        
        //crair o banco de dados e as tabelas
        let db = CarroDB()
        db.createTables()
        db.close()
        
        //mostra a janela
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    //cria view para iphone com Tab Bar
    func initIphone() {
        let listaController = ListaCarrosViewController(nibName: "ListaCarrosViewController", bundle: nil)
        let sobreController = SobreViewController(nibName: "SobreViewController", bundle: nil)
        
        let nav1 = UINavigationController()
        let nav2 = UINavigationController()
        
        nav1.pushViewController(listaController, animated: false)
        nav2.pushViewController(sobreController, animated: false)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nav1,nav2]
        
        nav1.tabBarItem.title = "Carros"
        nav1.tabBarItem.image = UIImage(named:"tab_carros.png")
        nav2.tabBarItem.title = "Sobre"
        nav2.tabBarItem.image = UIImage(named:"tab_sobre.png")
        
        self.window!.rootViewController = tabBarController
        
    }
    
    func initIpad() {
        // Cria os controllers da Esquerda e Direita
        self.detalhesController = DetalhesCarroViewController()
        self.listaController = ListaCarrosViewController()
        
        let nav1 = UINavigationController()
        let nav2 = UINavigationController()
        
        nav1.pushViewController(listaController!, animated: false)
        nav2.pushViewController(detalhesController!, animated: false)

        // Cria o UISplitViewController
        let split = UISplitViewController()
        split.delegate = detalhesController
        split.viewControllers = [nav1, nav2]
        
        // Deixa o UISplitViewController como o controller principal
        self.window!.rootViewController = split
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

