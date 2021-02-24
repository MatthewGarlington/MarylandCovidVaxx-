//
//  MapView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/19/21.
//

import SwiftUI
import MapKit


struct MapViewMaryland: UIViewRepresentable {
    
    //var annotations: MKPointAnnotation?
    
    @ObservedObject var vm = VaccineLocationsModel()
    @ObservedObject var massVaccinationsitesViewModel = MassVaccinationViewModel()
    @ObservedObject var retailVaccinationsViewModel = RetailVaccinationViewModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsArray: [MKPointAnnotation]
    @Binding var pinsMassArray: [MKPointAnnotation]
    @Binding var pinsRetailArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.045753, longitude: -76.641273), latitudinalMeters: CLLocationDistance(exactly: 300000)!, longitudinalMeters: CLLocationDistance(exactly: 300000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.delegate = context.coordinator
        

     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        
        for i in stride(from: 0, through: (((vm.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pointAnnotation = MKPointAnnotation()
            
           


            pointAnnotation.title = vm.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude:(vm.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (vm.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pointAnnotation.subtitle = vm.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pointAnnotation)
              
            
        }
        
        for i in stride(from: 0, through: (((massVaccinationsitesViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pointAnnotation = MKPointAnnotation()
            
           


            pointAnnotation.title = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude:(massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pointAnnotation.subtitle = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pointAnnotation)
              
            
        }
        
        for i in stride(from: 0, through: (((retailVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pointAnnotation = MKPointAnnotation()
            
           


            pointAnnotation.title = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude:(retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pointAnnotation.subtitle = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pointAnnotation)
              
            
        }
        
             
        view.addAnnotations(pinsArray)
        view.addAnnotations(pinsMassArray)
                

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewMaryland

        init(_ parent: MapViewMaryland) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {
        //    parent.centerCoordinate = view.centerCoordinate
          //  parent.region = view.region
             
            
          
         
        }
        
  
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if !(annotation is MKUserLocation) {
                let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))

                let rightButton = UIButton(type: .detailDisclosure)
                pinView.rightCalloutAccessoryView = rightButton
                pinView.animatesDrop = false
                pinView.canShowCallout = true
             
              
             
               
                
                

                return pinView
            }
            else {
                return nil
            }
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            guard let placemark = view.annotation as? MKPointAnnotation? else { return }
            

            parent.selectedPlace = placemark
            parent.showingPlaceDetails = true
        }
        
        
    }
    
    
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Baltimore"
        annotation.subtitle = "Maryland"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 39.045753, longitude: -76.641273)
        return annotation
        
        
    }
}
extension MKPointAnnotation {
    static var exampleArray: [MKPointAnnotation] {
        let annotation = [MKPointAnnotation]()
        
    

        return annotation
        
        
    }
}



struct MapViewMaryland_Previews: PreviewProvider {
    static var previews: some View {
        MapViewMaryland(annotations: .constant(MKPointAnnotation.exampleArray), pinsArray: .constant(MKPointAnnotation.exampleArray), pinsMassArray: .constant(MKPointAnnotation.exampleArray), pinsRetailArray: .constant(MKPointAnnotation.exampleArray), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails:  .constant(true))
    }
}
