//
//  ViewController.swift
//  ForecastApp
//
//  Created by 전혜성 on 2022/01/30.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var listTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

