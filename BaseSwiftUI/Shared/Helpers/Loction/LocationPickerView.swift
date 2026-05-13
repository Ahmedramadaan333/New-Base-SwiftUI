//
//  LocationPickerView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 14/12/2025.
//

import SwiftUI
import CoreLocation
import GoogleMaps

private struct SheetHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}

struct LocationPickerView: View {
    let title: String
    let confirmTitle: String
    let onConfirm: (LocationPoint) -> Void
    
    @StateObject private var locator = LocationProvider()
    
    @State private var cameraCenter = CLLocationCoordinate2D(latitude: 24.774265, longitude: 46.738586)
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    
    @State private var resolvedAddress: String = ""
    @State private var placeId: String? = nil
    
    @State private var sheetHeight: CGFloat = 0
    @State private var didSetInitialSelection = false
    @State private var recenterToken: Int = 0
    
    var body: some View {
        BaseScreen(
            title: title,
            contentPadding: .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        ) {
            GeometryReader { geo in
                let safeBottom = geo.safeAreaInsets.bottom
                let mapBottomPadding = sheetHeight + safeBottom + 24
                
                ZStack(alignment: .bottom) {
                    
                    GoogleMapView(
                        cameraCenter: $cameraCenter,
                        selectedCoordinate: $selectedCoordinate,
                        showsUserLocation: true,
                        showsMyLocationButton: false,
                        bottomPadding: mapBottomPadding,
                        zoom: 16,
                        recenterToken: recenterToken,
                        onTap: { coord in
                            reverseGeocode(coord)
                        }
                    )
                    .frame(width: geo.size.width, height: geo.size.height)
                    .ignoresSafeArea(edges: [.horizontal, .bottom])
                    
                    Button {
                        guard let coord = locator.currentCoordinate else { return }
                        selectedCoordinate = coord
                        cameraCenter = coord
                        recenterToken += 1
                        reverseGeocode(coord)
                    } label: {
                        Image(systemName: "location.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.primary)
                            .padding(12)
                            .background(Color.cardBackground)
                            .clipShape(Circle())
                            .shadow(radius: 6)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 16)
                    .padding(.bottom, mapBottomPadding + 8)
                    .zIndex(10)
                    
                    bottomSheet
                        .padding(.horizontal, 16)
                        .padding(.bottom, max(16, safeBottom + 8))
                        .background(
                            GeometryReader { g in
                                Color.clear.preference(key: SheetHeightKey.self, value: g.size.height)
                            }
                        )
                        .zIndex(20)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .onPreferenceChange(SheetHeightKey.self) { sheetHeight = $0 }
            }
        }
        .onAppear { locator.request() }
        .onReceive(locator.$currentCoordinate) { coord in
            guard let coord else { return }
            guard didSetInitialSelection == false else { return }
            didSetInitialSelection = true
            
            selectedCoordinate = coord
            cameraCenter = coord
            recenterToken += 1
            reverseGeocode(coord)
        }
    }
    
    private var bottomSheet: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("location_title".localized)
                .font(AppFont.bold(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                Image(.location)
                Text(resolvedAddress.isEmpty ? "tap_to_select_location_title".localized : resolvedAddress)
                    .font(AppFont.medium(size: 14))
                    .lineLimit(2)
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            MainAppButton(title: confirmTitle) {
                let coord = selectedCoordinate ?? cameraCenter
                let point = LocationPoint(
                    address: resolvedAddress.isEmpty ? "\(coord.latitude),\(coord.longitude)" : resolvedAddress,
                    lat: coord.latitude,
                    lng: coord.longitude,
                    placeId: placeId
                )
                onConfirm(point)
            }
        }
        .padding(16)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 8)
    }
    private func reverseGeocode(_ coord: CLLocationCoordinate2D) {
        GMSGeocoder().reverseGeocodeCoordinate(coord) { response, error in
            guard let result = response?.firstResult() else {
                DispatchQueue.main.async {
                    self.resolvedAddress = ""
                    self.placeId = nil
                }
                return
            }
            
            var addressParts: [String] = []
            
            if let thoroughfare = result.thoroughfare {
                addressParts.append(thoroughfare)
            }
            if let subLocality = result.subLocality {
                addressParts.append(subLocality)
            }
            if let locality = result.locality {
                addressParts.append(locality)
            }
            
            if let country = result.country{
                addressParts.append(country)
                
            }
            let customAddress = addressParts.joined(separator: ", ")
            
            DispatchQueue.main.async {
                self.resolvedAddress = customAddress.isEmpty ? "Unknown location".localized : customAddress
                self.placeId = nil
            }
        }
    }
}

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
