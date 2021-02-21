//
//  UpdateList.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI
import SDWebImageSwiftUI
//
//struct UpdateList: View {
//    
//    @ObservedObject var store = UpdateStore()
//    
//    func addUpdate() {
//        store.updates.append(Update(image: "Card1", title: "New Item", text: "Text", date: "Jan 1"))
//    }
//    
//    var body: some View {
//       NavigationView {
//            
//            List {
//                ForEach(store.updates) { update in
//                    NavigationLink(destination: UpdateDetail(update: update)) {
//                        
//                        HStack {
//                            
//                            Image(update.image)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                                .background(Color.black)
//                                .cornerRadius(20)
//                                .padding(.trailing, 4)
//                            
//                            
//                            VStack(alignment: .leading, spacing: 8.0) {
//                                
//                                Text(update.title)
//                                    .font(.system(size: 20, weight: .bold))
//                                    
//                                
//                                Text(update.text)
//                                    .lineLimit(2)
//                                    .font(.subheadline)
//                                
//                
//                                
//                                Text(update.date)
//                                    .font(.caption)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.secondary)
//                                    
//                                
//                            }
//                        }
//                        .padding(.vertical, 8)
//                    }
//                }
//                .onDelete { index in
//                    self.store.updates.remove(at: index.first!)
//                    
//                }
//                .onMove { (source: IndexSet, destination: Int) in
//                    
//                    self.store.updates.move(fromOffsets: source, toOffset: destination)
//                    
//                    
//                }
//            }
//            .navigationBarTitle(Text("Updates"))
//            .navigationBarItems(leading: Button(action: addUpdate) {
//                Text("Add Update")
//            }, trailing: EditButton())
//        }
//        
//    }
//}
//
//struct UpdateList_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateList()
//    }
//}
//
struct Update: Identifiable {
    
    var id = UUID()
    var image: URL
    var title: String
    var text: String
    var date: String
    
}



let updateData = [
    Update(image:  URL(string: "https://image.freepik.com/free-vector/coronavirus-covid-19-medical-background-with-technology-styled-schematic-grid-viruses-floating-blue-purple-scientific-abstraction_116953-976.jpg")!, title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),


]
