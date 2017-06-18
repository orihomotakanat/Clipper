//
//  clippedListControllerTableViewController.swift
//  Clipper
//
//  Created by Tanaka, Tomohiro on 2017/06/18.
//  Copyright © 2017年 Tanaka, Tomohiro. All rights reserved.
//

import UIKit

class clippedListControllerTableViewController: UITableViewController {
    
    //webViewに反映されるタイトル
    var titleElements = [String]()

    //webViewに反映されるURL
    var urlElements = [String]()
    
    
    //Cellのlabel
    var titleLabel: UILabel = UILabel()
    var subtitleLabel: UILabel = UILabel()
    
    //WebViewの実装
    var webView: UIWebView = UIWebView() //Initialized webView
    
    
    //各cellにおいて選択されたものの番号
    var selectedCellNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //毎回Viewが呼ばれる場合
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //アプリ内に保存したデータを再び表示する
        if UserDefaults.standard.object(forKey: "webTitle") != nil {
            titleElements = UserDefaults.standard.object(forKey: "webTitle") as! [String]
            urlElements = UserDefaults.standard.object(forKey: "webUrl") as! [String]
        }
        
        
        
        //sizeの指定
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        //URL指定
        let requestURL = URL(string: "https://google.co.jp/")
        let req = NSURLRequest(url: requestURL!) //URL型: optional -> unwrapの必要あり
        webView.loadRequest(req as URLRequest)
        
        //画面に貼り付け
        self.view.addSubview(webView)
        
        webView.isHidden = true //webViewの非表示
    }
    
    
    @IBAction func search(_ sender: Any) {
        
        //sizeの指定
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        //URL指定
        let requestURL = URL(string: "https://google.co.jp/")
        let req = NSURLRequest(url: requestURL!) //URL型: optional -> unwrapの必要あり
        webView.loadRequest(req as URLRequest)
        
        //画面に貼り付け
        self.view.addSubview(webView)
        
        webView.isHidden = false //webViewの表示
        
        
    }
    
    @IBAction func clip(_ sender: Any) {
        //webViewの表示
        webView.isHidden = true //clip押された時は非表示にする
        
        //webViewのタイトル -> titleElementsへ
        titleElements.append(webView.stringByEvaluatingJavaScript(from: "document.title")!)
        
        //webViewのURL - urlElementsへ
        urlElements.append(webView.stringByEvaluatingJavaScript(from: "document.URL")!)
        
        //各タイトル&URLをアプリへ保存
        UserDefaults.standard.set(titleElements, forKey: "webTitle")
        UserDefaults.standard.set(urlElements, forKey: "webUrl")
        
        //各タイトル&URLを表示
        if UserDefaults.standard.object(forKey: "webTitle") != nil {
            titleElements = UserDefaults.standard.object(forKey: "webTitle") as! [String]
            urlElements = UserDefaults.standard.object(forKey: "webUrl") as! [String]
        }
        
        tableView.reloadData()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleElements.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clippedElements", for: indexPath)

        // Configure the cell...
        
        //Tagを元にstoryboard上のlabelを関連づける
        titleLabel = cell.contentView.viewWithTag(1) as! UILabel
        subtitleLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        //各labelに対し読み取ったTitle&URLを反映させる
        titleLabel.text = titleElements[indexPath.row]
        subtitleLabel.text = urlElements[indexPath.row]

        return cell
    }

    //tap
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCellNum = Int(indexPath.row) //cellがtapされた番号が入る
        performSegue(withIdentifier: "elementView", sender: nil) //storyboardIDのviewに移動
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "elementView") {
            let viewController: ViewController = segue.destination as! ViewController
            
            viewController.cellNum = selectedCellNum //countはViewControllerが持つインスタンス
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
