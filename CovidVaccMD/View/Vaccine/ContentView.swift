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
 
//          
//            GeometryReader { bounds in
//                BottomCardView(show: $showCard)
//                    // This adapts the offset to the screen height for the bottom card across different devices
//                    .offset(x: 0, y: showCard ? bounds.size.height / 2 : bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom
//                    )
//                    .offset(y: bottomState.height)
//                    .blur(radius: show ? 20 : 0)
//                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
//                
//                    .gesture(
//                    
//                        DragGesture().onChanged { value in
//                            
//                            self.bottomState = value.translation
//                            
//                            if self.showFull {
//                            self.bottomState.height += -300
//                            
//                            
//                            }
//                            
//                            if self.bottomState.height < -300 {
//                                
//                                self.bottomState.height = -600
//                            }
//                        }
//                        
//                        .onEnded { value in
//                            
//                            if self.bottomState.height > 50 {
//                                self.showCard = false
//                            }
//                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
//                                
//                                self.bottomState.height = -300
//                                self.showFull = true
//                                
//                            } else {
//                                
//                                self.bottomState = .zero
//                                self.showFull = false
//                            }
//                            
//                        }
//                    
//                )
//            }
   
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







