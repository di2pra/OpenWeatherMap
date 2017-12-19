//
//  HomeViewController.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 12/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

fileprivate let reuseIdentifier = "forecastCell"

class HomeViewController: UIViewController {
    
    @IBOutlet weak var errorMsgLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView:NVActivityIndicatorView!
    
    // forecast date display formatter
    var formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
        
    }()
    
    // unit display depending the units from the webservice (°C, °F or °K)
    lazy var unitString:String = {
        return CityForecast.stringForUnits(tempUnits)
    }()
    
    
    var tableData:[Forecast] = [] // the tableView data source
    
    var isLoading: Bool = false
    
    var cityId:Int = 2988507 // default city Id: Paris

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // init the loadingView (set color, loadview type)
        self.loadingView.color = .red
        self.loadingView.type = .ballPulseSync
        
        // register our custom cell to the tableView
        let cell = UINib(nibName: "ForecastCell", bundle: nil)
        self.tableView.register(cell, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.rowHeight = 90
        
        
        /*
         init navigation bar items:
         - reload button to reload the data
         - edit button to change the city
        */
        let reloadBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshTableBtnPressed))
        self.navigationItem.leftBarButtonItem = reloadBtn
        
        let editBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editCityBtnPressed))
        self.navigationItem.rightBarButtonItem = editBtn
        
        
        
        /*
         Load the inital data for the default city (Boston)
         */
        loadData(cityId: cityId)
        
    }
    
    @objc func refreshTableBtnPressed(sender: Any) {
        loadData(cityId: cityId)
    }
    
    @objc func editCityBtnPressed(sender: Any) {
        
        // load and present the SelectCityVC passing the current city ID as the selectedCityID of the VC.
        if let vc = storyboard?.instantiateViewController(withIdentifier: "selectCityVC") as? SelectCityViewController {
            vc.selectedCityId = cityId
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    func loadData(cityId: Int) {
        
        // if we are already loading the data from the API, do nothing
        if !isLoading {
            
            // init the loading
            /* ===========
             INIT LOADING:
             hide the tableView, display the loadingView, set the value isLoading to true, set the navigationBar title to Loading..
             ===========*/
            
            self.tableView.isHidden = true
            self.loadingView.startAnimating()
            self.errorMsgLabel.isHidden = true
            self.isLoading = true
            self.navigationItem.title = "Loading..."
            
            CityForecast.cityForecastById(cityId, units: tempUnits, completionHandler: { (cityForecast, error) in
                
                // set the loading to false
                self.isLoading = false
                
                //handle the error in the data
                if let error = error {
                    
                    // go to the main queue to execute UI changes
                    DispatchQueue.main.async {
                        // stop the loading view
                        self.loadingView.stopAnimating()
                        
                        
                        // display the error to the screen
                        self.errorMsgLabel.text = error.localizedDescription
                        self.errorMsgLabel.isHidden = false
                        
                        // change the navigationBar title
                        self.navigationItem.title = "Error"
                        
                    }
                    
                    self.isLoading = false
                    
                    return
                }
                
                guard let cityForecast = cityForecast else {
                    
                    // go to the main queue to execute UI changes
                    DispatchQueue.main.async {
                        //stop the loading view
                        self.loadingView.stopAnimating()
                        
                        // display the error to the screen
                        self.errorMsgLabel.text = "error getting cityForecast data: result is nil"
                        self.errorMsgLabel.isHidden = false
                        
                        // change the navigationBar title
                        self.navigationItem.title = "Error"
                    }
                    
                    self.isLoading  = false
                    
                    return
                }

                
                self.tableData = cityForecast.list
                
                // go to the main queue to execute UI changes
                DispatchQueue.main.async {
                    
                    //hide errorMsgView
                    self.errorMsgLabel.isHidden = true
                    
                    // stop loading animation
                    self.loadingView.stopAnimating()
                    
                    // reload the tableView
                    self.tableView.reloadData()
                    
                    //set the navigationBar Title
                    self.navigationItem.title = "\(cityForecast.city.name) Weather"
                    
                    // display the tableView
                    self.tableView.isHidden = false
                    
                }
                
            })
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

/*
 // MARK: - TableView Data Source
*/

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ForecastCell {
            
            // pass data to the cell
            cell.dateLabel.text = formatter.string(from: tableData[indexPath.row].dt)
            cell.tempLabel.text = String(format: "%.1f °\(unitString)", tableData[indexPath.row].temp)
            cell.weatherIcon.image = UIImage(named: tableData[indexPath.row].weather[0].icon) ?? nil
            
            return cell
            
        }
        
        return UITableViewCell()
        
    }
    
    
    
    
}


/*
 // MARK: - Select City Delegate
 */
extension HomeViewController: SelectCityDelegate {
    
    func selected(cityId id: Int) {
        if id != cityId {
            cityId = id
            self.loadData(cityId: id)
        }
    }
    
}
