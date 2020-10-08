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
    var color:String
    
    init(_ happy:Int, _ food: Int, _ color:String) {
        self.happy = happy
        self.food = food
        self.color = color
    }
    convenience init(_ color:String){
        self.init(0, 0, color)
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
