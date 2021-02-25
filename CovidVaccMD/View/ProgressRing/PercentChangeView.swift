//
//  PercentChangeView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI

struct PercentChangeView: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var percent: PercentDifferenceRow

  
  
    
    var body: some View {
      
                  Text(percent.text)
                    .font(.caption)
                    .foregroundColor(.secondary)

    }
}

struct PercentChangeTotalVaccine: View {
    @ObservedObject var store = CourseStore()
    var index: Int
    var percent: VaccinePercentDifferenceRow

  
  
    
    var body: some View {
      
                  Text(percent.text)
                    .font(.caption)
                    .foregroundColor(.secondary)

    }
}
