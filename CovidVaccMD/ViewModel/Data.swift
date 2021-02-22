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


struct MDHeader: Codable, Hashable {
    
    let filter: String?
    let reportdate: String?
    let totalcases: String?
    let casedelta: String?
    let totaltests: String?
    let testsdelta: String?
    let postestpercent: String?
    let pospercentdiff: String?
    let negativetests: String?
    let negdelta: String?
    let bedstotal: String?
    let bedsacute: String?
    let bedsicu: String?
    let bedsdelta: String?
    let total_hospitalized: String?
    let hospitalizeddelta: String?
    let total_released: String?
    let releaseddelta: String?
    
}

struct MDCases: Codable, Hashable {
  
    let alle: String?
    let anne: String?
    let balt: String?
    let bcity: String?
    let calv: String?
    let caro: String?
    let carr: String?
    let ceci: String?
    let char: String?
    let dorc: String?
    let fred: String?
    let garr: String?
    let harf: String?
    let howa: String?
    let kent: String?
    let mont: String?
    let prin: String?
    let quee: String?
    let some: String?
    let stma: String?
    let talb: String?
    let wash: String?
    let wico: String?
    let worc: String?
    let case0to9: String?
    let case10to19: String?
    let case20to29: String?
    let case30to39: String?
    let case40to49: String?
    let case50to59: String?
    let case60to69: String?
    let case70to79: String?
    let case80plus: String?
    let genmale: String?
    let genfemale: String?
    let caseaframer: String?
    let casewhite: String?
    let casehispanic: String?
    let caseasian: String?
    let caseother: String?
    
    
}

struct MDDataDeath: Codable, Hashable {
    let filter: String?
    let deathsdelta: String?
    let deaths: String?
    let deathdod: String?
    let deathalle: String?
    let deathanne: String?
    let deathbalt: String?
    let deathbcity: String?
    let deathcalv: String?
    let deathcaro: String?
    let deathcarr: String?
    let deathceci: String?
    let deathchar: String?
    let deathdorc: String?
    let deathfred: String?
    let deathgarr: String?
    let deathharf: String?
    let deathhowa: String?
    let deathkent: String?
    let deathmont: String?
    let deathprin: String?
    let deathquee: String?
    let deathsome: String?
    let deathstma: String?
    let deathtalb: String?
    let deathwash: String?
    let deathwico: String?
    let deathworc: String?
    let deathunkn: String?
    let death0to9: String?
    let death10to19: String?
    let death20to29: String?
    let death30to39: String?
    let death40to49: String?
    let death50to59: String?
    let death60to69: String?
    let death70to79: String?
    let death80plus: String?
    let deathgenmale: String?
    let deathgenfemale: String?
    let deathaframer: String?
    let deathwhite: String?
    let deathhispanic: String?
    let deathasian: String?
    let deathother: String?
    let deathnotavail: String?
    
}




struct MDPositiveCases: Codable, Hashable {
    
    
    let features: [CaseFeatures]?
    
    
}

struct CaseFeatures: Codable, Hashable {
    
    
    let attributes: CaseAttributes?
}

struct CaseAttributes: Codable, Hashable {
    
    
    
    let date: Int?
    let number_of_tests: Int?
    let number_of_positives: Int?
    let percent_positive: Double?
    let rolling_avg: Double?
    
    
}



class PositiveCasesViewModel: ObservableObject {
    
    
    @Published var positiveCases: MDPositiveCases?
  //  @Published var caseRing: [CaseRing] = []
    
    
    
    
    init() {
        
        
        
        let url = URL(string: "https://services.arcgis.com/njFNhDsUCentVYJW/arcgis/rest/services/MDCOVID19_TestingVolume/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json")!
        
        
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
//                        guard let positiveCases = try? JSONDecoder().decode(MDPositiveCases?.self, from: data) else {
//                           print("Error: Couldn't decode data into all data in MD Info")
//                           return
//                         }
//            //
//                        print("gotten json response dictionary is \n \(positiveCases)")
            // update UI using the response here
//
            DispatchQueue.main.async {

                do {
                    
                    

                    self.positiveCases = try JSONDecoder().decode(MDPositiveCases?.self, from: data)
                    
                    let epochTime2 = TimeInterval((self.positiveCases?.features?[(self.positiveCases?.features!.count)! - 1].attributes?.date ?? 0)) / 1000
                    let date2 = Date(timeIntervalSince1970: epochTime2)
                    let formate = date2.getFormattedDate(format: "MM-dd-yyyy")
                    

                   // print(formate)

                } catch let jsonError {

                    print("Decoding failed for UserDetails", jsonError)
                }
            }
            
            
        }
        
        
        // execute the HTTP request
        task.resume()
        
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


class CovidMasterModel: ObservableObject {
    
    
    @Published var allMDHeader = [MDHeader]()
    @Published var allDeaths = [MDDataDeath]()
    @Published var allMDCases = [MDCases]()
    @Published var casesRowOne: [CasesRowOne] = []
    @Published var hospitalRowTwo: [HospitalRow] = []
    
    
    init() {
        
        
        
        let url = URL(string: "https://opendata.maryland.gov/resource/mgd3-qk8t.json")!
        
        
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
//                        guard let locationVaccine = try? JSONDecoder().decode([MDHeader].self, from: data) else {
//                           print("Error: Couldn't decode data into all data in MD Info")
//                           return
//                         }
//            //
//                        print("gotten json response dictionary is \n \(locationVaccine)")
            // update UI using the response here
            
            DispatchQueue.main.async {

                do {

                    self.allMDHeader = try JSONDecoder().decode([MDHeader].self, from: data)
                    self.allMDCases = try JSONDecoder().decode([MDCases].self, from: data)
                    self.allDeaths = try JSONDecoder().decode([MDDataDeath].self, from: data)
     
                
                    // This will be the Total Row
                    
                    self.casesRowOne.append(CasesRowOne(title: "Total Cases",
                                                        text: "\(self.allMDHeader[self.allMDHeader.count - 1].totalcases ?? "")",
                                                        image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))
                    
                    self.casesRowOne.append(CasesRowOne(title: "24 Hour Change in Cases",
                                                        text: "+\(self.allMDHeader[self.allMDHeader.count - 1].casedelta ?? "")",
                                                        image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))
                    
                    
                    
                    self.hospitalRowTwo.append(HospitalRow(title: "Total Hospitalized",
                                                        text: "\(self.allMDHeader[self.allMDHeader.count - 1].total_hospitalized ?? "")",
                                                        image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))
                    
                    self.hospitalRowTwo.append(HospitalRow(title: "24 Hour Change in Hospitalizations",
                                                        text: "+\(self.allMDHeader[self.allMDHeader.count - 1].hospitalizeddelta ?? "")",
                                                        image: URL(string: "https://static.vecteezy.com/system/resources/previews/000/952/527/non_2x/coronavirus-character-get-vaccination-vector.jpg")!,
                                                        logo: #imageLiteral(resourceName: "Logo1"),
                                                        color: .blue))
                    
                    
                    
                    
                    

                } catch let jsonError {

                    print("Decoding failed for All Maryland Covid Data", jsonError)
                }
            }
            
            
        }
        
        
        // execute the HTTP request
        task.resume()
        
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





