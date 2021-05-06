//
//  Cases.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 3/2/21.
//

import SwiftUI

struct Cases: View {
    @State var showProfile = false
    @State var showContent = false
    @State var showUpdate = false
    @State var viewState = CGSize.zero
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
    @State var show = false
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
   
    var body: some View {
        ZStack {
            
            Color("background2")
                .edgesIgnoringSafeArea(.all)
      
            HomeBackgroundView(showProfile: $showProfile)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            HomeCases(showProfile: $showProfile, showContent: $showContent, viewState: $viewState)
            
            
        }
    }
}

struct Cases_Previews: PreviewProvider {
    static var previews: some View {
        Cases()
    }
}
