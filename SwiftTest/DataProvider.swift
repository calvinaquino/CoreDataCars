//
//  DataProvider.swift
//  SwiftTest
//
//  Created by Calvin Gonçalves de Aquino on 12/15/16.
//  Copyright © 2016 Calvin. All rights reserved.
//

import UIKit
import CoreData

class DataProvider: NSObject {
    static let sharedInstance = DataProvider() //singleton, swift <3
    
//    var makers: [NSManagedObject] = [] //use core data when i stop being lazy
    
    //lazy loading, returns an array literal
    lazy var makers: Array<String> = {
        return [
            "Ferrari",
            "Lamborghini",
            "Koenigsegg",
            "Honda",
            "Toyota",
            "Subaru",
            "Mazda",
            "Ford",
            "Peugeot",
            "Volkswagen",
        ]
    }()
    
    //again lazy loading
    lazy var makerCars: Dictionary<String, Array<String>> = {
        let dataProvider = DataProvider.sharedInstance
        let makerNames = dataProvider.makers
        
        var makerCarsVar = Dictionary<String, Array<String>>()
        
        for makerName in makerNames {
            makerCarsVar[makerName] = dataProvider.carsForMaker(makerName: makerName)
        }
        
        return makerCarsVar
    }()
    
    //mock data, no core data here for now. funny the project name is coreData example hehehe
    private func carsForMaker(makerName: String) -> Array<String> {
        var cars: Array<String>
        
        if makerName == "Ferrari" {
            cars = [
                "Maranello",
                "F40",
                "F355",
                "F50",
            ]
        } else if makerName == "Lamborghini" {
            cars = [
                "Aventador",
                "Murcielago",
                "Diablo",
                "Countach",
            ]
        } else if makerName == "Koenigsegg" {
            cars = [
                "One:1",
                "Regera",
                "Agera R",
                "CCX",
            ]
        } else if makerName == "Honda" {
            cars = [
                "Civic",
                "S2000",
                "Accord",
                "NSX",
            ]
        } else if makerName == "Toyota" {
            cars = [
                "Supra",
                "Celica",
                "GT86",
                "Trueno",
            ]
        } else if makerName == "Subaru" {
            cars = [
                "Impreza",
                "BRZ",
                "Legacy",
                "WRX",
            ]
        } else if makerName == "Mazda" {
            cars = [
                "MX-3",
                "MX-5",
                "RX-7",
                "RX-8",
            ]
        } else if makerName == "Ford" {
            cars = [
                "Focus RS",
                "Mustang",
                "GT-40",
                "Fusion",
            ]
        } else if makerName == "Peugeot" {
            cars = [
                "206",
                "207",
                "307",
                "308",
            ]
        } else if makerName == "Volkswagen" {
            cars = [
                "Bettle",
                "Golf R",
                "Jetta",
                "Passat",
            ]
        } else {
            cars = []
        }
        
        return cars
    }
}
