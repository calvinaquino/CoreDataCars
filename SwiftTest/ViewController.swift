//
//  ViewController.swift
//  SwiftTest
//
//  Created by Calvin Gonçalves de Aquino on 12/14/16.
//  Copyright © 2016 Calvin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView = UITableView()
    var data = [String?]()
    var firstTime = true
    
    let cellIdentifier = "cellIdentifier"
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Makers"
        
        self.view.backgroundColor = UIColor.blue
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.red
        self.view.addSubview(self.tableView)
        populateData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConstraints()
        self.tableView.reloadData()
        if firstTime {
            self.tableView.alpha = 0;
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstTime {
            firstTime = false
            UIView.animate(withDuration: 1.0) {
                self.tableView.alpha = 1
            }
        }
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
////        self.tableView.frame = self.view.frame //for frame
//    }
    
    //MARK: - Custom Methods
    
    func setupConstraints() -> Void {
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:0).isActive = true
    }
    
    func populateData() -> Void {
        self.data = DataProvider.sharedInstance.makers
    }
    

    //MARK: - UITableView delegate|dataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        print("selected " + String(indexPath.row))
        UIView.animate(withDuration: 0.3, animations: {
            cell?.contentView.backgroundColor = UIColor.black
            cell?.textLabel?.textColor = UIColor.white
        }) { (Completed) in
            UIView.animate(withDuration: 0.3, animations: {
                cell?.contentView.backgroundColor = UIColor.cyan
                cell?.textLabel?.textColor = UIColor.black
            }) { (Completed ) in
                let viewController = MakerViewController()
                viewController.maker = self.data[indexPath.row]
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let makerName = self.data[indexPath.row]
        let numberOfCars = DataProvider.sharedInstance.makerCars[makerName!]?.count
        
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(makerName!) (\(numberOfCars!))" //using string interpolation
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.cyan
        
        return cell
    }
}

