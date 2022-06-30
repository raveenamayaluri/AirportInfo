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
    var viewModel = AirportInfolViewModel()
     @IBOutlet weak var stateStackview: UIStackView!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var webStackView: UIStackView!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var stateIcon: UIImageView!
    @IBOutlet weak var iataLabel: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var AirportName: UILabel!
    @IBOutlet weak var phoneTextButton: UIButton!
    @IBOutlet weak var websiteTextButton: UIButton!
    
    private var attributedString = NSMutableAttributedString(string:"")
   private let yourAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),
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
        openInMapView()
    }
    
    @IBAction func websiteAction(_ sender: Any) {
                openInExternalBrowser()
        }
    
    func openInExternalBrowser(){
        if currentReachabilityStatus == .notReachable {
            print("Nwework Unavailbale")
        } else {
            if let url = URL(string: attributedString.string) {
            UIApplication.shared.open(url, options: [:])
            }
        }
        }
    
    @IBAction func phoneButtonAction(_ sender: Any) {
        self.makeAPhonecall()
    }
    
    @IBAction func websiteTextButtonAction(_ sender: Any) {
       openInExternalBrowser()
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
            stateStackview.isHidden = true
        }else{
        stateStackview.isHidden = false
        self.state.text = airportInfo.state
        }
        if airportInfo.phone == ""{
            phoneStackView.isHidden = true
        }else{
            phoneStackView.isHidden = false
        }
        let buttonTitleStr = NSMutableAttributedString(string:airportInfo.website, attributes:yourAttributes)
        attributedString.append(buttonTitleStr)
        websiteTextButton.setAttributedTitle(attributedString, for: .normal)
        self.phoneTextButton.setTitle(airportInfo.phone, for: .normal)
         }
    
    func makeAPhonecall() {
         guard let phoneUrl = viewModel.getPhoneNumberUrl() else{
             fatalError("Phonenumber Not avalable")
        }
         UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
     }
    
    @IBAction func backAction(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func openInMapView(){
        let cooridantes = viewModel.getCoordinates()
        let latitude = cooridantes.latitude
        let longitude = cooridantes.longitude
        let coordinate = CLLocationCoordinate2DMake(latitude,longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
  }

extension AirportInformationViewController: AirportViewModelProtocal {
    
    func didRecieveFlighInfo(airInfo: AirportInformation) {
        DispatchQueue.main.async {
            self.setAirportData(airportInfo: airInfo)
        }
    }
    
    func didRecieveError(error: Error) {
       }
}
