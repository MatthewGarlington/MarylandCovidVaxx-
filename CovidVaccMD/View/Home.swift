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

struct AvatarView: View {
    @Binding var showProfile: Bool
    // This gives a typew of the user which allows us to show different Avatars
    @EnvironmentObject var user: UserStore
    var body: some View {
        VStack {
            if user.isLogged {
                Button(action: { self.showProfile.toggle()}) {
                Image("Matthew")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
            }
            } else {
                Button(action: { self.user.showLogin.toggle()}) {
                Image(systemName: "person")
                    .foregroundColor(.primary)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 36, height: 36)
                    .background(Color("background3"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            }
                
            }
        }
    }
}

let screen = UIScreen.main.bounds

struct HomeBackgroundView: View {
    @Binding var showProfile: Bool
    
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            Spacer()
        }
        .background(Color("background1"))
        
        
        .clipShape(RoundedRectangle(cornerRadius: showProfile ? 30 : 0, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}

