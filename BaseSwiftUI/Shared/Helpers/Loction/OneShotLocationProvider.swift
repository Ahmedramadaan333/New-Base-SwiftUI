//
//  OneShotLocationProvider.swift
//  CTF
//
//  Created by Ahmed Ramadan on 07/02/2026.
//


import CoreLocation

final class OneShotLocationProvider: NSObject, CLLocationManagerDelegate {
    private var manager: CLLocationManager?
    private var completion: ((Result<CLLocationCoordinate2D, Error>) -> Void)?

    enum LocationError: Error {
        case permissionDenied
        case unableToGetLocation
    }

    func requestLocationOnce(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        self.completion = completion

        let m = CLLocationManager()
        manager = m
        m.delegate = self
        m.desiredAccuracy = kCLLocationAccuracyBest

        switch m.authorizationStatus {
        case .notDetermined:
            m.requestWhenInUseAuthorization()

        case .authorizedWhenInUse, .authorizedAlways:
            m.requestLocation()

        case .denied, .restricted:
            finish(.failure(LocationError.permissionDenied))

        @unknown default:
            finish(.failure(LocationError.permissionDenied))
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            finish(.failure(LocationError.permissionDenied))
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = locations.last?.coordinate else {
            finish(.failure(LocationError.unableToGetLocation))
            return
        }
        finish(.success(coord))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        finish(.failure(error))
    }

    private func finish(_ result: Result<CLLocationCoordinate2D, Error>) {
        completion?(result)

        completion = nil
        manager?.delegate = nil
        manager = nil
    }
}
