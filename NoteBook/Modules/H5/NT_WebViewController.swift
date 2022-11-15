//
//  NT_WebViewController.swift
//  NoteBook
//
//  Created by admin on 2022/11/15.
//

import UIKit
import WebKit
import SnapKit
class NT_WebViewController: UIViewController {
    
    var isNoNavBar:Bool = false
    var request: URLRequest!
    var htmlSting: String = ""
    private var webView : WKWebView!
    
    lazy var progressView: UIProgressView = {
        let pw = UIProgressView()
        pw.trackImage = UIImage(color: .white)
        pw.progressTintColor = UIColor.orange
        return pw
    }()
    
    convenience init(url: String? ,title: String = "") {
        self.init()
        self.request = URLRequest(url: ((URL(string: url!) ?? URL(string: "https://www.jd.com")!))!)
    }
    convenience init(htmlSting: String? ,title: String = "") {
        self.init()
        self.htmlSting = htmlSting ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
        if htmlSting.isEmpty {
             webView.load(request)
        } else{
            let basePath = Bundle.main.url(forResource: "/JJA", withExtension: nil)
            // 注：baseURL如果设置为nil的话，html中的css将失效
            webView.loadHTMLString(htmlSting, baseURL: basePath)
        }
        if !isNoNavBar {
             setNavBar()
        }
    }
    
    private func setNavBar() {
        addBackBarButtonItem(action: #selector(backAction))
    }
    
    @objc private func backAction() {
        if self.webView.canGoBack {
            self.webView.goBack()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configUI() {
        
        webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.uiDelegate = self;
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        view.addSubview(webView)
        webView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            if !isNoNavBar {
                 $0.top.equalToSuperview().offset(kNavitionbarH)
            }else {
                 $0.top.equalToSuperview()
            }
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(webView).offset(2)
            $0.height.equalTo(3)
        }
    }
    

    
    @objc func reload() {
        webView.reload()
    }
    
    deinit {
        if webView != nil {
            webView.removeObserver(self, forKeyPath: "estimatedProgress")
        }
    }
}
extension NT_WebViewController: WKNavigationDelegate, WKUIDelegate {

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress >= 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
        progressView.setProgress(0.0, animated: false)
        title = title ?? (webView.title ?? webView.url?.host)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            let url = navigationAction.request.url
            if url?.description.lowercased().range(of: "http://") != nil || url?.description.lowercased().range(of: "https://") != nil || url?.description.lowercased().range(of: "mailto:") != nil {
                webView.load(URLRequest(url: url!))
            }
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(navigationAction.request.url?.absoluteString)
        if navigationAction.request.url?.scheme == "xxxApp" {
            if #available(iOS 10.0, *){
                UIApplication.shared.open(navigationAction.request.url!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : false]) { (isfinish) in
                }
            }else{
                UIApplication.shared.openURL(navigationAction.request.url!);
            }
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}

