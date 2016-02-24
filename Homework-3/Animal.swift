//
//  File.swift
//  Homework-3
//
//  Created by Tianlin Yang on 2/17/16.
//  Copyright © 2016 Tianlin Yang. All rights reserved.
//

import Foundation

class AnimalName {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func prettyAnimalName() -> String {
        return "Animal name: " + self.name
}
}

class Animal {
    let animal: String?
    let name: AnimalName
    init(animal: String, name: AnimalName){
        self.animal = animal
        self.name = name
    }
    
    init(name: AnimalName){
        self.animal = nil
        self.name = name
    }
    
    func printAnimalAndName() -> String {
        if self.animal == nil {
            return "No Animal but Animal name is: " + self.name.name
        } else {
            return "Animal is " + self.animal! + " Animal name is: " + self.name.name
        }
    }
    
}


class subclassAnimalName: AnimalName {
    override func prettyAnimalName() -> String {
        return "overrode"
    }
}
