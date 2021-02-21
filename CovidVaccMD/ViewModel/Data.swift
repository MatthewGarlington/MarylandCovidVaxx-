//
//  Data.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI
import MapKit



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






class VaccineLocationsModel: ObservableObject {
    
    
    @Published var vaccineLocationsMD: MDVaccineLocations?
    
    
    
    
    init() {
        
        
        
        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MD_Vaccination_Locations/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json")!
        
        
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
            //            guard let locationVaccine = try? JSONDecoder().decode(MDVaccineLocations.self, from: data) else {
            //               print("Error: Couldn't decode data into all data in MD Info")
            //               return
            //             }
            ////
            //            print("gotten json response dictionary is \n \(locationVaccine)")
            // update UI using the response here
            
            DispatchQueue.main.async {
                
                do {
                    
                    self.vaccineLocationsMD = try JSONDecoder().decode(MDVaccineLocations?.self, from: data)
                    
                    
                    
                    
                    print(self.vaccineLocationsMD?.features?[0].geometry?.coordinate)
                    
                    
                } catch let jsonError {
                    
                    print("Decoding failed for UserDetails", jsonError)
                }
            }
            
            
        }
        
        
        // execute the HTTP request
        task.resume()
        
    }
}


class TotalVaccineData: ObservableObject {
    
    @Published var sectionsRowTwo: [SectionSecondRow] = []
    @Published var sections: [Section] = []
    @Published var sectionsRowThree: [SectionThirdRow] = []
    @Published var ringView: [RingView] = []
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
                    
                    // First Row
                    
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
                    
                    
                    
                    // Second Row
                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[0],
                                                                text: Text("\(self.recentMDVaccineTotals?.features?[0].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))
                    
                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[1],
                                                                text: Text("+\(self.recentMDVaccineTotals?.features?[1].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))
                    self.sectionsRowTwo.append(SectionSecondRow(title:  self.titles[2],
                                                                text: Text("\(self.recentMDVaccineTotals?.features?[2].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                                image: URL(string: "https://khn.org/wp-content/uploads/sites/2/2020/12/GettyImages-1263990592_1350.jpg?w=1270")!,
                                                                logo: #imageLiteral(resourceName: "Logo1"),
                                                                color: .blue))
                    
                    
                    // Third Row
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[3],
                                                                 text: Text("\(self.recentMDVaccineTotals?.features?[3].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[4],
                                                                 text: Text("+\(self.recentMDVaccineTotals?.features?[4].attributes?.Value ?? 0, specifier: "%.0f")"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
                                                                 logo: #imageLiteral(resourceName: "Logo1"),
                                                                 color: .blue))
                    self.sectionsRowThree.append(SectionThirdRow(title:  self.titles[5],
                                                                 text: Text("\(self.recentMDVaccineTotals?.features?[5].attributes?.Value ?? 0, specifier: "%.2f")%"),
                                                                 image: URL(string: "https://labblog.uofmhealth.org/sites/lab/files/2020-08/CovidVaccineBlog_0.jpg")!,
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





