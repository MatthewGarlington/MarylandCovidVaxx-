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
    @State var show = false
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
     
        ZStack {
            HomeBackgroundView(showProfile: $showProfile)
                .edgesIgnoringSafeArea(.all)

            HomeView(showProfile: $showProfile, showContent: $showContent, viewState: $viewState)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

let screen = UIScreen.main.bounds



