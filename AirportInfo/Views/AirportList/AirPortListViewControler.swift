//
//  ViewController.swift
//  AirportInfo
//
//  Created by Raveena on 16/06/22.
//

import UIKit
import Foundation

class AirPortListViewControler: UIViewController ,UISearchBarDelegate{

    private let viewModel = AirportListviewModel()
    private var airportdataSource : AirportTableviewDatasource<AirportTableViewCell,AirPort>!

    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        updateTableviewDatasource()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterAirports(searchText)
        updateTableviewDatasource()
    }
  
    func updateTableviewDatasource(){
        airportdataSource = AirportTableviewDatasource(cellIdentifier: "AirportTableViewCell", items:viewModel.getAirportList(), configureCell: { (cell ,airport) in
              cell.airportName.text = airport.airportName
              cell.iata.text  = airport.iatacode
        })
        
        tableView.dataSource = airportdataSource
        tableView.reloadData()
    }
    
}
extension AirPortListViewControler : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let airPort = viewModel.getAirportList()[indexPath.row]
            MovetoAirportInfo(iata: airPort.iatacode)
    }
    func MovetoAirportInfo(iata:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AirportInformationViewController") as! AirportInformationViewController
        newViewController.iata = iata
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}


