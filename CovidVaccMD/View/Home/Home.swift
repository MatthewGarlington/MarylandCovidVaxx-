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
   // @ObservedObject var casesModel = CovidMasterModel()
   
    

    
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
            
            
            

            HomeView(showProfile: $showProfile, showContent: $showContent, viewState: $viewState)


            
          //   Direct the user to the login screen if a profile is not logged into
            if user.showLogin {

                ZStack {
                

                    VStack {
                        HStack {
                            Spacer()

                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        self.user.showLogin = false
                    }
                }
            }
            
            if showContent {
                
                BlurView(style: .systemMaterial).ignoresSafeArea(edges: .bottom)
                
                ContentView()
          
              
                VStack {
                    HStack {
                        Spacer()
                      
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    self.showContent = false
                }
                
         
            }
            
  
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



