//
//  ContentView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
 
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                        .speed(2)
//                        .repeatCount(4, autoreverses: false)
                )
            
            BackCardView()
                .frame(maxWidth: showCard ? 300 : CGFloat(340))
                .frame(height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))

            BackCardView()
                .frame(maxWidth: 340)
                .frame(height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
            
                
            
            CardView()
                .frame(maxWidth: showCard ? 375 : 340)
                .frame(height: 220)
                .background(Color.black)
  //              .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    showCard.toggle()
                  
                }
                .gesture(
                    
                    
                    DragGesture().onChanged { value in
                        
                        self.viewState = value.translation
                        self.show = true
                        
                        
                    }
                    
                    .onEnded { value in
                        
                        self.viewState = .zero
                        self.show = false
                        
                    }
                
                )
 
          
            GeometryReader { bounds in
                BottomCardView(show: $showCard)
                    // This adapts the offset to the screen height for the bottom card across different devices
                    .offset(x: 0, y: showCard ? bounds.size.height / 2 : bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom
                    )
                    .offset(y: bottomState.height)
                    .blur(radius: show ? 20 : 0)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                
                    .gesture(
                    
                        DragGesture().onChanged { value in
                            
                            self.bottomState = value.translation
                            
                            if self.showFull {
                            self.bottomState.height += -300
                            
                            
                            }
                            
                            if self.bottomState.height < -300 {
                                
                                self.bottomState.height = -600
                            }
                        }
                        
                        .onEnded { value in
                            
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                                
                                self.bottomState.height = -300
                                self.showFull = true
                                
                            } else {
                                
                                self.bottomState = .zero
                                self.showFull = false
                            }
                            
                        }
                    
                )
            }
   
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }.padding(20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
     
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
  
     
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: 375)
                Spacer()
            }
            .padding()
            
            Image("Background1")
            // Make the image resizable for different displays
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            
            Text("This certifcate is proof Matthew Garlington has achieved the UI Design course with approval from a Design+Code instructor")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.subheadline)
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78, show: $show)
                    .animation(Animation.easeInOut)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI").fontWeight(.bold)
                    
                    Text("12 of 12 sections completed\n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding()
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
                
            Spacer()
            
                
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        // Lets the bottom card with the Text Field to not take up the entire width of the screen
        .frame(maxWidth: 712)
        .frame(height: 800)
        // Adding the BlurView Modifer to give a glass appearance
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
        // This centers the change of the bottom card
        .frame(maxWidth: .infinity)
       
    }
}
