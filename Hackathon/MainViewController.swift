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
        
//        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//        label.center = CGPoint(x: 160, y: 284)
//        label.textAlignment = NSTextAlignment.center
//        label.text = "I'am a test label"
//        self.view.addSubview(label)
//
        
        
        //button.backgroundColor = .green
        //button.setTitle("Test Button", for: [])
        gobackButton.setImage(#imageLiteral(resourceName: "goback"), for: .normal)
        gobackButton.imageView?.contentMode = .scaleAspectFit
        gobackButton.addTarget(self, action: #selector(goBack), for: .touchDown)
        gobackButton.isHidden = true
        gobackButton.backgroundColor = UIColor(white: 1, alpha: 0.8)
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
        
        
        
        for index in 1...4 {
            buttonsArr.append(generateButton(withImgName: "icon_\(index)"))
            
            
            
            //buttonsArr.append(generateButton(withImgName: createFinalImageText()))
            
            //buttonsArr[0].imgView?.image = createFinalImageText(drawText: "lalalala", inImage: #imageLiteral(resourceName: "icon_1"), atPoint: CGPoint(x:0, y:0))
            
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



extension MainViewController: RHSideButtonsDelegate
{
    
    
    func POST(_ floor: Int)
    {

        let url = URL(string: "https://da359681.ngrok.io/ipn/")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "etaj=\(floor)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else
            {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    
    func elevatorConfirmation()
    {
        let ac = UIAlertController(title: "Confirmat", message: nil, preferredStyle: .alert)
       
        let submitAction = UIAlertAction(title: "Okay", style: .default) { [unowned ac] _ in

        }
         ac.addAction(submitAction)
        
        //ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    func promptForAnswer()
    {
        let ac = UIAlertController(title: "Introdu etajul", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Cheama liftul", style: .default) { [unowned ac] _ in
            
            if ac.textFields![0].text != "" && ac.textFields![0].text != nil
            {
               let answer = ac.textFields![0].text
                
                if let answ = answer
                {
                    if Int(answ) != nil
                    {
                          self.POST( Int(answ)! )
                        self.elevatorConfirmation()
                    }
                  
                }
               
            }
            
            // do something interesting with "answer" here
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    func sideButtons(_ sideButtons: RHSideButtons, didSelectButtonAtIndex index: Int) {
        print("🍭 button index tapped: \(index)")
        
        if(index==3)
        {
            print("CALL ELEVATOR")
            
            //POST(0)
            
            promptForAnswer()
            
            gobackButton.isHidden = true
          
        }
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
    
    func sideButtons(_ sideButtons: RHSideButtons, didTriggerButtonChangeStateTo state: RHButtonState)
    {
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
    
    
    func createFinalImageText(drawText: NSString, inImage: UIImage, atPoint: CGPoint) -> UIImage{
        
        // Setup the font specific variables
        var textColor = UIColor.white
        var textFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let color = [ NSAttributedStringKey.foregroundColor: UIColor.blue ]
        let font = [ NSAttributedStringKey.font: UIFont(name: "Chalkduster", size: 36.0)! ]
       // let attributes = [font,color] as [NSAttributedStringKey]
        
        
        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x:0, y:0, width:inImage.size.width, height:inImage.size.height))
        
        // Create a point within the space that is as bit as the image
        var rect = CGRect(x:atPoint.x, y:atPoint.y, width:inImage.size.width, height:inImage.size.height)
        
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: font)
        
        
        // Create a new image out of the images we have created
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage!
        
    }
    
//
//    func createFinalImageText () -> UIImage? {
//
//        let image = #imageLiteral(resourceName: "icon_3")
//
//        let viewToRender = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)) // here you can set the actual image width : image.size.with ?? 0 / height : image.size.height ?? 0
//
//        let imgView = UIImageView(frame: viewToRender.frame)
//
//        imgView.image = image
//
//        viewToRender.addSubview(imgView)
//
//        let textImgView = UIImageView(frame: viewToRender.frame)
//
//        textImgView.image = imageFrom(text: "Example text", size: viewToRender.frame.size)
//
//        viewToRender.addSubview(textImgView)
//
//        UIGraphicsBeginImageContextWithOptions(viewToRender.frame.size, false, 0)
//        viewToRender.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return finalImage
//    }
    
    
    func imageFrom(text: String , size:CGSize) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            //let attrs = [String: UIFont(name: "HelveticaNeue", size: 36)!, NSForegroundColorAttributeName: UIColor.white, NSParagraphStyleAttributeName: paragraphStyle]
            
            text.draw(with: CGRect(x: 0, y: size.height / 2, width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: nil, context: nil)
            
        }
        return img
    }
}

