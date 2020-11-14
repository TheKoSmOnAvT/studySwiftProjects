//
//  ColorChanger.swift
//  Calculator
//
//  Created by Никита Попов on 27.05.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: RGB)
}

class ColorChanger: UIViewController {
    
    weak var delegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var color: UILabel!
        
    var rgbColore : [CGFloat] = [0.47,0.47,0.47]
    var itemColor : UIColor? = nil
    public var tagSlider : Int = -1
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var blueNumLabel: UILabel!
    @IBOutlet weak var redNumLabel: UILabel!
    @IBOutlet weak var greenNumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color.layer.borderWidth = 3
        color.layer.cornerRadius = 0.2 * color.bounds.size.width
        color.clipsToBounds = true
        color.layer.borderColor = UIColor.white.cgColor
        color.backgroundColor = UIColor.init(displayP3Red: rgbColore[0], green: rgbColore[1], blue: rgbColore[2], alpha: 1.0)
        changeButton.layer.borderWidth = 3
        changeButton.clipsToBounds = true
        changeButton.layer.borderColor = UIColor.white.cgColor
    }

    
    @IBAction func sliderAction(_ sender: UISlider) {
                if(sender.tag == 1 ){
                    let num = Int( sender.value)
                    updateRGB(0,num)
                    redNumLabel.text =  String(num)
                }
                else if(sender.tag == 2 ){
                    let num = Int( sender.value)
                     updateRGB(1,num)
                    greenNumLabel.text = String(num)
                } else {
                    let num = Int( sender.value)
                     updateRGB(2,num)
                     blueNumLabel.text =  String( num )
                }
    }
        
    @IBOutlet var switchCollecions: [UISwitch]!
    
    
    @IBAction func switches(_ sender: UISwitch) {
            tagSlider = sender.tag
                for i in switchCollecions{
                    if(i.tag != tagSlider){
                        i.isOn=false
                    }
                }
    }
    
    func updateRGB(_ colorNum: Int, _ tint : Int){
        rgbColore[colorNum] =  (CGFloat(tint)/255.0)
        //print(rgbColore[0],rgbColore[1],rgbColore[2])
        color.backgroundColor =  UIColor.init(displayP3Red: rgbColore[0], green: rgbColore[1], blue: rgbColore[2], alpha: 1.0)
        
    }
    

    @IBAction func changeButton(_ sender: Any) {
        print("change")
        var newColore : RGB =  RGB(rgbColore[0], rgbColore[1], rgbColore[2], tagSlider)
        delegate?.userDidEnterInformation(info: newColore)
        self.dismiss(animated: true, completion: {})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(segue.identifier)

    }
    
}
