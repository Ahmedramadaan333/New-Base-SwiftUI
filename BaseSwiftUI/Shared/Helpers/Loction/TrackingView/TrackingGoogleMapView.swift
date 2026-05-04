//
//  TrackingGoogleMapView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 11/02/2026.
//


import SwiftUI
import GoogleMaps
import CoreLocation
import UIKit

struct TrackingGoogleMapView: UIViewRepresentable {

    // camera
    @Binding var cameraCenter: CLLocationCoordinate2D
    var zoom: Float = 15
    var recenterToken: Int = 0

    // route
    var encodedPolyline: String?
    var tripLocations: TripLocations?

    // live captain
    var captainCoordinate: CLLocationCoordinate2D?
    var followCaptain: Bool = false

    // fit trigger
    var fitBoundsToken: Int = 0

    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }

    func makeUIView(context: Context) -> GMSMapView {
        _ = GMSCameraPosition(
            latitude: cameraCenter.latitude,
            longitude: cameraCenter.longitude,
            zoom: zoom
        )
        let map = GMSMapView()
        map.mapStyle = MapsStyles.get(style: .dark)
        map.settings.compassButton = true
        map.settings.rotateGestures = true
        map.settings.tiltGestures = false
        context.coordinator.attach(map: map)
        return map
    }

    func updateUIView(_ map: GMSMapView, context: Context) {
        context.coordinator.parent = self

        // recenter
        if context.coordinator.lastRecenterToken != recenterToken {
            context.coordinator.lastRecenterToken = recenterToken
            let pos = GMSCameraPosition(latitude: cameraCenter.latitude, longitude: cameraCenter.longitude, zoom: zoom)
            map.animate(to: pos)
        }

        // markers (from/to)
        context.coordinator.renderTripMarkersIfNeeded(on: map, tripLocations: tripLocations)

        // polyline
        context.coordinator.renderPolylineIfNeeded(on: map, encoded: encodedPolyline)

        // captain
        context.coordinator.updateCaptain(on: map, captain: captainCoordinate, follow: followCaptain)

        // fit bounds
        if context.coordinator.lastFitToken != fitBoundsToken {
            context.coordinator.lastFitToken = fitBoundsToken
            context.coordinator.fitAll(on: map)
        }
    }

    final class Coordinator {
        var parent: TrackingGoogleMapView
        weak var map: GMSMapView?

        var lastRecenterToken: Int = 0
        var lastFitToken: Int = 0

        private var fromMarker: GMSMarker?
        private var toMarker: GMSMarker?

        private var carMarker: GMSMarker?
        private var lastCaptain: CLLocationCoordinate2D?

        private var polyline: GMSPolyline?
        private var lastEncoded: String?
        private var lastTripSignature: String?

        init(parent: TrackingGoogleMapView) {
            self.parent = parent
        }

        func attach(map: GMSMapView) { self.map = map }

        func renderTripMarkersIfNeeded(on map: GMSMapView, tripLocations: TripLocations?) {
            let sig = "\(tripLocations?.from?.lat ?? ""):\(tripLocations?.from?.lng ?? "")|\(tripLocations?.to?.lat ?? ""):\(tripLocations?.to?.lng ?? "")"
            guard sig != lastTripSignature else { return }
            lastTripSignature = sig

            fromMarker?.map = nil
            toMarker?.map = nil

            if let from = tripLocations?.from?.coordinate {
                let m = GMSMarker(position: from)
                m.icon = UIImage(named: "Pin") ?? UIImage(named: "Pin")
                m.groundAnchor = CGPoint(x: 0.5, y: 1.0)
                m.zIndex = 10
                m.map = map
                fromMarker = m
            }

            if let to = tripLocations?.to?.coordinate {
                let m = GMSMarker(position: to)
                m.icon = UIImage(named: "Pin") ?? UIImage(named: "Pin")
                m.groundAnchor = CGPoint(x: 0.5, y: 1.0)
                m.zIndex = 10
                m.map = map
                toMarker = m
            }
        }

        func renderPolylineIfNeeded(on map: GMSMapView, encoded: String?) {
            guard let encoded, !encoded.isEmpty else {
                polyline?.map = nil
                polyline = nil
                lastEncoded = nil
                return
            }
            guard encoded != lastEncoded else { return }
            lastEncoded = encoded

            guard let path = GMSPath(fromEncodedPath: encoded) else { return }

            if polyline == nil {
                let pl = GMSPolyline(path: path)
                pl.strokeWidth = 4
                pl.strokeColor = UIColor.primaryMain
                pl.map = map
                polyline = pl
            } else {
                polyline?.path = path
                polyline?.map = map
            }
        }

        func updateCaptain(on map: GMSMapView, captain: CLLocationCoordinate2D?, follow: Bool) {
            guard let captain else { return }

            if carMarker == nil {
                let m = GMSMarker(position: captain)
                m.icon = .trackingCar
                m.isFlat = true
                m.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                m.zIndex = 1000
                m.map = map
                carMarker = m
                lastCaptain = captain
            } else {
                if let last = lastCaptain {
                    let angle = bearing(from: last, to: captain)
                    CATransaction.begin()
                    CATransaction.setAnimationDuration(0.8)
                    carMarker?.rotation = angle
                    carMarker?.position = captain
                    CATransaction.commit()
                } else {
                    carMarker?.position = captain
                }
                lastCaptain = captain
            }

            if follow {
                map.animate(with: GMSCameraUpdate.setTarget(captain, zoom: 16))
            }
        }

        func fitAll(on map: GMSMapView) {
            var bounds: GMSCoordinateBounds?

            func add(_ c: CLLocationCoordinate2D) {
                if bounds == nil {
                    bounds = GMSCoordinateBounds(coordinate: c, coordinate: c)
                } else {
                    bounds = bounds!.includingCoordinate(c)
                }
            }

            if let c = fromMarker?.position { add(c) }
            if let c = toMarker?.position { add(c) }
            if let c = carMarker?.position { add(c) }

            if let path = polyline?.path {
                for i in 0..<path.count() { add(path.coordinate(at: i)) }
            }

            guard let bounds else { return }
            map.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50))
        }

        private func bearing(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDegrees {
            let fLat = from.latitude  * .pi / 180
            let fLng = from.longitude * .pi / 180
            let tLat = to.latitude    * .pi / 180
            let tLng = to.longitude   * .pi / 180
            let dLng = tLng - fLng
            let y = sin(dLng) * cos(tLat)
            let x = cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(dLng)
            let brng = atan2(y, x) * 180 / .pi
            return (brng + 360).truncatingRemainder(dividingBy: 360)
        }
    }
}

