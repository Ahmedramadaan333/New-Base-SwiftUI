// MARK: - OPTIONAL COMPONENT
// This file requires the GoogleMaps SPM package.
// If your project does not use Google Maps, delete this file and the
// Loction/ helpers, then remove GoogleMaps from Project > Package Dependencies.
//
//  GoogleMapView.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 14/12/2025.
//


import SwiftUI
import GoogleMaps
import CoreLocation

struct GoogleMapView: UIViewRepresentable {
    @Binding var cameraCenter: CLLocationCoordinate2D
    @Binding var selectedCoordinate: CLLocationCoordinate2D?

    var showsUserLocation: Bool = true
    var showsMyLocationButton: Bool = false
    var bottomPadding: CGFloat = 0

    var zoom: Float = 14
    var recenterToken: Int = 0

    var onTap: ((CLLocationCoordinate2D) -> Void)? = nil

    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition(latitude: cameraCenter.latitude, longitude: cameraCenter.longitude, zoom: zoom)
        let map = GMSMapView()
        map.camera = camera

        map.delegate = context.coordinator
        map.isMyLocationEnabled = showsUserLocation
        map.settings.myLocationButton = showsMyLocationButton
        map.padding = UIEdgeInsets(top: 0, left: 0, bottom: bottomPadding, right: 0)

        context.coordinator.marker = GMSMarker()
        context.coordinator.marker?.icon = .pin
        
        context.coordinator.marker?.map = nil

        return map
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.padding = UIEdgeInsets(top: 0, left: 0, bottom: bottomPadding, right: 0)

        if context.coordinator.lastRecenterToken != recenterToken {
            context.coordinator.lastRecenterToken = recenterToken
            let pos = GMSCameraPosition(latitude: cameraCenter.latitude, longitude: cameraCenter.longitude, zoom: zoom)
            uiView.animate(to: pos)
        }

        if let selected = selectedCoordinate {
            context.coordinator.marker?.position = selected
            if context.coordinator.marker?.map == nil {
                context.coordinator.marker?.map = uiView
            }
        } else {
            context.coordinator.marker?.map = nil
        }
    }

    final class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapView
        var lastRecenterToken: Int = 0
        var marker: GMSMarker?

        init(parent: GoogleMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            DispatchQueue.main.async {
                self.parent.cameraCenter = position.target
            }
        }

        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            DispatchQueue.main.async {
                self.parent.selectedCoordinate = coordinate
                self.parent.onTap?(coordinate)
            }
        }
    }
}


