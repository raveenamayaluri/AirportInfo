//
//  Airport.swift
//  AirportInfo
//
//  Created by Raveena on 16/06/22.
//

import Foundation

struct AirPort{
    let airportName : String
    let iatacode : String

    init(name: String, iata: String){
        self.airportName = name
        self.iatacode = iata
    }
}
