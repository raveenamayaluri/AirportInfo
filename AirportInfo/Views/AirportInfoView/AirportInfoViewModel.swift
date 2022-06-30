//
//  AirportInfoViewModel.swift
//  AirportInfo
//
//  Created by Raveena on 21/06/22.
//

import Foundation
import CoreLocation

protocol AirportViewModelProtocal: AnyObject {
    func didRecieveFlighInfo(airInfo: AirportInformation)
    func didRecieveError(error: Error)
}

class AirportInfolViewModel{
    
    var delegate: AirportViewModelProtocal?
    var airportInfo : AirportInformation?
    var url:URL?
    
    func getCoordinates() -> (latitude:Double,longitude:Double){
        let latitude = Double(airportInfo!.latitude)
        let longitude = Double(airportInfo!.longitude)
        return (latitude,longitude)
    }
      
    func getFlightInfo(iata : String){
        getFlightData(iata: iata) {[weak self] result in
                switch result {
                case .success(let airportInfo):
                    self?.airportInfo = airportInfo
                    self?.delegate?.didRecieveFlighInfo(airInfo: airportInfo)
                case .failure(let error):
                    self?.delegate?.didRecieveError(error: error)
                }
            }
    }
    
    func getPhoneNumberUrl()-> URL?{
        guard let phoneNumber = airportInfo?.phone else{
            return nil
        }
        let formatedNumber = phoneNumber.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        print("calling \(formatedNumber)")
        let phoneUrl = "tel://\(formatedNumber)"
        return URL(string: phoneUrl)
    }
}
