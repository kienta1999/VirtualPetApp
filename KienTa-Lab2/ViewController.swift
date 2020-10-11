//
//  ViewController.swift
//  KienTa-Lab2
//
//  Created by Kien Ta on 10/6/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

class ViewController: UIViewController {
    var currentAnimal:Animal?
    var currentColor:UIColor?
    
    
    var arrayAnimal:[Animal] = []
    var color:[UIColor] = [.red, .blue, .green, .yellow, .orange]
    var images:[UIImage] = [UIImage(named: "dog")!, UIImage(named: "cat")!, UIImage(named: "bird")!, UIImage(named: "bunny")!, UIImage(named: "fish")!]
    let MAX_HAPPY = 10
    let MAX_FOOD = 10
    
    
    @IBOutlet weak var ImageViewOutlet: UIView!
    @IBOutlet weak var animalImageOutlet: UIImageView!
    @IBOutlet weak var happyScoreOutlet: UILabel!
    @IBOutlet weak var happyBarOutlet: DisplayView!
    @IBOutlet weak var foodScoreOutlet: UILabel!
    @IBOutlet weak var foodBarOutlet: DisplayView!
    
    @IBOutlet weak var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in 0...4{
            arrayAnimal.append(Animal())
        }
        currentAnimal = arrayAnimal[0]
        currentColor = color[0]
        animalImageOutlet.image = images[0]
        happyBarOutlet.backgroundColor = .gray
        foodBarOutlet.backgroundColor = .gray
        updateColor(currentColor)
        
    }
    
    
    @IBAction func animalChanged(_ sender: UIButton) {
        let index = sender.tag
        currentAnimal = arrayAnimal[index]
        currentColor = color[index]
        animalImageOutlet.image = images[index]
        updateColor(currentColor)
        updateAnimal()
        
    }
    
    @IBAction func animalPlay(_ sender: UIButton) {
        if(currentAnimal!.food > 0){
            playSound("sound/happy")
        }
        currentAnimal!.play()
        updateAnimal()
    }
    
    @IBAction func animalFeed(_ sender: UIButton) {
        currentAnimal!.feed()
        updateAnimal()
        playSound("sound/eat")
        
    }
    
    func updateAnimal(){
        var happyScore = currentAnimal!.happy
        happyScoreOutlet.text = String("\(happyScore)")
        if(happyScore > MAX_HAPPY){
            happyScore = MAX_HAPPY
        }
        
        happyBarOutlet.animateValue(to: CGFloat(Float(happyScore) / Float(MAX_HAPPY)))
        
        var foodScore = currentAnimal!.food
        foodScoreOutlet.text = String("\(foodScore)")
        if(foodScore > MAX_FOOD){
            foodScore = MAX_FOOD
        }
        foodBarOutlet.animateValue(to: CGFloat(Float(foodScore) / Float(MAX_HAPPY)))
        
        //Adjust icon img
        if(foodScore == 0){
            icon.image = UIImage(named: "sad")
        }
        else if(happyScore >= MAX_HAPPY){
            icon.image = UIImage(named: "heart")
        }
        else{
            icon.image = nil
        }
        
    }
    func updateColor(_ currentColor: UIColor?){
        ImageViewOutlet.backgroundColor = currentColor!
        happyBarOutlet.color = currentColor!
        foodBarOutlet.color = currentColor!
    }
    
    func playSound(_ resource: String) {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}

