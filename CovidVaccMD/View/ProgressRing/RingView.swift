//
//  RingView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI

struct RingView: View {
    @ObservedObject var vaccineModel = TotalVaccineData()
    
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var width: CGFloat = 200
    var height: CGFloat = 200
    var percent: Double = 88.00
    @Binding var show: Bool

    
    
    var body: some View {
        
        let multipler = width / 44
        let progress = 1 - percent / 100
        
       return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multipler))
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: show ? CGFloat(progress) : CGFloat(Double(1)), to: CGFloat(Double(1)))
            .stroke(
                LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multipler, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20 ,0], dashPhase: 20))
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees:  180), axis: (x: 1, y: 0, z: 0))
            .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multipler, x: 0, y: 3 * multipler)
                .animation(.easeInOut)
            
        VStack(spacing: 0) {
            Text("\(Double(percent), specifier: "%.2f")%")
                    .font(.system(size: 10 * multipler))
                    .fontWeight(.bold)
                    .onTapGesture {
                        self.show.toggle()
                }
            
            
//            ForEach(vaccineModel.vaccinePercentChange.indices, id: \.self) { index in
//
//
//                PercentChangeTotalVaccine(index: index, percent: vaccineModel.vaccinePercentChange[index])
//                
//            }.offset(y: 15)
            
        }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}


struct RingView2: View {
    @ObservedObject var casesModel = CovidMasterModel()
    
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var width: CGFloat = 200
    var height: CGFloat = 200
    var percent: Double = 88.00
    @Binding var show: Bool

    
    
    var body: some View {
        
        let multipler = width / 44
        let progress = 1 - percent / 100
        
       return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multipler))
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: show ? CGFloat(progress) : CGFloat(Double(1)), to: CGFloat(Double(1)))
            .stroke(
                LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multipler, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20 ,0], dashPhase: 20))
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees:  180), axis: (x: 1, y: 0, z: 0))
            .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multipler, x: 0, y: 3 * multipler)
                .animation(.easeInOut)
            
        VStack(spacing: 0) {
            Text("\(Double(percent), specifier: "%.2f")%")
                    .font(.system(size: 10 * multipler))
                    .fontWeight(.bold)
                
                    .onTapGesture {
                        self.show.toggle()
                }
            
    
            ForEach(casesModel.percentChange.indices, id: \.self) { index in
             
                    
                PercentChangeView(index: index, percent: casesModel.percentChange[index])
                
            }.offset(y: 15)
            
        
            
        }
        }
    }
}

struct RingView2_Previews: PreviewProvider {
    static var previews: some View {
        RingView2(show: .constant(true))
    }
}
