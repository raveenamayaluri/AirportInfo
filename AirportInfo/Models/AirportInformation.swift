//
//  AirportInformation.swift
//  AirportInfo
//
//  Created by Raveena on 16/06/22.
//

import Foundation

struct AirportInformation: Codable {
    let id: Int
    let iata, icao, name, location: String
    let street_Number : String?
    let street, city, county: String
    let state, country_iso, country, postal_code: String
    let phone: String
    let latitude, longitude: Double
    let uct: Int
    let website: String
}

