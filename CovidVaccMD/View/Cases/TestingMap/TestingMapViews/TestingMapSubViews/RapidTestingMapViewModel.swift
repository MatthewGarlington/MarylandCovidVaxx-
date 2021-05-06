//
//  RapidTestingMapViewModel.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

// Rapid Testing Map View
struct RapidTestingMapView: UIViewRepresentable {
    @ObservedObject var viewModel = RapidTestingLocationsViewModel()
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
        for i in stride(from: 0, through: (((viewModel.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {

            let pinsRapidTesting = MKPointAnnotation()
            pinsRapidTesting.title = viewModel.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsRapidTesting.coordinate = CLLocationCoordinate2D(latitude:(viewModel.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (viewModel.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsRapidTesting.subtitle = viewModel.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""

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
