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
  //  var flightInfo: Result<AirportInformation, AirError>?
   
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
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 14),
          .foregroundColor: UIColor.blue,
          .underlineStyle: NSUnderlineStyle.single.rawValue
      ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFlightData(iata: iata!) {[weak self] result in
            switch result {
            case .success(let airportInfo):
                DispatchQueue.main.async {
                self?.setAirportData(airportInfo: airportInfo)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    @IBAction func openMap(_ sender: Any) {
       loadMapview()
    }
    func loadMapview(){
        let latitude = latitude.text
        let longitude = longitude.text
        let appDomen: String =  "comgooglemaps://"
        let browserDomen: String = "https://www.google.co.in/maps/dir/"
        let directionBody: String = "?saddr=&daddr=\(String(describing: latitude)),\(String(describing: longitude))&directionsmode=driving"
        
        // Make route with google maps application
        if let appUrl = URL(string: appDomen), UIApplication.shared.canOpenURL(appUrl) {
            guard let appFullPathUrl = URL(string: appDomen + directionBody) else { return }
                  //  UIApplication.shared.openURL(appFullPathUrl)
            UIApplication.shared.open(appFullPathUrl, options: [:], completionHandler: nil)

                // If user don't have an application make route in browser
                } else if let browserUrl = URL(string: browserDomen), UIApplication.shared.canOpenURL(browserUrl) {
                    guard let browserFullPathUrl = URL(string: browserDomen + directionBody) else { return }
                   // UIApplication.shared.openURL(browserFullPathUrl)
                    UIApplication.shared.open(browserFullPathUrl, options: [:], completionHandler: nil)
                }
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
         print(phoneString!)
         
         let formatedNumber = phoneString!.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
         print("calling \(formatedNumber)")
         let phoneUrl = "tel://\(formatedNumber)"
         let url:URL = URL(string: phoneUrl)!
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
      //   UIApplication.shared.openURL(url)

    }
    @IBAction func backAction(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
