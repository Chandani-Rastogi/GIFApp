//
//    GIFList.swift

import Foundation


struct GIF : Hashable  {
    
    var id : String!
    var images : ImageDict!
    var title : String!
    var isFavorite: Bool
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? String
        if let imagesData = dictionary["images"] as? [String:Any]{
                images = ImageDict(fromDictionary: imagesData)
            }
        title = dictionary["title"] as? String
        isFavorite = false
    }

}
struct ImageDict : Hashable {

    var downsized : Downsized!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let downsizedData = dictionary["downsized"] as? [String:Any]{
                downsized = Downsized(fromDictionary: downsizedData)
            }
    }
}

struct Downsized : Hashable {
    var height : String!
    var url : String!
    var width : String!
   
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        height = dictionary["height"] as? String
        url = dictionary["url"] as? String
        width = dictionary["width"] as? String
       
        
    }
}
