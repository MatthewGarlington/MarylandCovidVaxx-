//
//  Data.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI

struct Post: Codable, Identifiable {
    
    let id = UUID()
    var title: String
    var body: String
    
}

class Api {
    // The completion allows to return an array of the items in Post
    func getPosts(completion: @escaping ([Post]) -> ()) {
        
        // The URL used gives us fake json data useful for prototyping
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            
        // Prevent Crashing by taking away the ! in data below with adding guard let
        guard let data = data else { return }
            
        let posts = try! JSONDecoder().decode([Post].self, from: data)
            
           
            // Using the Dispatch call allows to run they API while continue to use the app
            
            DispatchQueue.main.async {
                
                // complete the Post Array
                completion(posts)
            }
       
            
            
        }
        .resume()
    }
}
    
    
    

