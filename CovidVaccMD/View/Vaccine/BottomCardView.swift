//
//  BottomCardView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI

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
