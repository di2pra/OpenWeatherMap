//
//  SelectCityViewController.swift
//  OpenWeatherMap
//
//  Created by Pradheep Rajendirane on 18/12/2017.
//  Copyright © 2017 Pradheep Rajendirane. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "cityCell"


protocol SelectCityDelegate: class  {
    
    /*
    called when user select a city from the tableView
     provide the id (Int) of the selected city
    */
    func selected(cityId id: Int)
    
}


class SelectCityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:SelectCityDelegate?
    
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
        
        self.delegate?.selected(cityId: tableData[indexPath.row].id)
        self.dismiss(animated: true, completion: nil)
    }
    
}
