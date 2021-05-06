//
//  TesingMapTabView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI

struct TestingMapTabView: View {
    @State private var selection = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {

            TabView(selection: $selection) {
                AllTestingMap().tabItem {
                    selection == 0 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")
                    Text("All")

                }
                .tag(0)
                CostFreeTestingMap().tabItem {
                    selection == 1 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")

                    Text("Free")

                }
                .tag(1)
                OnlineSchedulingMap().tabItem {
                    selection == 2 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")

                    Text("Online")
                }
                .tag(2)

                NoAppointmentRequiredMapView().tabItem {
                    selection == 3 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")

                    Text("No Appointment")
                }
                .tag(3)


                RapidTestingMap().tabItem {
                    selection == 4 ? Image(systemName: "mappin.circle.fill") : Image(systemName: "mappin.circle")

                    Text("Rapid")
                }
                .tag(4)
            }
            .accentColor(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))

            HStack {
                Button(action: {
                    selection = (selection - 1) % 6
                }) {
                    Text("Back")
                        .font(.system(.headline, design: .rounded))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
                        .cornerRadius(10.0)
                        .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 12)
                        .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.1), radius: 1, x: 0, y: 1)
                        .padding()

                }
                Spacer()

                Button(action: {
                    selection = (selection + 1) % 6
                }) {
                    Text("Next")
                        .font(.system(.headline, design: .rounded))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)))
                        .cornerRadius(10.0)
                        .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.2), radius: 10, x: 0, y: 12)
                        .shadow(color: Color(#colorLiteral(red: 0.7236627936, green: 0.6401972771, blue: 0.9966538548, alpha: 1)).opacity(0.1), radius: 1, x: 0, y: 1)
                        .padding()

                }
            }
            .offset(y: 100)
        }
    }
}

struct TestingMapTabView_Previews: PreviewProvider {
    static var previews: some View {
        TestingMapTabView()
    }
}
