//
//  FlightServiceHelper.swift
//  AirportInfo
//
//  Created by Raveena on 16/06/22.
//

import Foundation

private let FLIGHTINFO_BASE_URL = "https://airport-info.p.rapidapi.com/airport"

private let headers = [
    "X-RapidAPI-Key": "897c744b48msh663bf36e94a3af6p175372jsn6d0049e1e4e4",
    "X-RapidAPI-Host": "airport-info.p.rapidapi.com"
]

 func getFlightData(iata:String, callBack:@escaping (Result<AirportInformation,AirError>)->Void){
    
    guard let requestUrl = URL(string: "\(FLIGHTINFO_BASE_URL)?iata=\(iata)")  else {
        let error = AirError(title: "URL Error", description: "URL convertion failed", code: 404)
        callBack(.failure(error))
        return
    }
     
    var request = URLRequest(url: requestUrl)
    request.cachePolicy = .useProtocolCachePolicy
    request.timeoutInterval = 10.0
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let dataTask =  URLSession.shared.dataTask(with: request , completionHandler: { (data, response, error) -> Void in
        if ((error) != nil) {
            let aerror = AirError(title: nil, description: error?.localizedDescription ?? "Error response", code: 426)
            callBack(.failure(aerror))
            return
        } else {
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    // process data
                    let flightInfo = try decoder.decode(AirportInformation.self, from: data)
                    callBack(.success(flightInfo))
                    print(flightInfo)
                    
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }
    })
    
    dataTask.resume()
}
