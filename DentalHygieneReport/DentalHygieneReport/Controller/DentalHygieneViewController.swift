//
//  DentalHygieneViewController.swift
//  DentalHygieneReport
//
//  Created by Avinash Reddy on 3/1/20.
//  Copyright © 2020 Avinash Reddy. All rights reserved.
//

import UIKit
import Charts

class DentalHygieneViewController: UIViewController {
    
    var dentalHygieneResponse = [DentalHygiene]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let task = URLSession.shared.dataTask(with: DentalHygieneAPI.Endpoint.moreDentalHygieneCollection("1").url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                self.dentalHygieneResponse = try decoder.decode([DentalHygiene].self, from: data)
                print(self.dentalHygieneResponse[4].numberOfPeople)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    @IBAction func navigationOfPage(_ sender: UIButton) {
        
    }
    
    @IBAction func enterCustomPageSize(_ sender: UIButton) {
        
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
