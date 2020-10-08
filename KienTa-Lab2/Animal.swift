//
//  Animal.swift
//  KienTa-Lab2
//
//  Created by Kien Ta on 10/8/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit

class Animal{
    var happy:Int
    var food:Int
    
    init(_ happy:Int, _ food: Int) {
        self.happy = happy
        self.food = food
    }
    convenience init(){
        self.init(0, 0)
    }
    func play(){
        if(food >= 1){
            happy += 1
            food -= 1
        }
    }
    func feed(){
        food += 1
    }
}
