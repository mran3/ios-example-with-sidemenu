import Foundation
import SwiftyJSON

class PostsService {
    let postsEndpoint = "https://jsonplaceholder.typicode.com/posts"
    var posts:Array<Any> = []
    
    func getPosts(onSuccess: @escaping (Data)->Void){
        let request = NetworkUtilities.sharedInstance.createGetRequest(endpoint: postsEndpoint)
        NetworkUtilities.sharedInstance.makeRequest(endPoint: request, onSuccess: onSuccess)
    }
}
