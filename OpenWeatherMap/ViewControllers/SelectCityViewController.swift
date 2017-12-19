//
//  SelectCityViewController.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 18/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "cityCell"

class SelectCityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var tableData:[City] = {
        
        // return the city data from the city.json file otherwise an empty array
        return City.loadFromFile(name: "city") ?? []
        
    }()
    
    // the cityID of the selectedCity
    var selectedCityId:Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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
extension SelectCityViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row].name
        
        if let id = selectedCityId {
            if tableData[indexPath.row].id == id {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            cell.accessoryType = .none
        }
            
        return cell
        
    }
    
}


/*
 // MARK: - TableView Delegate
 */
extension SelectCityViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cityId = tableData[indexPath.row].id
        
        if let nav = self.presentingViewController as? UINavigationController {
            
            if let vc = nav.viewControllers[0] as? HomeViewController {
                
                // if the selected cityId is different from the old one, then change it and reload the data
                if cityId != vc.cityId {
                    vc.cityId = cityId
                    vc.loadData(cityId: cityId)
                }
                // close the view
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
