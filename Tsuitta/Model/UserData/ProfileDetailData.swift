import SwiftyJSON

struct ProfileDetailData {
    
    private(set) var userID = 0
    
    private(set) var name = ""
    
    private(set) var screenName = ""
    
    private(set) var description = ""
    
    private(set) var location = ""
    
    private(set) var url = ""
    
    private(set) var followersCount = 0
    
    private(set) var friendsCount = 0
    
    private(set) var favouritesCount = 0
    
    //Tweet数？
    private(set) var statusesCount = 0
    
    private(set) var profileBannerURL = ""
    
    private(set) var profileImageURL = ""
    
    private(set) var following:Bool
    
    init(json: JSON) {
        self.userID = json["id"].intValue
        self.name = json["name"].stringValue
        self.screenName = json["screen_name"].stringValue
        self.description = json["description"].stringValue
        self.location = json["location"].stringValue
        self.url = json["url"].stringValue
        self.followersCount = json["followers_count"].intValue
        self.friendsCount = json["friends_count"].intValue
        self.favouritesCount = json["favourites_count"].intValue
        self.statusesCount = json["statuses_count"].intValue
        self.profileBannerURL = json["profile_banner_url"].stringValue
        self.profileImageURL = json["profile_image_url"].stringValue
        self.following = json["following"].boolValue
    }
}