struct TripLocations: Codable {
    let from: TripLocationPoint?
    let to: TripLocationPoint?
}
struct TripLocationPoint: Codable {
    let lat: String?
    let lng: String?
    let mapDesc: String?
    
    enum CodingKeys: String, CodingKey {
        case lat, lng
        case mapDesc = "map_desc"
    }
}

struct TripLocationModel: Codable {
    let lat: String?
    let lng: String?
}

extension TripLocations {
    /// turns from/to into the list expected by directions endpoint
    var asDirectionsList: [TripLocationModel] {
        var arr: [TripLocationModel] = []
        if let f = from { arr.append(.init(lat: f.lat, lng: f.lng)) }
        if let t = to { arr.append(.init(lat: t.lat, lng: t.lng)) }
        return arr
    }
}
extension TripLocationPoint {
    var coordinate: CLLocationCoordinate2D? {
        guard let lat = lat?.toDouble(), let lng = lng?.toDouble() else { return nil }
        return .init(latitude: lat, longitude: lng)
    }
}
extension TripLocations: Hashable {
    static func == (lhs: TripLocations, rhs: TripLocations) -> Bool {
        lhs.from?.lat == rhs.from?.lat &&
        lhs.from?.lng == rhs.from?.lng &&
        lhs.to?.lat == rhs.to?.lat &&
        lhs.to?.lng == rhs.to?.lng
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(from?.lat)
        hasher.combine(from?.lng)
        hasher.combine(to?.lat)
        hasher.combine(to?.lng)
    }
}

extension TripLocationPoint: Hashable {
    static func == (lhs: TripLocationPoint, rhs: TripLocationPoint) -> Bool {
        lhs.lat == rhs.lat && lhs.lng == rhs.lng
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(lat)
        hasher.combine(lng)
    }
}
