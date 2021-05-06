//
//  SwiftUIView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

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

