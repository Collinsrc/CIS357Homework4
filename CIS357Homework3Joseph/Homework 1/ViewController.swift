//
//  ViewController.swift
//  Homework 1
//
//  Created by Xcode User on 9/18/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate{
    
    
    
    @IBOutlet weak var FromMeasurement: UILabel!
    @IBOutlet weak var ToMeasurement: UILabel!
    
    @IBOutlet weak var ToField: DecimalMinusTextField!
    @IBOutlet weak var FromField: DecimalMinusTextField!
    @IBOutlet weak var ModeTapped: UIButton!
    
    var isDistance = true
    var FromUnitsDefault: String = ""
    var ToUnitsDefault: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboardAndFields));
        self.view.addGestureRecognizer(detectTouch)
        UserDefaults.standard.setValue(FromMeasurement.text, forKey: "first")
        UserDefaults.standard.setValue(ToMeasurement.text, forKey: "second")
        
        self.FromUnitsDefault = UserDefaults.standard.string(forKey: "first") ?? "Meters"
        self.ToUnitsDefault = UserDefaults.standard.string(forKey: "second") ?? "Yards"
        
        self.FromField.delegate = self
        self.ToField.delegate = self
        
    }
    func settingsChanged(fromUnits: String, toUnits: String) {
        self.FromMeasurement.text = fromUnits
        self.ToMeasurement.text = toUnits
    }
    
    
    @objc func dismissKeyboardAndFields(){
        self.view.endEditing(true)
        self.FromField.text = ""
        self.ToField.text = ""
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func ModeTapped(_ sender: UIButton) {
        if(isDistance){
            self.FromMeasurement.text = "Liters"
            self.ToMeasurement.text = "Gallons"
        }
        else{
            self.FromMeasurement.text = "Yards"
            self.ToMeasurement.text = "Meters"
        }
        isDistance = !isDistance
        UserDefaults.standard.setValue(self.FromMeasurement.text, forKey: "first")
        UserDefaults.standard.setValue(self.ToMeasurement.text, forKey: "second")
    }
    
    @IBAction func CalculateButtonTapped(_ sender: UIButton) {
        self.calculate()
    }
    
    @IBAction func ClearButtonTapped(_ sender: UIButton) {
        self.FromField.text = ""
        self.ToField.text = ""
    }
    
    
    func ValidateFields() -> Bool {
        if self.FromField.text != "" || self.ToField.text != ""{
            return true;
        }
        else{
            return false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewSettingsSegue" {
            if let nc = segue.destination as? UINavigationController {
                if let dest = nc.children[0] as? SettingsViewController {
                    dest.delegate = self
                    
                }
                
            }
            
        }
    }
    
    
    func calculate(){
        if ValidateFields() == true{
            if(FromMeasurement.text == "Meters" || FromMeasurement.text == "Yards" || FromMeasurement.text == "Miles"){
                var LCK = LengthConversionKey(toUnits: .Meters, fromUnits: .Meters)
                if(self.FromMeasurement.text == "Meters" && self.ToMeasurement.text == "Meters"){
                    LCK = LengthConversionKey(toUnits: .Meters, fromUnits: .Meters)
                }
                else if(self.FromMeasurement.text == "Meters" && self.ToMeasurement.text == "Yards"){
                    if(FromField.text != ""){
                        LCK = LengthConversionKey(toUnits: .Yards, fromUnits: .Meters)
                    }
                    else{
                        LCK = LengthConversionKey(toUnits: .Meters, fromUnits: .Yards)
                    }
                }
                else if(self.FromMeasurement.text == "Meters" && self.ToMeasurement.text == "Miles"){
                    if(FromField.text != ""){
                        LCK = LengthConversionKey(toUnits: .Miles, fromUnits: .Meters)
                    }
                    else{
                        LCK = LengthConversionKey(toUnits: .Meters, fromUnits: .Miles)
                    }
                }
                else if(self.FromMeasurement.text == "Yards" && self.ToMeasurement.text == "Meters"){
                    if(ToField.text == ""){
                        LCK = LengthConversionKey(toUnits: .Meters, fromUnits: .Yards)
                    }
                    else{
                        LCK = LengthConversionKey(toUnits: .Yards, fromUnits: .Meters)
                    }
                }
                else if(self.FromMeasurement.text == "Yards" && self.ToMeasurement.text == "Yards"){
                    LCK = LengthConversionKey(toUnits: .Yards, fromUnits: .Yards)
                }
                else if(self.FromMeasurement.text == "Yards" && self.ToMeasurement.text == "Miles"){
                    if(FromField.text != ""){
                        LCK = LengthConversionKey(toUnits: .Miles, fromUnits: .Yards)
                    } else{
                        LCK = LengthConversionKey(toUnits: .Yards, fromUnits: .Miles)
                    }
                }
                else if(self.FromMeasurement.text == "Miles" && self.ToMeasurement.text == "Meters"){
                    if(ToField.text == ""){
                        LCK = LengthConversionKey(toUnits: .Meters, fromUnits: .Miles)
                    }else{
                        LCK = LengthConversionKey(toUnits: .Miles, fromUnits: .Meters)
                    }
                    
                }
                else if(self.FromMeasurement.text == "Miles" && self.ToMeasurement.text == "Yards"){
                    if(ToField.text == ""){
                        LCK = LengthConversionKey(toUnits: .Yards, fromUnits: .Miles)
                    }
                    else{
                        LCK = LengthConversionKey(toUnits: .Miles, fromUnits: .Yards)
                    }
                }
                else if(self.FromMeasurement.text == "Miles" && self.ToMeasurement.text == "Miles"){
                    LCK = LengthConversionKey(toUnits: .Miles, fromUnits: .Miles)
                }
                if(self.FromField.text != ""){
                    let toVal = Double(self.FromField.text!)! * lengthConversionTable[LCK]!;
                    ToField.text! = String(toVal)
                }
                else{
                    let toVal = Double(self.ToField.text!)! * lengthConversionTable[LCK]!;
                    FromField.text! = String(toVal)
                }
            }else{
                var VCK = VolumeConversionKey(toUnits: .Liters, fromUnits: .Liters)
                if(self.FromMeasurement.text == "Liters" && self.ToMeasurement.text == "Liters"){
                    VCK = VolumeConversionKey(toUnits: .Liters, fromUnits: .Liters)
                }
                else if(self.FromMeasurement.text == "Liters" && self.ToMeasurement.text == "Gallons"){
                    if(FromField.text != ""){
                        VCK = VolumeConversionKey(toUnits: .Gallons, fromUnits: .Liters)
                    }
                    else{
                        VCK = VolumeConversionKey(toUnits: .Liters, fromUnits: .Gallons)
                    }
                }
                else if(self.FromMeasurement.text == "Liters" && self.ToMeasurement.text == "Quarts"){
                    if(FromField.text != ""){
                        VCK = VolumeConversionKey(toUnits: .Quarts, fromUnits: .Liters)
                    }
                    else{
                        VCK = VolumeConversionKey(toUnits: .Liters, fromUnits: .Quarts)
                    }
                }
                else if(self.FromMeasurement.text == "Gallons" && self.ToMeasurement.text == "Liters"){
                    if(ToField.text == ""){
                        VCK = VolumeConversionKey(toUnits: .Liters, fromUnits: .Gallons)
                    }
                    else{
                        VCK = VolumeConversionKey(toUnits: .Gallons, fromUnits: .Liters)
                    }
                    
                }
                else if(self.FromMeasurement.text == "Gallons" && self.ToMeasurement.text == "Gallons"){
                    VCK = VolumeConversionKey(toUnits: .Gallons, fromUnits: .Gallons)
                }
                else if(self.FromMeasurement.text == "Gallons" && self.ToMeasurement.text == "Quarts"){
                    if(FromField.text != ""){
                        
                        VCK = VolumeConversionKey(toUnits: .Quarts, fromUnits: .Gallons)
                    }
                    else{
                        VCK = VolumeConversionKey(toUnits: .Gallons, fromUnits: .Quarts)
                    }
                }
                else if(self.FromMeasurement.text == "Quarts" && self.ToMeasurement.text == "Liters"){
                    if(ToField.text == ""){
                        VCK = VolumeConversionKey(toUnits: .Liters, fromUnits: .Quarts)
                    }
                    else{
                        VCK = VolumeConversionKey(toUnits: .Quarts, fromUnits: .Liters)
                    }
                }
                else if(self.FromMeasurement.text == "Quarts" && self.ToMeasurement.text == "Gallons"){
                    if(ToField.text == ""){
                        VCK = VolumeConversionKey(toUnits: .Gallons, fromUnits: .Quarts)
                    }
                    else{
                        VCK = VolumeConversionKey(toUnits: .Quarts, fromUnits: .Gallons)
                    }
                }
                else if(self.FromMeasurement.text == "Quarts" && self.ToMeasurement.text == "Quarts"){
                    VCK = VolumeConversionKey(toUnits: .Quarts, fromUnits: .Quarts)
                }
                if(self.FromField.text != ""){
                    let toVal = Double(self.FromField.text!)! * volumeConversionTable[VCK]!;
                    ToField.text! = String(toVal)
                }
                else{
                    let toVal = Double(self.ToField.text!)! * volumeConversionTable[VCK]!;
                    FromField.text! = String(toVal)
                }
            }
            self.dismissKeyboard()
            
        }
    }
}




extension ViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.FromField{
            self.ToField.text = ""
        }
        else {
            self.FromField.text = ""
        }
        
    }
    
}

