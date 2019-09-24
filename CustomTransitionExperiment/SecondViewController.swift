//
//  SecondViewController.swift
//  CustomTransitionExperiment
//
//  Created by Yoshikuni Kato on 24/09/2019.
//  Copyright © 2019 Yoshikuni Kato. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let button = UIButton()
//        button.setTitle("Close", for: .normal)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
//
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//
//        button.addTarget(self, action: #selector(SecondViewController.buttonTapped(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
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
