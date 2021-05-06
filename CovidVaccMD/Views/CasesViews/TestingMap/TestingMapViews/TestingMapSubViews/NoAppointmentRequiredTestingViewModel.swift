//
//  NoAppointmentRequiredTestingViewModel.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 5/5/21.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

// No Appointment Required Testing Map View
struct NoAppointmentRequiredTestingView: UIViewRepresentable {
    @ObservedObject var viewModel = NoAppointmentRequiredTestingLocationsViewModel()
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

        for i in stride(from: 0, through: (((viewModel.testingTestingLocations?.features?.count ?? 0)-1)), by: 1)
        {
            let pinsNoAppointment = MKPointAnnotation()
            pinsNoAppointment.title = viewModel.testingTestingLocations?.features?[i].attributes?.name ?? ""
            pinsNoAppointment.coordinate = CLLocationCoordinate2D(latitude:(viewModel.testingTestingLocations?.features?[i].geometry?.coordinate.latitude ?? 0.0), longitude: (viewModel.testingTestingLocations?.features?[i].geometry?.coordinate.longitude ?? 0.0))
            pinsNoAppointment.subtitle = viewModel.testingTestingLocations?.features?[i].attributes?.fulladdr ?? ""

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
