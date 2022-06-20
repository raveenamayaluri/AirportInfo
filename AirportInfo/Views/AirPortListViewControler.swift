//
//  ViewController.swift
//  AirportInfo
//
//  Created by Raveena on 16/06/22.
//

import UIKit
import Foundation

class AirPortListViewControler: UIViewController ,UISearchBarDelegate{

    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var airportnameTableview: UITableView!
    
    let datasource : [AirPort] = [AirPort(name: "Abu Dhabi International", iata: "AUH"),
                                     AirPort(name: "Ahmedabad", iata: "AMD"),
                                     AirPort(name: "Albury", iata: "ABX"),
                                     AirPort(name: "Antalya", iata: "AYT"),
                                 AirPort(name: "Bangalore", iata: "BLR"),
                                    AirPort(name: "Bannu", iata: "BNP"),
                                    AirPort(name: "Nanyuan Airport", iata: "NAY"),
                                    AirPort(name: "Bristol", iata: "BRS"),
                                 AirPort(name: "Cambrigde", iata: "CBG"),
                                    AirPort(name: "Cardiff Airport", iata: "CWL"),
                                    AirPort(name: "Heathrow", iata: "LHR"),
                                    AirPort(name: "Middlemount", iata: "MMM"),
                                       ]
    var searchedAirport:[AirPort] = []
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        searchedAirport = datasource
      
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
         searchedAirport = searchText.isEmpty ? datasource : datasource.filter({$0.airportName.localizedCaseInsensitiveContains(searchText) })
       
            airportnameTableview.reloadData()
        }
   
}
extension AirPortListViewControler : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedAirport.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AirportTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "AirportTableViewCell") as? AirportTableViewCell

            let airPort = searchedAirport[indexPath.row]
            cell?.airportName.text = airPort.airportName
            cell?.iata?.text = airPort.iatacode
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
             let airPort = searchedAirport[indexPath.row]
            MovetoAirportInfo(iata: airPort.iatacode)
    }
    func MovetoAirportInfo(iata:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AirportInformationViewController") as! AirportInformationViewController
        newViewController.iata = iata
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
}


