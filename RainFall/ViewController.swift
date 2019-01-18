//
//  ViewController.swift
//  RainFall
//
//  Created by Esteban Ordonez on 1/16/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let nRows: Int = 12;
    var row: Int = 0;
    var months: [String] = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
    ];
    
    var rainFall:[Double] = [Double]();
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.placeholder = "Please enter rain in inches for every month in a year.";
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        if let text: String = sender.text {
            if let data: Double = Double(text){
                rainFall.append(data);
                row += 1;
                
                if row == nRows{
                    myFunc()
                    display()
                    return;
                }
            }
            textField.text = nil;  //Allow the placeholder to appear.
            textField.placeholder = "Please enter rain in inches for every month.";
            
        }
    }
    
    @IBAction func getStats(_ sender: UIButton) {
        textField.resignFirstResponder();
        minMax()
        workData()
        //sender.isTouchInside
        
    }
    
    func myFunc(){
        textField.resignFirstResponder();
        textField.isEnabled = false;
        textField.text = nil;
        textField.placeholder = nil;
    }
    
    func display(){
        print (months.count , rainFall.count)
        months.forEach{print($0)}
        rainFall.forEach{print($0)}
        
        for (month, rain) in zip(months, rainFall) {
            label.text! += String(format: "%13@: %.2f\n", month, rain)// Optional variable, forced unwrapping.
            
        }
    }
    
    func workData(){
        let sum: Double = rainFall.reduce(0, +)//Sum of all data
        let avg: Double = sum / Double(rainFall.count)
        let variance: Double =  sum / Double(rainFall.count - 1);// Variance for the sample.
        let sDeviation: Double = sqrt(variance);//Standard deviation for the sample.
        
        if rainFall.isEmpty{
            dataLabel.text = "please enter measurements for all twelve months"
        }else{
            dataLabel.text! += String(format:"The Sum of all months' rain is %.2f.\n", sum); // sum of all months. Forced unwrapping
            dataLabel.text! += String(format:"The Average rain for the year is %.2f.\n", avg);// Average. Forced unwrapping
            dataLabel.text! += String(format:"Variance is %.2f.\n", variance);// variance.
            dataLabel.text! += String(format:"Standard Deviation is %.2f.\n", sDeviation);// Standard Dev. Forced unwrapping
            
        }
        
    }
    
    func minMax(){
        if let min: Double = rainFall.min(){
            if let max: Double = rainFall.max(){
                dataLabel.text = String(format: "Minimum precipitation was %.2f.\nMaximum precipitation was %.2f.\n", min, max);// Min and Max.
                
            }
        }
    }
    
}









