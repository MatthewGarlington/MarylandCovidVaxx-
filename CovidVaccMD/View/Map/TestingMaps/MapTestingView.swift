//
//  MapTestingView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/25/21.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

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
        mapView.userTrackingMode = .follow
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

// All Testing Locations Map View with User Locations

struct MapTestingViewWithUserLocation: UIViewRepresentable {
    @ObservedObject var allTestingLocations = AllTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsAllTesting: [MKPointAnnotation]
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
        var parent: MapTestingViewWithUserLocation

        init(_ parent: MapTestingViewWithUserLocation) {
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
        mapView.userTrackingMode = .follow
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

// Cost Free Testing Map View with User Locations
struct CostFreeTestingViewWithUserLocations: UIViewRepresentable {
    @ObservedObject var costFreeTestingLocations = CostFreeTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsCostFreeTesting: [MKPointAnnotation]
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
        var parent: CostFreeTestingViewWithUserLocations

        init(_ parent: CostFreeTestingViewWithUserLocations) {
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
        mapView.userTrackingMode = .follow
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


// Online Scheduling Testing Map View With User Locations
struct OnlineSchedulingTestingViewWithUserLocations: UIViewRepresentable {
    @ObservedObject var onlineSchedulingTestingLocations = OnlineSchedulingTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsOnlineTesting: [MKPointAnnotation]
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
        var parent: OnlineSchedulingTestingViewWithUserLocations

        init(_ parent: OnlineSchedulingTestingViewWithUserLocations) {
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
        mapView.userTrackingMode = .follow
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


// No Appointment Required Testing Map View with User Locations
struct NoAppointmentRequiredTestingViewWithUserLocations: UIViewRepresentable {
    @ObservedObject var noAppointmentRequiredeTestingLocations = NoAppointmentRequiredTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsNoAppointment: [MKPointAnnotation]
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
        var parent: NoAppointmentRequiredTestingViewWithUserLocations

        init(_ parent: NoAppointmentRequiredTestingViewWithUserLocations) {
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
        mapView.userTrackingMode = .follow
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

// Peds Testing Map View with User Location
struct PedsTestingMapViewWithUserLocation: UIViewRepresentable {
    @ObservedObject var pedsTestingLocations = PedsTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsPedsTesting: [MKPointAnnotation]
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
        var parent: PedsTestingMapViewWithUserLocation

        init(_ parent: PedsTestingMapViewWithUserLocation) {
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
        mapView.userTrackingMode = .follow
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


// Rapid Testing Map View With User Location
struct RapidTestingMapViewWithUserLocation: UIViewRepresentable {
    @ObservedObject var rapidTestingLocations = RapidTestingLocations()
    @Binding var annotations: [MKPointAnnotation]
    @Binding var pinsRapidTesting: [MKPointAnnotation]
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
        var parent: RapidTestingMapViewWithUserLocation

        init(_ parent: RapidTestingMapViewWithUserLocation) {
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


