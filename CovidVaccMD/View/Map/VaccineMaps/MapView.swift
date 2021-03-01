//
//  MapView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/19/21.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine



struct MapViewMaryland: UIViewRepresentable {
    
  
    @ObservedObject var localHealthVaccineLocations = LocalHealthVaccineLocationsModel()
    @ObservedObject var massVaccinationsitesViewModel = MassVaccinationViewModel()
    @ObservedObject var retailVaccinationsViewModel = RetailVaccinationViewModel()
    @ObservedObject var hospitalVaccinationsViewModel = HospitalVaccineLocationsModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsLocalHealthArray: [MKPointAnnotation]
    @Binding var pinsHospitalArray: [MKPointAnnotation]
    @Binding var pinsMassArray: [MKPointAnnotation]
    @Binding var pinsRetailArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()
   
  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.045753, longitude: -76.641273), latitudinalMeters: CLLocationDistance(exactly: 300000)!, longitudinalMeters: CLLocationDistance(exactly: 300000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.delegate = context.coordinator
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
       
  
 
        for i in stride(from: 0, through: (((massVaccinationsitesViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsMassArray = MKPointAnnotation()
            
           


            pinsMassArray.title = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsMassArray.coordinate = CLLocationCoordinate2D(latitude:(massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsMassArray.subtitle = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsMassArray)
              
            
        }
        
        for i in stride(from: 0, through: (((retailVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsRetailArray = MKPointAnnotation()
            
           


            pinsRetailArray.title = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsRetailArray.coordinate = CLLocationCoordinate2D(latitude:(retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsRetailArray.subtitle = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsRetailArray)
              
            
        }
        
        for i in stride(from: 0, through: (((hospitalVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsHospitalArray = MKPointAnnotation()
            
           


            pinsHospitalArray.title = hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsHospitalArray.coordinate = CLLocationCoordinate2D(latitude:(hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsHospitalArray.subtitle = hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsHospitalArray)
              
            
        }
        
             
     
                

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



struct MapViewMarylandUserLocationEnabled: UIViewRepresentable {
    
  
    @ObservedObject var localHealthVaccineLocations = LocalHealthVaccineLocationsModel()
    @ObservedObject var massVaccinationsitesViewModel = MassVaccinationViewModel()
    @ObservedObject var retailVaccinationsViewModel = RetailVaccinationViewModel()
    @ObservedObject var hospitalVaccinationsViewModel = HospitalVaccineLocationsModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsLocalHealthArray: [MKPointAnnotation]
    @Binding var pinsHospitalArray: [MKPointAnnotation]
    @Binding var pinsMassArray: [MKPointAnnotation]
    @Binding var pinsRetailArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()
   
  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        
        
        return mapView

    }

    func updateUIView(_ view: MKMapView, context: Context) {
        
        view.showsUserLocation = true
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
        
 
 
        for i in stride(from: 0, through: (((massVaccinationsitesViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsMassArray = MKPointAnnotation()
            
           


            pinsMassArray.title = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsMassArray.coordinate = CLLocationCoordinate2D(latitude:(massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsMassArray.subtitle = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsMassArray)
              
            
        }
        
        for i in stride(from: 0, through: (((retailVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsRetailArray = MKPointAnnotation()
            
           


            pinsRetailArray.title = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsRetailArray.coordinate = CLLocationCoordinate2D(latitude:(retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsRetailArray.subtitle = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsRetailArray)
              
            
        }
        
        for i in stride(from: 0, through: (((hospitalVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsHospitalArray = MKPointAnnotation()
            
           


            pinsHospitalArray.title = hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsHospitalArray.coordinate = CLLocationCoordinate2D(latitude:(hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsHospitalArray.subtitle = hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsHospitalArray)
              
            
        }
        
             
     
                

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewMarylandUserLocationEnabled

        init(_ parent: MapViewMarylandUserLocationEnabled) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {
    

         
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



struct HospitalMapViewMaryland: UIViewRepresentable {
    

    @ObservedObject var hospitalVaccinationsViewModel = HospitalVaccineLocationsModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsHospitalArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()
   

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.045753, longitude: -76.641273), latitudinalMeters: CLLocationDistance(exactly: 300000)!, longitudinalMeters: CLLocationDistance(exactly: 300000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.delegate = context.coordinator
        

     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

              
        
        for i in stride(from: 0, through: (((hospitalVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsHospitalArray = MKPointAnnotation()
            
           


            pinsHospitalArray.title = hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsHospitalArray.coordinate = CLLocationCoordinate2D(latitude:(hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsHospitalArray.subtitle = hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsHospitalArray)
              
            
        }

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

  
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: HospitalMapViewMaryland

        init(_ parent: HospitalMapViewMaryland) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {
     
      
             
            
          
         
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

struct HospitalMapViewMarylandWithUserLocations: UIViewRepresentable {
    

    @ObservedObject var hospitalVaccinationsViewModel = HospitalVaccineLocationsModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsHospitalArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()
   

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        
        

     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        view.showsUserLocation = true
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
      
              
        
        for i in stride(from: 0, through: (((hospitalVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsHospitalArray = MKPointAnnotation()
            
           


            pinsHospitalArray.title = hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsHospitalArray.coordinate = CLLocationCoordinate2D(latitude:(hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsHospitalArray.subtitle = hospitalVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsHospitalArray)
              
            
        }

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

  
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: HospitalMapViewMarylandWithUserLocations

        init(_ parent: HospitalMapViewMarylandWithUserLocations) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {
     
      
             
            
          
         
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

struct RetailMapViewMaryland: UIViewRepresentable {
    

    @ObservedObject var retailVaccinationsViewModel = RetailVaccinationViewModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsRetailArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.045753, longitude: -76.641273), latitudinalMeters: CLLocationDistance(exactly: 300000)!, longitudinalMeters: CLLocationDistance(exactly: 300000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.delegate = context.coordinator
        

     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

   
        
        for i in stride(from: 0, through: (((retailVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsRetailArray = MKPointAnnotation()
            
           


            pinsRetailArray.title = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsRetailArray.coordinate = CLLocationCoordinate2D(latitude:(retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsRetailArray.subtitle = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsRetailArray)
              
            
        }
        
    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: RetailMapViewMaryland

        init(_ parent: RetailMapViewMaryland) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {
  
          
         
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

struct RetailMapViewMarylandWithUserLocation: UIViewRepresentable {
    

    @ObservedObject var retailVaccinationsViewModel = RetailVaccinationViewModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsRetailArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()

        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        

     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        view.showsUserLocation = true
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
        
        for i in stride(from: 0, through: (((retailVaccinationsViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsRetailArray = MKPointAnnotation()
            
           


            pinsRetailArray.title = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsRetailArray.coordinate = CLLocationCoordinate2D(latitude:(retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsRetailArray.subtitle = retailVaccinationsViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsRetailArray)
              
            
        }
        
    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: RetailMapViewMarylandWithUserLocation

        init(_ parent: RetailMapViewMarylandWithUserLocation) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {
  
          
         
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



struct MassMapViewMaryland: UIViewRepresentable {
    

    @ObservedObject var massVaccinationsitesViewModel = MassVaccinationViewModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsMassArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.045753, longitude: -76.641273), latitudinalMeters: CLLocationDistance(exactly: 300000)!, longitudinalMeters: CLLocationDistance(exactly: 300000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.delegate = context.coordinator
     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        
        for i in stride(from: 0, through: (((massVaccinationsitesViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsMassArray = MKPointAnnotation()
            
           


            pinsMassArray.title = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsMassArray.coordinate = CLLocationCoordinate2D(latitude:(massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsMassArray.subtitle = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsMassArray)
              
            
        }
        
             
     
                

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MassMapViewMaryland

        init(_ parent: MassMapViewMaryland) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {

         
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

struct MassMapViewMarylandWithUserLocation: UIViewRepresentable {
    

    @ObservedObject var massVaccinationsitesViewModel = MassVaccinationViewModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsMassArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        

     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        view.showsUserLocation = true
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
        
        for i in stride(from: 0, through: (((massVaccinationsitesViewModel.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsMassArray = MKPointAnnotation()
            
           


            pinsMassArray.title = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsMassArray.coordinate = CLLocationCoordinate2D(latitude:(massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsMassArray.subtitle = massVaccinationsitesViewModel.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsMassArray)
              
            
        }
        
             
     
                

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MassMapViewMarylandWithUserLocation

        init(_ parent: MassMapViewMarylandWithUserLocation) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {

         
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




struct LocalHealthMapViewMaryland: UIViewRepresentable {
    

    @ObservedObject var localHealthVaccineLocations = LocalHealthVaccineLocationsModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsLocalHealthArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.045753, longitude: -76.641273), latitudinalMeters: CLLocationDistance(exactly: 300000)!, longitudinalMeters: CLLocationDistance(exactly: 300000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        mapView.delegate = context.coordinator
        

     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        
        for i in stride(from: 0, through: (((localHealthVaccineLocations.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsLocalHealthArray = MKPointAnnotation()
            
           


            pinsLocalHealthArray.title = localHealthVaccineLocations.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsLocalHealthArray.coordinate = CLLocationCoordinate2D(latitude:(localHealthVaccineLocations.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (localHealthVaccineLocations.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsLocalHealthArray.subtitle = localHealthVaccineLocations.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsLocalHealthArray)
              
            
        }
        
             
     
                

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: LocalHealthMapViewMaryland

        init(_ parent: LocalHealthMapViewMaryland) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {

         
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

struct LocalHealthMapViewMarylandWithUserLocation: UIViewRepresentable {
    

    @ObservedObject var localHealthVaccineLocations = LocalHealthVaccineLocationsModel()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsLocalHealthArray: [MKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    let locationManager = CLLocationManager()

  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        

     return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        view.showsUserLocation = true
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
        
        for i in stride(from: 0, through: (((localHealthVaccineLocations.vaccineLocationsMD?.features?.count ?? 0)-1)), by: 1)
        {
            
            
        
        let pinsLocalHealthArray = MKPointAnnotation()
            
           


            pinsLocalHealthArray.title = localHealthVaccineLocations.vaccineLocationsMD?.features?[i].attributes?.name ?? ""
            pinsLocalHealthArray.coordinate = CLLocationCoordinate2D(latitude:(localHealthVaccineLocations.vaccineLocationsMD?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (localHealthVaccineLocations.vaccineLocationsMD?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsLocalHealthArray.subtitle = localHealthVaccineLocations.vaccineLocationsMD?.features?[i].attributes?.fulladdr ?? ""
        
     
            view.addAnnotation(pinsLocalHealthArray)
              
            
        }
        
             
     
                

    }
    
    
 

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: LocalHealthMapViewMarylandWithUserLocation

        init(_ parent: LocalHealthMapViewMarylandWithUserLocation) {
            self.parent = parent
            
            
        }
        func mapViewDidChangeVisibleRegion(_ view: MKMapView) {

         
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






