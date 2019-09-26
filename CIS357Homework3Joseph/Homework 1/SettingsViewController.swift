//
//  SettingsViewController.swift
//  Homework 1
//
//  Created by Jemima Turnbull on 9/24/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit
protocol SettingsViewControllerDelegate {
    func settingsChanged(fromUnits: String, toUnits: String)}

class SettingsViewController: UIViewController {
    
    var pickerData: [String] = [String]()
    var Arr : [String] = ["Yards", "Liters"]
    var delegate : SettingsViewControllerDelegate?
    var LabelClicked : String = ""
    
    @IBOutlet weak var MeasurementPicker: UIPickerView!
    @IBOutlet weak var FromUnits: UILabel!
    @IBOutlet weak var ToUnits: UILabel!
    @IBOutlet weak var FirstMeasurement: UILabel!
    @IBOutlet weak var SecondMeasurement: UILabel!
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Arr[0] = defaults.string(forKey: "first")!
        Arr[1] = defaults.string(forKey: "second")!
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissPickerView))
        self.view.addGestureRecognizer(detectTouch)
        
        self.FirstMeasurement.text = Arr[0]
        self.SecondMeasurement.text = Arr[1]
        
        let FromLabelTouched = UITapGestureRecognizer(target: self, action:
            #selector(self.userDidTapFromLabel));
        let ToLabelTouched = UITapGestureRecognizer(target: self, action:
            #selector(self.userDidTapToLabel));
        
        SecondMeasurement.isUserInteractionEnabled = true;
        FirstMeasurement.isUserInteractionEnabled = true;
        
        FirstMeasurement.addGestureRecognizer(FromLabelTouched)
        SecondMeasurement.addGestureRecognizer(ToLabelTouched)
        
        
        self.MeasurementPicker.delegate = self
        self.MeasurementPicker.dataSource = self
        
    }
    
    @objc func dismissPickerView(){
        self.MeasurementPicker.isHidden = true
        
        
    }
        
    @IBAction func Save(_ sender: UIBarButtonItem) {
    
        if let d = self.delegate {
            d.settingsChanged(fromUnits: Arr[0], toUnits: Arr[1])
//            defaults.setValue(Arr[0], forKey: "first")
//            defaults.setValue(Arr[1], forKey: "second")

        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func userDidTapFromLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        LabelClicked = "From"
        self.MeasurementPicker.isHidden = false
        if(self.isDistance()){
            self.pickerData = ["Meters", "Miles", "Yards"]
        }
        else{
            self.pickerData = ["Liters", "Gallons", "Quarts"]
        }
        self.MeasurementPicker.delegate = self
        self.MeasurementPicker.dataSource = self
        self.MeasurementPicker.reloadAllComponents()
        
    }
    
    @objc func userDidTapToLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        LabelClicked = "To"
        self.MeasurementPicker.isHidden = false
        if(self.isDistance()){
            self.pickerData = ["Meters", "Miles", "Yards"]
        }
        else{
            self.pickerData = ["Liters", "Gallons", "Quarts"]
        }
        self.MeasurementPicker.delegate = self
        self.MeasurementPicker.dataSource = self
        self.MeasurementPicker.reloadAllComponents()
        
    }
    
    
    
    @objc func isDistanceView(pickerData: [String]) -> Bool{
        if pickerData[0] == "Meters" {
            return true
        }
        else {
            return false
        }
        
    }
    
    @objc func isDistance() -> Bool{
        if (Arr[0] == "Yards" || Arr[0] == "Miles" || Arr[0] == "Meters" ){
            return true
        }
        else {
            return false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if isDistanceView(pickerData: pickerData) == true {
            if(LabelClicked == "From"){
                self.FirstMeasurement.text = self.pickerData[row]
            }else{
                self.SecondMeasurement.text = self.pickerData[row]
            }
            self.Arr[0] = self.FirstMeasurement.text!
            self.Arr[1] = self.SecondMeasurement.text!
        }
        else {
            if(LabelClicked == "From"){
                self.FirstMeasurement.text = self.pickerData[row]
            }else{
                self.SecondMeasurement.text = self.pickerData[row]
            }
            self.Arr[0] = self.FirstMeasurement.text!
            self.Arr[1] = self.SecondMeasurement.text!
        
        }
    }
}

