//
//  ViewController.swift
//  AirportInfo
//
//  Created by Raveena on 16/06/22.
//

import UIKit
import Foundation

class AirPortListViewControler: UIViewController ,UISearchBarDelegate{

    private let viewModel = AirportListViewModel()
    private var airportDataSource : AirportTableViewDataSource<AirportTableViewCell,AirPort>!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateTableViewDatasource()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterAirports(searchText)
        updateTableViewDatasource()
    }
  
    func updateTableViewDatasource(){
        airportDataSource = AirportTableViewDataSource(cellIdentifier: "AirportTableViewCell", items:viewModel.getAirportList(), configureCell: { (cell ,airport) in
              cell.airportName.text = airport.airportName
              cell.iata.text  = airport.iatacode
        })
        tableView.dataSource = airportDataSource
        tableView.reloadData()
    }
}

extension AirPortListViewControler : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let airPort = viewModel.getAirportList()[indexPath.row]
            MovetoAirportInformationController(iata: airPort.iatacode)
    }
    
    func MovetoAirportInformationController(iata:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let newViewController = storyBoard.instantiateViewController(withIdentifier: "AirportInformationViewController") as? AirportInformationViewController else
        {
            fatalError("Restoration ID not found")
        }
        newViewController.iata = iata
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
