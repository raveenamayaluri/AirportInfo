//
//  AirportListViewmodel.swift
//  AirportInfo
//
//  Created by Raveena on 21/06/22.
//

import Foundation
class AirportListviewModel{
    private let dataSource : [AirPort] =
    [AirPort(name:"Abu Dhabi International",iata:"AUH"),
     AirPort(name:"Ahmedabad", iata: "AMD"),
     AirPort(name: "Albury", iata: "ABX"),
     AirPort(name: "Antalya",iata:"AYT"),
     AirPort(name: "Bangalore", iata: "BLR"),
     AirPort(name: "Bannu", iata: "BNP"),
     AirPort(name: "Nanyuan Airport", iata: "NAY"),
     AirPort(name: "Bristol", iata: "BRS"),
     AirPort(name: "Cambrigde", iata: "CBG"),
     AirPort(name: "Cardiff Airport", iata: "CWL"),
     AirPort(name: "Heathrow", iata: "LHR"),
     AirPort(name: "Middlemount", iata: "MMM")]
    var filteredArray: [AirPort]!
    
    init() {
      filteredArray = dataSource
    }
    
    func filterAirports (_ searchText: String)  {
         filteredArray = searchText.isEmpty ? dataSource : dataSource.filter({$0.airportName.localizedCaseInsensitiveContains(searchText) })
    }
    
    func getAirportList () -> [AirPort] {
        return filteredArray
    }
}
