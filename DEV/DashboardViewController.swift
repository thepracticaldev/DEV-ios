import Foundation
import UIKit
import WebKit
class DashboardViewController: RootTabBarViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var Activity: UIActivityIndicatorView!
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.backForwardList.perform(Selector(("_removeAllItems")))
        if let dashboardURL = DevServiceURL.dashboard.fullURL {
            webView.load(URLRequest.init(url: dashboardURL))
        }
        
        self.Activity.startAnimating()
        self.Activity.hidesWhenStopped = true
        webView.backForwardList.perform(Selector(("_removeAllItems")))
    }
    
    override func refreshView() {
        //reset badge value
        self.tabBarItem.badgeValue = nil
        self.view.setNeedsDisplay()
        if let dashboardURL = DevServiceURL.dashboard.fullURL {
            webView.load(URLRequest.init(url: dashboardURL))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Activity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Activity.stopAnimating()
    }
    
}
