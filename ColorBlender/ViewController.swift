//
//  ViewController.swift
//  ColorBlender
//
//  Created by David Gonzalez Jr on 3/30/18.
//  Copyright © 2018 David Gonzalez Jr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var firstColor: UIView!
    @IBOutlet weak var secondColor: UIView!
    
    //Info View
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var hexLabel: UILabel!
    
    
    //Outlet Collection
    @IBOutlet var blendViewCollection: [UIView]!
    @IBOutlet var blendViewCollection_L1: [UIView]!
    @IBOutlet var blendViewCollection_L2: [UIView]!
    @IBOutlet var blendViewCollection_D1: [UIView]!
    @IBOutlet var blendViewCollection_D2: [UIView]!
    
    //Properties
    var currentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Tap Gestures */
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabpGestureCallBack(_:) ))
        firstColor.addGestureRecognizer(tapGesture)
        TabpGestureCallBack(tapGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabpGestureCallBack(_:) ))
        secondColor.addGestureRecognizer(tapGesture)
        
        for i in 0..<blendViewCollection.count {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabpGestureCallBack(_:) ))
            blendViewCollection[i].addGestureRecognizer(tapGesture)
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabpGestureCallBack(_:) ))
            blendViewCollection_L1[i].addGestureRecognizer(tapGesture)
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabpGestureCallBack(_:) ))
            blendViewCollection_D1[i].addGestureRecognizer(tapGesture)
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabpGestureCallBack(_:) ))
            blendViewCollection_D2[i].addGestureRecognizer(tapGesture)
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(TabpGestureCallBack(_:) ))
            blendViewCollection_L2[i].addGestureRecognizer(tapGesture)
        }
        
        UpdateBlendedViews()
        UpdateInfoView()
    }
    
    @objc func TabpGestureCallBack(_ sender: UITapGestureRecognizer) {
        print("Tapped a color view!")
        
        if sender.view!.tag == 0 {
            redSlider.isEnabled = false
            greenSlider.isEnabled = false
            blueSlider.isEnabled = false
        } else {
            redSlider.isEnabled = true
            greenSlider.isEnabled = true
            blueSlider.isEnabled = true
        }
        
        //Anything done prior to currentview equal to sender
        //Unhighlight the previous view
        if currentView != nil {
            currentView.layer.borderWidth = 0
        }
        
        //Change current view to most recently tapped
        currentView = sender.view
        
        //To make the view highlight
        currentView.layer.borderColor = UIColor.white.cgColor
        currentView.layer.borderWidth = 3
        
        //Update slider values to reflect tapped view
        redSlider.value = currentView.backgroundColor!.RGBA().red
        greenSlider.value = currentView.backgroundColor!.RGBA().green
        blueSlider.value = currentView.backgroundColor!.RGBA().blue
        
        UpdateInfoView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Helper method to update the blended colors
    func UpdateBlendedViews() {
        
        //Get the Color Values of First and Second Color
        let color1 = firstColor.backgroundColor!.cgRGBA()
        let color2 = secondColor.backgroundColor!.cgRGBA()
        
        //Calculate the delta for each blendedview color.  Delta(change in)
        let redDelta = (color1.red - color2.red) / 8
        let greenDelta = (color1.green - color2.green) / 8
        let blueDelta = (color1.blue - color2.blue) / 8
        
        //Current color values
        var _red: CGFloat = 0
        var _green: CGFloat = 0
        var _blue: CGFloat = 0
        
        //Loop through and add deltas on each iteration
        for i in 0..<blendViewCollection.count {
            
            //First Color values minus the delta times the iterator
            _red = color1.red - redDelta * CGFloat(i)
            _green = color1.green - greenDelta * CGFloat(i)
            _blue = color1.blue - blueDelta * CGFloat(i)
            
            //Set blendview colors
            blendViewCollection[i].backgroundColor! = UIColor(red: _red, green: _green, blue: _blue, alpha: 1)
            blendViewCollection_D1[i].backgroundColor! = UIColor(red: _red - (_red * 0.25), green: _green - (_green * 0.25), blue: _blue - (_blue * 0.25), alpha: 1)
            blendViewCollection_D2[i].backgroundColor! = UIColor(red: _red - (_red * 0.5), green: _green - (_green * 0.5), blue: _blue - (_blue * 0.5), alpha: 1)
            blendViewCollection_L1[i].backgroundColor! = UIColor(red: _red + (_red * 0.25), green: _green + (_green * 0.25), blue: _blue + (_blue * 0.25), alpha: 1)
            blendViewCollection_L2[i].backgroundColor! = UIColor(red: _red + (_red * 0.5), green: _green + (_green * 0.5), blue: _blue + (_blue * 0.5), alpha: 1)
        }
        
    }
    
    func UpdateInfoView() {
        
        redTextField.text = Int(redSlider.value * 255).description
        greenTextField.text = Int(greenSlider.value * 255).description
        blueTextField.text = Int(blueSlider.value * 255).description
        
        hexLabel.text = "#" + String(format: "%02X", Int(redSlider.value * 255)) + String(format: "%02X", Int(greenSlider.value * 255)) + String(format: "%02X", Int(blueSlider.value * 255))
        
    }

    @IBAction func SliderValueChanged(_ sender: UISlider) {
        
        //Change the color of first color
        currentView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        
        UpdateBlendedViews()
        UpdateInfoView()
        
    }
    
    @IBAction func randomClick(_ sender: Any, forEvent event: UIEvent) {
        let red = CGFloat(randomDouble()), green = CGFloat(randomDouble()), blue = CGFloat(randomDouble())
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        currentView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        
        UpdateBlendedViews()
        UpdateInfoView()
        
    }
    
    func randomDouble() -> Double {
        let valueDouble: Double = Double(arc4random_uniform(UINT32_MAX)) / Double(UINT32_MAX)
        return valueDouble
    }
    
}

