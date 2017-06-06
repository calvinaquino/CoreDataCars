//
//  MakerViewController.swift
//  SwiftTest
//
//  Created by Calvin Gonçalves de Aquino on 12/15/16.
//  Copyright © 2016 Calvin. All rights reserved.
//

import UIKit

class MakerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var carsTableView: UITableView!
    //this bastard is an optional.
    var cars: Array<String>?
    
    //this is so when you set a maker, you update the cars array at the same time, along with the view title.
    private var _maker: String?
    var maker: String? {
        get {
            return _maker
        }
        set {
            if _maker != newValue {
                _maker = newValue
                self.title = newValue
                cars = DataProvider.sharedInstance.makerCars[newValue!]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsTableView.delegate = self
        carsTableView.dataSource = self
        carsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "carCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = self.title
        originLabel.text = "I don't know" //yep, pretty useless i know
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(self.cars![indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //properly unwrapping an optional
        if let rowCount = self.cars?.count {
            return rowCount
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath)
        
        let carName = self.cars![indexPath.row]
        
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(carName)"
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.cyan
        
        return cell
    }

}
