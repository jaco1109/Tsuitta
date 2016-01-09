import TwitterKit

class APIClient {
    
    private let baseURL = "https://api.twitter.com"
    private let version = "/1.1"
    
    init() {
        
    }
    
    private func sendRequest(method: String, path: String, parameter: [NSObject : AnyObject]? = nil,  callback: TWTRNetworkCompletion){
        //TODO: clientError の使い方よくわからないよ！
        var clientError: NSError?
        let endpoint = baseURL + version + path
        let request = Twitter.sharedInstance().APIClient.URLRequestWithMethod(method, URL: endpoint, parameters: parameter, error: &clientError)
        
        Twitter.sharedInstance().APIClient.sendTwitterRequest(request, completion: {
            response, data, err in
            callback(response, data, err)
        })
    }
    
    func get(path: String, parameter: [NSObject : AnyObject]? = nil,  callback: TWTRNetworkCompletion) {
        sendRequest("GET", path: path, parameter: parameter, callback: callback)
    }
    
    func post(path: String, parameter: [NSObject : AnyObject]? = nil,  callback: TWTRNetworkCompletion) {
        sendRequest("POST", path: path, parameter: parameter, callback: callback)
    }
}