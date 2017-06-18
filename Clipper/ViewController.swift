//
//  ViewController.swift
//  Clipper
//
//  Created by Tanaka, Tomohiro on 2017/06/18.
//  Copyright © 2017年 Tanaka, Tomohiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var webPageView: UIWebView!
    
    var cellNum: Int = 0 //clippedListControllerTableViewController.swiftのアプリ内データの配列番号を受け取る
    var urlElementsFromCell = [String]() //Cellから受け取った各url
    var urlFromEachCell: String? = String() //Cellで受け取ったurl
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UserDefaults.standard.object(forKey: "webUrl") != nil {
            urlElementsFromCell = UserDefaults.standard.object(forKey: "webUrl") as! [String]
            urlFromEachCell = urlElementsFromCell[cellNum]
        }
        
        let requestURL = URL(string: urlFromEachCell!)
        let req = NSURLRequest(url: requestURL!)
        webPageView.loadRequest(req as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

