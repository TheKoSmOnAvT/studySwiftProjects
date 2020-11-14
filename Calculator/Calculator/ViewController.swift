//
//  ViewController.swift
//  Calculator
//
//  Created by Никита Попов on 24.05.2020.
//  Copyright © 2020 Никита Попов. All rights reserved.
//

import UIKit




class ViewController: UIViewController, DataEnteredDelegate {
    func userDidEnterInformation(info: RGB) {
        newColore = info
        changeColore()
        print(info.blue!)
    }
    
    var newColore : RGB!
    
    var mainNumber : Double = 0
    var secondNumber : Double = 0
    var action = false
    var ac = true
    var dot = false
    var tagAction : Int = 0
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var zeroBtutton: UIButton!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var deletebutton: UIButton!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        labelValue.text = "0"
        labelValue.layer.borderWidth = 0.5
        labelValue.layer.cornerRadius = 0.09 * zeroBtutton.bounds.size.width
        labelValue.clipsToBounds = true
        labelValue.layer.borderColor = UIColor.white.cgColor
        
        for i in buttons{
            i.layer.cornerRadius = 0.5 * i.bounds.size.width
            i.clipsToBounds = true
            i.layer.borderColor = UIColor(red: 1.00, green: 0.58, blue: 0.00, alpha: 1.00).cgColor
        }
     
        zeroBtutton.layer.cornerRadius = 0.11 * zeroBtutton.bounds.size.width
        zeroBtutton.clipsToBounds = true
    }

    @IBAction func clickButton(_ sender: UIButton) {
        switch sender.tag {
        case 0...9:
            addNumber(sender)
        case 10:
            clear()
        case 17:
            calculate()
        case 11:
            invert()
            update()
        case 12:
            procent()
            update()
        case 13...16:
            startAction(sender)
        case 18:
            addDot()
        default: break
        }
    }
    
    
    public func addDot(){
        if(!dot) {
            var intNum = Int64(mainNumber)
            if(secondNumber == 0 && action){
                labelValue.text = "0."
            } else if(mainNumber == 0 && !action) {
                labelValue.text = "0."
            }
            else if(Double(intNum) == mainNumber){
                labelValue.text = labelValue.text! + "."
            }
        }
       dot = true
    }
    
    
    
    
    public func addNumber(_ sender: UIButton){
        checkZero()
        ac = false
        if(!dot){
            if(!action){
               mainNumber = mainNumber * (10) + Double(sender.tag)
            } else {
               secondNumber = secondNumber * (10) + Double(sender.tag)
            }
            update()
        } else {
            labelValue.text = (String(labelValue.text!) + String(sender.tag))
            if(!action){
                mainNumber = Double(labelValue.text!)!
            } else {
                secondNumber = Double(labelValue.text!)!
            }
        }
    }
    
    public func startAction(_ sender: UIButton){
        dot = false
        action = true
        tagAction = sender.tag
        secondNumber = 0
    }
    
    
    
    public func clear(){
       ac = true
       labelValue.text = "0"
       deletebutton.setTitle("AC", for: .normal)
       mainNumber = 0
       secondNumber = 0
       dot = false
    }
    
    
    public func procent(){
        if(!action){
                   mainNumber = mainNumber / 100
                } else {
                   secondNumber = secondNumber / 100
               }
    }
    
    
    public func invert(){
         if(!action){
            mainNumber = mainNumber * (-1)
         } else {
            secondNumber = secondNumber * (-1)
        }
    }
    
    public func update(){
        mainNumber = round(1000000*mainNumber)/1000000
        secondNumber = round(1000000*secondNumber)/1000000
        if(!action){
            let intNum = Int64(mainNumber)
            if(Double(intNum) == mainNumber){
                labelValue.text = String(intNum)
            } else {
                labelValue.text = String(mainNumber)
            }
        } else {
             let intNum = Int64(secondNumber)
             if(Double(intNum) == secondNumber){
                 labelValue.text = String(intNum)
             } else {
                 labelValue.text = String(secondNumber)
             }
        }
    }
    
    public func calculate(){
       
        if(tagAction == 16){
            action = false
            dot = false
            mainNumber = Double(Float(mainNumber) + Float(secondNumber))
            update()
        } else if(tagAction == 15){
            action = false
            dot = false
            mainNumber = Double(Float(mainNumber) - Float(secondNumber))
            update()
        }else if(tagAction == 14){
            action = false
            dot = false
            mainNumber = Double(Float(mainNumber) * Float(secondNumber))
            update()
        }else if(tagAction == 13){
            action = false
            dot = false
            if(secondNumber != 0){
                mainNumber = Double(Float(mainNumber) / Float(secondNumber))
                update()
            } else {
                labelValue.text = "Error"
                mainNumber = 0
                secondNumber = 0
            }
        }
        
    }
    
    public func checkZero(){
            if(ac && labelValue.text == "0"){
                 labelValue.text = ""
                deletebutton.setTitle("C", for: .normal)
            }
        }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newColore" {
            let ColorChanger = segue.destination as! ColorChanger
            ColorChanger.delegate = self
        }
    }
    
    
    public func changeColore(){
        if(newColore.numColor == 1){ //background
            self.view.backgroundColor = UIColor(red: newColore.red!, green: newColore.green!, blue: newColore.blue!, alpha: 1)
        } else if (newColore.numColor == 2) {
            for i in buttons
            {
                zeroBtutton.backgroundColor =  UIColor(red: newColore.red!, green: newColore.green!, blue: newColore.blue!, alpha: 1)
                if i.tag < 10 || i.tag == 18 {
                    i.backgroundColor =  UIColor(red: newColore.red!, green: newColore.green!, blue: newColore.blue!, alpha: 1)
                }
            }
        } else if (newColore.numColor == 3) {
            for i in buttons
            {
                if i.tag <= 17  && i.tag >= 13 {
                    i.backgroundColor =  UIColor(red: newColore.red!, green: newColore.green!, blue: newColore.blue!, alpha: 1)
                }
            }
        } else if (newColore.numColor == 4) {
            labelValue.backgroundColor = UIColor(red: newColore.red!, green: newColore.green!, blue: newColore.blue!, alpha: 1)
        }
        
    }


}

