import Foundation
import UIKit
import WebKit
class ProfileViewController: RootTabBarViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var Activity: UIActivityIndicatorView!

    @IBAction func buttonTapped(_ sender: Any) {
        if self.webView.canGoBack {
            self.webView.scrollView.setContentOffset(self.webView.scrollView.contentOffset, animated: false)
            self.webView.goBack()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.backForwardList.perform(Selector(("_removeAllItems")))
        webView.addObserver(self, forKeyPath: "URL", options: [.new, .old], context: nil)
        if let profileURL = DevServiceURL.profile.fullURL {
            webView.load(URLRequest.init(url: profileURL))
        }
        
        self.Activity.startAnimating()
        self.Activity.hidesWhenStopped = true
        webView.backForwardList.perform(Selector(("_removeAllItems")))
    }
    
    override func refreshView() {
        //reset badge value
        self.tabBarItem.badgeValue = nil
        self.view.setNeedsDisplay()
        if let profileURL = DevServiceURL.profile.fullURL {
            Activity.startAnimating()
            webView.load(URLRequest.init(url: profileURL))
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        manageBackButton()
    }
    
    func manageBackButton(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { //race condition hack
            self.leftButton?.isEnabled = self.webView.canGoBack
            self.leftButton?.tintColor = self.webView.canGoBack ? .black : .clear
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Activity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Activity.stopAnimating()
    }

    
}
