//
//  PostList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//


import SwiftUI

struct PostList: View {
    
    @ObservedObject var store = DataStore()
 
    
    var body: some View {
        // Adding the list with a number of items that the API gives us using combine to represent data through the DataStore
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title).font(.system(.title, design: .serif)).bold()
                
                Text(post.body).font(.subheadline).foregroundColor(.secondary)
            }
  
            }
        

        }
    }


struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}


//// This Adds the ability to view the API Data before adding the combine method
//.onAppear {
//
//    // Adding the posts array and the State var allows us to manipulate the data given to us from the API
//
//    Api().getPosts { (posts) in
//
//        // Adding the posts to the State posts
//        self.posts = posts
//    }
// }
