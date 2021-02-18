//
//  Data.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI

struct Post: Codable, Identifiable {
    
    let id = UUID()
    var title: String
    var body: String
    
}

class Api {
    // The completion allows to return an array of the items in Post
    func getPosts(completion: @escaping ([Post]) -> ()) {
        
        // The URL used gives us fake json data useful for prototyping
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            
            // Prevent Crashing by taking away the ! in data below with adding guard let
            guard let data = data else { return }
            
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            
            
            // Using the Dispatch call allows to run they API while continue to use the app
            
            DispatchQueue.main.async {
                
                // complete the Post Array
                completion(posts)
            }
            
            
            
        }
        .resume()
    }
}


struct MDTotalVaccine: Codable, Hashable {
    
  
    let features: [Features]?
    
    
}

struct Features: Codable, Hashable {
    
   
    let attributes: Attributes?
}

struct Attributes: Codable, Hashable {
    
    
    
    let Metric: String?
    let Value: Double?
    
    
}


class TotalVaccineData: ObservableObject {
    
    @Published var sectionsRowTwo: [SectionSecondRow] = []
    @Published var sections: [Section] = []
    @Published var sectionsRowThree: [SectionThirdRow] = []
    @Published var recentMDVaccineTotals: MDTotalVaccine?
    
    let titles = ["Number 1st Dose Given", "24 Hour Change of 1st Doses Given:", "Percent of Population 1st Dose Received", "Number 2nd Dose Received", "24 Hour Change of 2nd Doses Given", "Percent of Population 2nd Dose Received", "All Doses Administered", "Doses Recieved", "All Dose Distributed", "1st Dose Distributed", "2nd Doses Distributed" , ""]
    var index2 = 0
    
    init() {
        
        
        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_COVID19_VaccinationMetrics/FeatureServer/0/query?where=1%3D1&outFields=Metric,Value&outSR=4326&f=json")!
        
        
        
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                return
            }
            
            // Parse JSON into newJSON struct using JSONDecoder
            //            guard let allVaccineJSON = try? JSONDecoder().decode(MDTotalVaccine?.self, from: data) else {
            //               print("Error: Couldn't decode data into all data in MD Info")
            //               return
            //             }
            ////
            //            print("gotten json response dictionary is \n \(allVaccineJSON)")
            // update UI using the response here
            
            DispatchQueue.main.async {
                
                do {
                    
               
                    
                    self.recentMDVaccineTotals = try JSONDecoder().decode(MDTotalVaccine?.self, from: data)
                    
               //     for vaccine in self.recentMDVaccineTotals?.features ?? [] {
//                        self.sections.append(Section(title:  self.titles[0],
//                                                     text: Text("\(self.recentMDVaccineTotals?.features?[0].attributes?.Value ?? 0, specifier: "%.0f")"),
//                                                     image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
//                                                     logo: #imageLiteral(resourceName: "Logo1"),
//                                                     color: .blue))
//
//                        self.sections.append(Section(title:  self.titles[1],
//                                                 text: Text("+\(self.recentMDVaccineTotals?.features?[1].attributes?.Value ?? 0, specifier: "%.0f")"),
//                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
//                                                 logo: #imageLiteral(resourceName: "Logo1"),
//                                                 color: .blue))
//                        self.sections.append(Section(title:  self.titles[2],
//                                             text: Text("\(self.recentMDVaccineTotals?.features?[2].attributes?.Value ?? 0, specifier: "%.2f")%"),
//                                             image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
//                                             logo: #imageLiteral(resourceName: "Logo1"),
//                                             color: .blue))
//                        self.sections.append(Section(title:  self.titles[3],
//                                             text: Text("\(self.recentMDVaccineTotals?.features?[3].attributes?.Value ?? 0, specifier: "%.0f")"),
//                                             image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
//                                             logo: #imageLiteral(resourceName: "Logo1"),
//                                             color: .blue))
//                        self.sections.append(Section(title:  self.titles[4],
//                                             text: Text("+\(self.recentMDVaccineTotals?.features?[4].attributes?.Value ?? 0, specifier: "%.0f")"),
//                                             image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
//                                             logo: #imageLiteral(resourceName: "Logo1"),
//                                             color: .blue))
//                        self.sections.append(Section(title:  self.titles[5],
//                                             text: Text("\(self.recentMDVaccineTotals?.features?[5].attributes?.Value ?? 0, specifier: "%.2f")%"),
//                                             image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
//                                             logo: #imageLiteral(resourceName: "Logo1"),
//                                             color: .blue))
                        self.sections.append(Section(title:  self.titles[6],
                                         text: Text("\(self.recentMDVaccineTotals?.features?[6].attributes?.Value ?? 0, specifier: "%.0f")"),
                                         image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                         logo: #imageLiteral(resourceName: "Logo1"),
                                         color: .blue))
                        self.sections.append(Section(title:  self.titles[7],
                                         text: Text("\(self.recentMDVaccineTotals?.features?[7].attributes?.Value ?? 0, specifier: "%.0f")"),
                                         image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                         logo: #imageLiteral(resourceName: "Logo1"),
                                         color: .blue))
                        self.sections.append(Section(title:  self.titles[8],
                                     text: Text("\(self.recentMDVaccineTotals?.features?[8].attributes?.Value ?? 0, specifier: "%.0f")"),
                                     image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                     logo: #imageLiteral(resourceName: "Logo1"),
                                     color: .blue))
//                        self.sections.append(Section(title:  self.titles[9],
//                                 text: Text("\(self.recentMDVaccineTotals?.features?[9].attributes?.Value ?? 0, specifier: "%.0f")"),
//                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
//                                 logo: #imageLiteral(resourceName: "Logo1"),
//                                 color: .blue))
//                        self.sections.append(Section(title:  self.titles[10],
//                             text: Text("\(self.recentMDVaccineTotals?.features?[10].attributes?.Value ?? 0, specifier: "%.0f")"),
//                             image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
//                             logo: #imageLiteral(resourceName: "Logo1"),
//                             color: .blue))
//
                        
                       // self.index2 = self.index2 + 1
                  //  }
                    
                    
              //      print(self.recentMDVaccineTotals?.features?.count)
                    
                    
                    //     for vaccine in self.recentMDVaccineTotals?.features ?? [] {
                             self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[0],
                                                          text: Text("\(self.recentMDVaccineTotals?.features?[0].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                          image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                          logo: #imageLiteral(resourceName: "Logo1"),
                                                          color: .blue))
     
                             self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[1],
                                                      text: Text("+\(self.recentMDVaccineTotals?.features?[1].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                      image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                      logo: #imageLiteral(resourceName: "Logo1"),
                                                      color: .blue))
                             self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[2],
                                                  text: Text("\(self.recentMDVaccineTotals?.features?[2].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                  image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                  logo: #imageLiteral(resourceName: "Logo1"),
                                                  color: .blue))
                    
                    
                            
                            self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[3],
                                                                 text: Text("\(self.recentMDVaccineTotals?.features?[3].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                            self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[4],
                                                                 text: Text("+\(self.recentMDVaccineTotals?.features?[4].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                            self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[5],
                                                                 text: Text("\(self.recentMDVaccineTotals?.features?[5].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                                 image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    
                    
                } catch let jsonError {
                    
                    print("Decoding failed for Vaccine Data", jsonError)
                }
            }
            
            
        }
        
        
        // execute the HTTP request
        task.resume()
        
    }
}





