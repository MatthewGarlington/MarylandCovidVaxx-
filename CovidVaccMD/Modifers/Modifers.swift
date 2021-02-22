//
//  Modifers.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI

struct ShadowModifer: ViewModifier {
    func body(content: Content) -> some View {
        
        content
        
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

struct FontModifer: ViewModifier {
    var style: Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
    }
    
}
struct CustomFontModifer: ViewModifier {
    var size: CGFloat = 28
    
    func body(content: Content) -> some View {
        
        content.font(.custom("WorkSans-Bold", size: size))
    }
    
}

extension String {
    func getDateFormatterForString(dateString: String) -> String {
        
       
        let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    let newString = dateFormatter.date(from: dateString)
            dateFormatter.dateStyle = .medium
    
    return dateFormatter.string(from: newString!)
    }
}



