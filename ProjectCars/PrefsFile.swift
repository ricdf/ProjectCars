
import Foundation

class PrefsFile: Prefs{
    
    class func getFilePath(_ nome: String) -> String{
        
        let path = NSHomeDirectory() + "/Documents/" + nome + ".txt"
        print(path)
        return path
    }
    
    override class func setString(_ valor: String, chave: String){
        
        let path = PrefsFile.getFilePath(chave)
        let nsdata = StringUtils.toNSData(valor)
        try? nsdata.write(to: URL(fileURLWithPath: path), options: [.atomic] )
    
    }
    
    override class func getString(_ chave: String) -> String {
        let path = PrefsFile.getFilePath(chave)
        let nsdata = try? Data(contentsOf: URL(fileURLWithPath: path))
        let s = StringUtils.toString(nsdata)
        if let s = s {
            return s
        }
            return ""
    }
    
    override class func setInt(_ valor: Int, chave: String){
        setString(String(valor), chave: chave)
    }
    
    override class func getInt(_ chave: String) -> Int{
        let valorString: String = getString(chave)
        if(valorString == ""){
            return 0
        }
        let valorInt = Int(valorString)
        return valorInt!
    }
    
}
