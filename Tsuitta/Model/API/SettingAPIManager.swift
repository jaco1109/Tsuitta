import TwitterKit
import SwiftyJSON

struct Account{
    var name:String?
    var url:String?
    var location:String?
    var description:String?
    
    func getDic() -> Dictionary<String, String>?{
        var dic = Dictionary<String, String>()
        if let val = name {
            dic["name"] = val
        }
        if let val = url {
            dic["url"] = val
        }
        if let val = location {
            dic["location"] = val
        }
        if let val = description {
            dic["description"] = val
        }
        
        return dic
    }
}

class SettingAPIManager {
    
    func profile(account: Account){
        guard let dic = account.getDic() where dic.count != 0 else {
            return
        }
        APIClient.post("/account/update_profile.json", parameter: dic) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
        }
    }
    
    func iconImage(image: UIImage = UIImage(named: "sample.jpg")!){
        //TODO: 引数の0.5は適当です。
        let imageFile = UIImageJPEGRepresentation(image, 0.5)!
        APIClient.post("/account/update_profile_image.json", parameter: ["image": imageFile.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
        }
    }
    
    func backgroundImage(image: UIImage = UIImage(named: "sample")!){
        let imageFile = UIImageJPEGRepresentation(image, 0.5)!
        APIClient.post("/account/update_profile_background_image.json", parameter: ["name": imageFile.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)]) { (response, data, error) -> Void in
            if let err = error {
                debug("エラーだよ：\(err.debugDescription)")
                return
            }
        }
    }
}
