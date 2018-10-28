//
//  ViewController.swift
//  Hackathon
//
//  Created by Mihai Alexandru Manolescu on 27/10/2018.
//  Copyright © 2018 Mihai Alexandru Manolescu. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class ViewController: UIViewController
{
    

    
    @IBOutlet weak var webk: WKWebView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        let url = URL(string: "https://stackoverflow.com/questions/32733431/wkwebview-not-in-xcode")
        webk.load(URLRequest(url: url!))
       
        
        
        
        let myNewView=UIView(frame: CGRect(x: 10, y: 100, width: 300, height: 200))
        
        // Change UIView background colour
        myNewView.backgroundColor=UIColor.lightGray
        
        // Add rounded corners to UIView
        myNewView.layer.cornerRadius=25
        
        // Add border to UIView
        myNewView.layer.borderWidth=2
        
        // Change UIView Border Color to Red
        myNewView.layer.borderColor = UIColor.red.cgColor
        
        // Add UIView as a Subview
        self.view.addSubview(myNewView)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

