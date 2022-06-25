//
//  InfoairportViewController.swift
//  AirportInfo
//
//  Created by Raveena on 16/06/22.
//

import UIKit
import CoreLocation
import MapKit

class AirportInformationViewController: UIViewController {
    
    var iata:String?
    var phoneString:String?
    var viewModel = AirportInfolViewMoldell()
     @IBOutlet weak var stateStackview: UIStackView!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var stateIcon: UIImageView!
    @IBOutlet weak var iataLabel: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var AirportName: UILabel!
    @IBOutlet weak var phoneTextButton: UIButton!
    @IBOutlet weak var websiteTextButton: UIButton!
    
    var attributedString = NSMutableAttributedString(string:"")
    let yourAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                         .foregroundColor: UIColor.blue,
                                                         .underlineStyle: NSUnderlineStyle.single.rawValue]
      override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        guard let iata = iata else {
        fatalError("no iata avalable")
          }
          viewModel.getFlightInfo(iata: iata)
    }
    
    @IBAction func openMap(_ sender: Any) {
        movetoMapview()
    }
    
    @IBAction func websiteAction(_ sender: Any) {
        websiteLoadAction()
        }
    
    func websiteLoadAction(){
        if let url = URL(string: attributedString.string) {
        UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func phoneButtonAction(_ sender: Any) {
        self.makeAPhonecall()
    }
    
    @IBAction func websiteTextButtonAction(_ sender: Any) {
        websiteLoadAction()
    }
    
    @IBAction func phoneTextButtonAction(_ sender: Any) {
        self.makeAPhonecall()
    }
    
    func setAirportData(airportInfo : AirportInformation){
        self.iataLabel.text = airportInfo.iata
        self.AirportName.text = airportInfo.name
        self.country.text = airportInfo.country
       phoneString = airportInfo.phone
        if airportInfo.state == "" {
            state.isHidden = true
            stateIcon.isHidden = true
            stateStackview.isHidden = true
        }else{
            state.isHidden = false
            stateIcon.isHidden = false
            stateStackview.isHidden = false
        self.state.text = airportInfo.state
        }
        self.latitude.text = String(airportInfo.latitude)
        self.longitude.text = String(airportInfo.longitude)
        let buttonTitleStr = NSMutableAttributedString(string:airportInfo.website, attributes:yourAttributes)
        attributedString.append(buttonTitleStr)
        websiteTextButton.setAttributedTitle(attributedString, for: .normal)
        self.phoneTextButton.setTitle(airportInfo.phone, for: .normal)
         }
    
    func makeAPhonecall() {
         guard let phoneUrl = viewModel.getPhoneNumberUrl() else{
            return
        }
         UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
     }
    
    @IBAction func backAction(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func movetoMapview(){
        let cooridantes = viewModel.getCoordinates()
        let latitude = cooridantes.latitude
        let longitude = cooridantes.latitude
        let coordinate = CLLocationCoordinate2DMake(latitude,longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
  }

extension AirportInformationViewController: AirportViewmodelProtocal {
    
    func didRecieveFlighInfo(airInfo: AirportInformation) {
        DispatchQueue.main.async {
            self.setAirportData(airportInfo: airInfo)
        }
    }
    
    func didRecieveError(error: Error) {
        
    }
}
