//
//  LoaderAsset.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import Foundation

enum LoaderAsset {
    case gif(name: String)
    case lottie(name: String)
    
    static let defaultLottie = LoaderAsset.lottie(name: "DefaultLoader")
}
