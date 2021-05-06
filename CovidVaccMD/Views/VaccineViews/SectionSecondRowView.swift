//
//  SectionSecondRowView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SectionSecondRowView: View {
    var index: Int
    var section: SectionSecondRow
    var width: CGFloat = 275
    var height: CGFloat = 275
    @Binding var showFirstDoseList: Bool
  
    
    var body: some View {
   
        VStack {
            VStack {
                   
                    HStack(alignment: .top) {
                        Text(section.title)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: 225, alignment: .leading)
                            .frame(height: 100)
                            .padding(.top, 35)
                            .foregroundColor(.white)
                            .offset(x: 5)
                       
                        Button(action: {
                            withAnimation {
                                self.showFirstDoseList.toggle()
                            }
                            
                            
                            
                            
                        }) {
                            Image(systemName: "list.bullet.indent")
                                .foregroundColor(Color.red)
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 36, height: 36)
                                .background(Color("background3"))
                                .clipShape(Circle())
                                .padding(.top, 40)
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                            
                        }
                        .offset(x: -15)
                   
                        
                    }
                    section.text
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 75)
                        .offset(x: 20)
                    
            }
            

        
        ZStack(alignment: .bottom) {
            
                WebImage(url: section.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 125)
                }
                
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(Color(#colorLiteral(red: 0.1078877077, green: 0.5771551132, blue: 0.8123810887, alpha: 1)))
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.1078877077, green: 0.5771551132, blue: 0.8123810887, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
      
        
    }
}
