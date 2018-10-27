//
//  ViewController.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 20/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

var url = firstURL
var webV:UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
var urlr = URLRequest(url: url!)

let gobackButton = UIButton(frame: CGRect(x: 20, y: 600, width: 50, height: 50))


class MainViewController: UIViewController {

    var demoPresenter: ButtonsDemoPresenter?
    var buttonsArr = [RHButtonView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //webV.load(URLRequest(url: url!))
        webV.loadRequest(urlr)
        //webV.delegate = self as! UIWebViewDelegate;
        self.view.addSubview(webV)
        
        
    
        
        
        //button.backgroundColor = .green
        //button.setTitle("Test Button", for: [])
        gobackButton.setImage(#imageLiteral(resourceName: "goback"), for: .normal)
        gobackButton.imageView?.contentMode = .scaleAspectFit
        gobackButton.addTarget(self, action: #selector(goBack), for: .touchDown)
        gobackButton.isHidden = true
        gobackButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
        gobackButton.layer.cornerRadius = gobackButton.frame.width/2
        self.view.addSubview(gobackButton)
        
        
        setup()
        
    }
    
    @objc func goBack()
    {
        if webV.canGoBack
        {
            webV.goBack()
        }
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        castView().sideButtonsView?.reloadButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // We want to see demo after view did appear
        demoPresenter?.start()
        
        
        
    }
    
    override func loadView()
    {
        view = MainView()
    }
    
    func castView() -> MainView {
        return view as! MainView
    }
    
    fileprivate func setup() {
        addSideButtons()
    }
    
    fileprivate func addSideButtons() {
        
        let triggerButton = RHTriggerButtonView(pressedImage: UIImage(named: "exit_icon")!) {
            $0.image = UIImage(named: "trigger_img")
            $0.hasShadow = true
        }
        
        let sideButtonsView = RHSideButtons(parentView: castView(), triggerButton: triggerButton)
        sideButtonsView.delegate = self
        sideButtonsView.dataSource = self
        
        for index in 1...3 {
            buttonsArr.append(generateButton(withImgName: "icon_\(index)"))
        }
        
        castView().set(sideButtonsView: sideButtonsView)
        castView().sideButtonsView?.reloadButtons()
    }
    
    fileprivate func generateButton(withImgName imgName: String) -> RHButtonView {
        
        return RHButtonView {
            $0.image = UIImage(named: imgName)
            $0.hasShadow = true
        }
    }
}

extension MainViewController: RHSideButtonsDataSource {
    
    func sideButtonsNumberOfButtons(_ sideButtons: RHSideButtons) -> Int {
        return buttonsArr.count
    }
    
    func sideButtons(_ sideButtons: RHSideButtons, buttonAtIndex index: Int) -> RHButtonView {
        return buttonsArr[index]
    }
}

extension MainViewController: RHSideButtonsDelegate {
    
    func sideButtons(_ sideButtons: RHSideButtons, didSelectButtonAtIndex index: Int) {
        print("🍭 button index tapped: \(index)")
        
        if(index==2)
        {
            print("Yahoo")
            url = URL(string: "https://www.yahoo.com")
            urlr = URLRequest(url: url!)
            gobackButton.isHidden = true
            webV.loadRequest(urlr)
        }
        if(index==1)
        {
            print("Linkedin")
            url = URL(string: "https://www.linkedin.com")
            urlr = URLRequest(url: url!)
            gobackButton.isHidden = true
            webV.loadRequest(urlr)
        }
        if(index==0)
        {
            print("Youtube")
            url = URL(string: "https://www.youtube.com")
            urlr = URLRequest(url: url!)
            gobackButton.isHidden = true
            webV.loadRequest(urlr)
        }
        
       
        
        
        
       
    }
    
    func sideButtons(_ sideButtons: RHSideButtons, didTriggerButtonChangeStateTo state: RHButtonState) {
        print("🍭 Trigger button")
        
        if gobackButton.isHidden
        {
            gobackButton.isHidden = false
        }
        else
        {
            gobackButton.isHidden = true
        }
        
       
    }
}

