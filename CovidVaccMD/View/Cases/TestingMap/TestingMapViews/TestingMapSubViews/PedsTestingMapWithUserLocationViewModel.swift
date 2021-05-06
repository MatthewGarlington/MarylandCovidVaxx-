//
//  PedsTestingMapWithUserLocationViewModel.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine


// Peds Testing Map View with User Location
struct PedsTestingMapViewWithUserLocation: UIViewRepresentable {
    @ObservedObject var viewModel = PedsTestingLocationsViewModel()
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

        for i in stride(from: 0, through: (((viewModel.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {
            let pinsPedsTesting = MKPointAnnotation()
            pinsPedsTesting.title = viewModel.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsPedsTesting.coordinate = CLLocationCoordinate2D(latitude:(viewModel.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (viewModel.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsPedsTesting.subtitle = viewModel.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""

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

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if !(annotation is MKUserLocation) {
                let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))

                let rightButton = UIButton(type: .detailDisclosure)
                pinView.rightCalloutAccessoryView = rightButton
                pinView.animatesDrop = false
                pinView.canShowCallout = true

                return pinView
            } else {
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
