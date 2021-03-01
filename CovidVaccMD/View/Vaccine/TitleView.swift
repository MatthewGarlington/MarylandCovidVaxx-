//
//  TitleView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/22/21.
//

import SwiftUI

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
