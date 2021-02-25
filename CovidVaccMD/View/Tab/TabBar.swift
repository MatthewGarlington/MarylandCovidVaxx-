//
//  TabBar.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI

struct TabBar: View {

    var body: some View {
        TabView {
       
               
                    CasesView(showProfile: .constant(false), showContent: .constant(false), viewState: .constant(.zero)).environmentObject(UserStore())
                    .tabItem {
                        Image(systemName: "cross.circle.fill")
                        Text("All Stats")
                    }
               
                        Home().tabItem {
                    Image(systemName: "cross.case.fill")
                    Text("Vaccine")
                }
                
            
        }
        //.edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar().environmentObject(UserStore())
    }
}

