//
//  DentalHygieneViewController.swift
//  DentalHygieneReport
//
//  Created by Avinash Reddy on 3/1/20.
//  Copyright © 2020 Avinash Reddy. All rights reserved.
//

import UIKit

class DentalHygieneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DentalHygieneAPI.requestMoreDentalHygiene(indexPageNumber: "1", completionHandler: handleResponse)
    }
    
    func handleResponse(value: [DentalHygiene]?, error: Error?) {
        guard let value = value else {
            return
        }
        
        print(value)
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
