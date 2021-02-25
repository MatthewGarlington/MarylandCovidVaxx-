//
//  CaseView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CaseView: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var cases: CasesRowOne
    var width: CGFloat = 275
    var height: CGFloat = 275
    @State var showCaseList = false
  
    
    var body: some View {
   
        VStack {
            VStack {
                   
                    HStack(alignment: .top) {
                        HStack {
                            Text(cases.title)
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 200, alignment: .leading)
                                .frame(height: 100)
                                .padding(.top, 40)
                                .foregroundColor(.white)
                            
                            Button(action: {self.showCaseList.toggle()}) {
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
                            .sheet(isPresented: $showCaseList) {
                                
                                CasesList()
                          
                            }
                        }
             
          
                        
                    }
                  Text(cases.text)
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 50)
                    .padding(.bottom, 10)
                    
                }
            

        
        ZStack(alignment: .bottom) {
            
                WebImage(url: cases.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
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




