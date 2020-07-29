//
//  DetailNewsViewController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 29.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import WebKit

final class DetailNewsViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
          webView = WKWebView()
          webView.uiDelegate = self
          view = webView
      }
      
     
      
      override func viewDidLoad() {
          super.viewDidLoad()
                    
          let url = URL(string: urlString)
          webView.load(URLRequest(url: url!))
          webView.allowsBackForwardNavigationGestures = true
      }
}
