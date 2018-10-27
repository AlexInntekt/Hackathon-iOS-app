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
       
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

