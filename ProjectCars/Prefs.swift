

import Foundation

class Prefs{
    
    class func setString(_ valor: String, chave: String){
        
        let prefs = UserDefaults.standard
        prefs.set(valor, forKey: chave)
        prefs.synchronize()
        
    }
    
    class func getString(_ chave: String) -> String!{
        
        let prefs = UserDefaults.standard
        let s = prefs.string(forKey: chave)
        if let s = s{
            return s
        }
            return ""
        
    }
    
    class func setInt(_ valor: Int, chave: String){
        
        let prefs = UserDefaults.standard
        prefs.set(valor, forKey: chave)
        prefs.synchronize()
        
    }
    
    class func getInt(_ chave: String) -> Int{
        
        let prefs = UserDefaults.standard
        let s = prefs.integer(forKey: chave)
        return s
        
    }
}
