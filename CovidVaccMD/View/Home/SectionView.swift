//
//  SectionView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SectionView: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
  
    
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
                        Spacer()
                    //    Image(uiImage: section.logo)
                        
                    }
                    section.text
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 75)
                    
                }
            

        
        ZStack(alignment: .bottom) {
            
                WebImage(url: section.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                   //.padding(.bottom, 20)
                   //.blendMode(.darken)
                }
                
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
      
        
    }
}