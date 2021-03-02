//
//  Home.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    @State var showList = false
    @EnvironmentObject var user: UserStore
    @State var show = false
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
   
    

    
    var body: some View {
        
        ZStack {
            
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
      
            HomeBackgroundView(showProfile: $showProfile)

            
            
            

            HomeView(showProfile: $showProfile, showContent: $showContent, viewState: $viewState)

        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(UserStore())
    }
}



let screen = UIScreen.main.bounds



