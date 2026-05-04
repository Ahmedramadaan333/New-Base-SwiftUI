//
//  MapsStyles.swift
//  CaptainCTF
//
//  Created by Ahmed Ramadan on 02/02/2026.
//



import GoogleMaps

public enum MapsStyles: String {
    
    case silver
    case dark
    
    private static func load(style: MapsStyles) -> String? {
        
        /// Load JSON file form Resources
        guard let styleURL = Bundle.main.url(forResource: style.rawValue, withExtension: "json"),
              let styleData = try? Data(contentsOf: styleURL) else {
            print("🧭 Error:: Failed to load custom map style with name: \(style.rawValue)")
            return nil
        }
        
        /// Convert loaded Data to JSON-String
        guard let customMapStyle = String(data: styleData, encoding: .utf8) else {
            print("🧭 Error:: Failed to read custom map style data for style named: \(style.rawValue)")
            return nil
        }
        
        return customMapStyle
        
    }
    
    static func get(style: MapsStyles) -> GMSMapStyle {
        
        guard
            let customMapStyle = load(style: style),
            let style = try? GMSMapStyle(jsonString: customMapStyle)
        else {
            print("🧭 Error:: Failed to create custom map style for style named: \(style.rawValue)")
            return GMSMapStyle()
        }
        
        return style
    }
    
    static func getStyleDependingOnCurrentTheme() -> GMSMapStyle {
        
        switch UIScreen.main.traitCollection.userInterfaceStyle {
        case .dark:
            return get(style: .dark)
        default:
            return get(style: .silver)
        }
        
    }
    
}

