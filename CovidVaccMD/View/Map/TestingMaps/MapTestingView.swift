//
//  MapTestingView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI
import MapKit

// All Testing Locations Map View

struct MapTestingView: UIViewRepresentable {
    @ObservedObject var allTestingLocations = AllTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsAllTesting: [MKPointAnnotation]
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

        
        for i in stride(from: 0, through: (((allTestingLocations.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsAllTesting = MKPointAnnotation()
            
           


            pinsAllTesting.title = allTestingLocations.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsAllTesting.coordinate = CLLocationCoordinate2D(latitude:(allTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (allTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsAllTesting.subtitle = allTestingLocations.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsAllTesting)
              
            
        }
        
  
        
     

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapTestingView

        init(_ parent: MapTestingView) {
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


struct MapTestingView_Previews: PreviewProvider {
    static var previews: some View {
        MapTestingView(annotations: .constant(MKPointAnnotation.exampleArray), pinsAllTesting: .constant(MKPointAnnotation.exampleArray), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(true))
    }
}



// Cost Free Testing Map View
struct CostFreeTestingView: UIViewRepresentable {
    @ObservedObject var costFreeTestingLocations = CostFreeTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsCostFreeTesting: [MKPointAnnotation]
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

        
        for i in stride(from: 0, through: (((costFreeTestingLocations.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsCostFreeTesting = MKPointAnnotation()
            
           


            pinsCostFreeTesting.title = costFreeTestingLocations.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsCostFreeTesting.coordinate = CLLocationCoordinate2D(latitude:(costFreeTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (costFreeTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsCostFreeTesting.subtitle = costFreeTestingLocations.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsCostFreeTesting)
              
            
        }
        
  
        
     

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CostFreeTestingView

        init(_ parent: CostFreeTestingView) {
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


struct CostFreeTestingView_Previews: PreviewProvider {
    static var previews: some View {
        CostFreeTestingView(annotations: .constant(MKPointAnnotation.exampleArray), pinsCostFreeTesting: .constant(MKPointAnnotation.exampleArray), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(true))
    }
}


// Online Scheduling Testing Map View
struct OnlineSchedulingTestingView: UIViewRepresentable {
    @ObservedObject var onlineSchedulingTestingLocations = OnlineSchedulingTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsOnlineTesting: [MKPointAnnotation]
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

        
        for i in stride(from: 0, through: (((onlineSchedulingTestingLocations.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsOnlineTesting = MKPointAnnotation()
            
           


            pinsOnlineTesting.title = onlineSchedulingTestingLocations.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsOnlineTesting.coordinate = CLLocationCoordinate2D(latitude:(onlineSchedulingTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (onlineSchedulingTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsOnlineTesting.subtitle = onlineSchedulingTestingLocations.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsOnlineTesting)
              
            
        }
        
  
        
     

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: OnlineSchedulingTestingView

        init(_ parent: OnlineSchedulingTestingView) {
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


struct OnlineSchedulingTestingView_Previews: PreviewProvider {
    static var previews: some View {
        OnlineSchedulingTestingView(annotations: .constant(MKPointAnnotation.exampleArray), pinsOnlineTesting: .constant(MKPointAnnotation.exampleArray), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(true))
    }
}

// No Appointment Required Testing Map View
struct NoAppointmentRequiredTestingView: UIViewRepresentable {
    @ObservedObject var noAppointmentRequiredeTestingLocations = NoAppointmentRequiredTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsNoAppointment: [MKPointAnnotation]
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

        
        for i in stride(from: 0, through: (((noAppointmentRequiredeTestingLocations.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsNoAppointment = MKPointAnnotation()
            
           


            pinsNoAppointment.title = noAppointmentRequiredeTestingLocations.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsNoAppointment.coordinate = CLLocationCoordinate2D(latitude:(noAppointmentRequiredeTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (noAppointmentRequiredeTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsNoAppointment.subtitle = noAppointmentRequiredeTestingLocations.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsNoAppointment)
              
            
        }
        
  
        
     

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: NoAppointmentRequiredTestingView

        init(_ parent: NoAppointmentRequiredTestingView) {
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


struct NoAppointmentRequiredTestingView_Previews: PreviewProvider {
    static var previews: some View {
        NoAppointmentRequiredTestingView(annotations: .constant(MKPointAnnotation.exampleArray), pinsNoAppointment: .constant(MKPointAnnotation.exampleArray), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(true))
    }
}

// Peds Testing Map View
struct PedsTestingMapView: UIViewRepresentable {
    @ObservedObject var pedsTestingLocations = PedsTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsPedsTesting: [MKPointAnnotation]
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

        
        for i in stride(from: 0, through: (((pedsTestingLocations.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsPedsTesting = MKPointAnnotation()
            
           


            pinsPedsTesting.title = pedsTestingLocations.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsPedsTesting.coordinate = CLLocationCoordinate2D(latitude:(pedsTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (pedsTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsPedsTesting.subtitle = pedsTestingLocations.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsPedsTesting)
              
            
        }
        
  
        
     

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: PedsTestingMapView

        init(_ parent: PedsTestingMapView) {
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


struct PedsTestingMapView_Previews: PreviewProvider {
    static var previews: some View {
        PedsTestingMapView(annotations: .constant(MKPointAnnotation.exampleArray), pinsPedsTesting: .constant(MKPointAnnotation.exampleArray), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(true))
    }
}

// Rapid Testing Map View
struct RapidTestingMapView: UIViewRepresentable {
    @ObservedObject var rapidTestingLocations = RapidTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsRapidTesting: [MKPointAnnotation]
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

        
        for i in stride(from: 0, through: (((rapidTestingLocations.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsRapidTesting = MKPointAnnotation()
            
           


            pinsRapidTesting.title = rapidTestingLocations.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsRapidTesting.coordinate = CLLocationCoordinate2D(latitude:(rapidTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (rapidTestingLocations.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsRapidTesting.subtitle = rapidTestingLocations.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsRapidTesting)
              
            
        }
        
  
        
     

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: RapidTestingMapView

        init(_ parent: RapidTestingMapView) {
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


struct RapidTestingMapView_Previews: PreviewProvider {
    static var previews: some View {
        RapidTestingMapView(annotations: .constant(MKPointAnnotation.exampleArray), pinsRapidTesting: .constant(MKPointAnnotation.exampleArray), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(true))
    }
}

