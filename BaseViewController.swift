
import UIKit
import MBProgressHUD
//import SlideMenuControllerSwift
import SDWebImage
import Alamofire
import SkyFloatingLabelTextField

class BaseViewController: UIViewController {
    
    var noDataFoundView: NoDataFoundView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.setNavigationShadow()
        // Do any additional setup after loading the view.
       
       // self.slideMenuController()?.removeLeftGestures()

        noDataFoundView = Bundle.main.loadNibNamed("NoDataFoundView", owner: nil, options: nil)?.first as? NoDataFoundView
        
        //view.backgroundColor = Color.APP_COLOR_DARK_BLUE
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func formatResponse(data:DataResponse<Any>)-> [String:AnyObject]
    {
        let responseObject = data.result.value as! [NSObject: AnyObject]
        let response = responseObject as! [String : AnyObject]
        return response
    }
    
    //MARK: - Metohds
    func displayLoader() {
        DispatchQueue.main.async {
           // MBProgressHUD.showAdded(to: AppDelegate.shared().window!, animated: true)
        }
        
    }
    
    func displayLoader(view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: view, animated: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
           // MBProgressHUD.hide(for: AppDelegate.shared().window!, animated: true)
        }
    }
    
    func hideLoader(view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }

    func setNoDataFoundView(containerView: UIView, message: String) {
        removeNoDataView()
        noDataFoundView.frame.size = containerView.frame.size
        noDataFoundView.lblMessage.text = message
        containerView.addSubview(noDataFoundView)
    }
    
    func removeNoDataView() {
        
        if noDataFoundView != nil {
            noDataFoundView.removeFromSuperview()
        }
        
    }
    func setNavigationShadow(){
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 2
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize.zero
        self.navigationController?.navigationBar.layer.shadowRadius = 8
    }

    func setLeftBarMenuItem(){
        
        //self.slideMenuController()?.addLeftGestures()
        
        var leftBarMenuItem = UIBarButtonItem()
        leftBarMenuItem = UIBarButtonItem(image: #imageLiteral(resourceName: "location"), style: .plain, target: self, action: #selector(self.clickToBtnMenuItem(_:)))
        //leftBarMenuItem.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationItem.leftBarButtonItem = leftBarMenuItem
    }
    
    func setLeftBarBackItem() {
        
        var leftBarBackItem = UIBarButtonItem()
        leftBarBackItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Left"), style: .plain, target: self, action: #selector(self.clickToBtnBackItem(_:)))
       self.navigationItem.leftBarButtonItem = leftBarBackItem
        //slideMenuController()?.navigationItem.leftBarButtonItem = leftBarBackItem
    }
 
    func setTranspertNavigation()
    {    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func goToHome(animated: Bool = true)
    {
        
        let TabbarContollerVC = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar_Contoller_VC") as! Tabbar_Contoller_VC
        self.navigationController?.pushViewController(TabbarContollerVC, animated: true)
        
//        let leftMenuVc = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuViewController")as! LeftMenuViewController
//        let homeNavigationVc = self.storyboard?.instantiateViewController(withIdentifier: "registerNavVC") as! UINavigationController
//        let slideMenuController = SlideMenuController(mainViewController: homeNavigationVc, leftMenuViewController: leftMenuVc)
//
//        slideMenuController.closeLeftNonAnimation()
//        navigationController?.pushViewController(slideMenuController, animated: animated)
//        delay(time: 0.1)
//        {
//
//        }
    }
    
    func addSubViewWithSafeLayout(superView: UIView, subView: UIView) {
        superView.addSubview(subView)
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            let guide = superView.safeAreaLayoutGuide
            subView.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
            subView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
            subView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            subView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        }
        else {
            subView.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
            subView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
            subView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
            subView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        }
        
        subView.layoutIfNeeded()
        superView.layoutIfNeeded()
        
    }
    
    func openUrlWithSafari(url: String) {
        
        if let strUrl = URL(string: url) {
            
            if #available(iOS 10.0, *) {
                
                UIApplication.shared.open(strUrl, options: [:])
                
            }
            else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(strUrl)
            }
        }
    }
    
    //MARK: - Get super view from sub view
    func getSuperView<T>(_ bySubView: UIView?) -> T?
    {
        var tempView = bySubView
        
        func getSuperView() -> T?
        {
            if let finalView = tempView as? T
            {
                return finalView
            }
            else if tempView == nil
            {
                return nil
            }
            
            tempView = tempView?.superview
            
            return getSuperView()
        }
        
        return getSuperView()
    }

    func downloadFile(from strUrl: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        if let url = URL(string: strUrl) {
            
            self.displayLoader(view: self.view)
            
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 120
            sessionConfig.timeoutIntervalForResource = 120
            let session = URLSession(configuration: sessionConfig)
            
//            let request = URLRequest(url:url)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async {
                    if error == nil {
                        
                        
                    }
                    completionHandler(data, error)
                    self.hideLoader(view: self.view)
                    
                }
            }
            
            task.resume()
        }
        
    }
    
    //MARK: - All Button Click Event
    @IBAction func clickToBtnMenuItem(_ sender: UIBarButtonItem) {
        view.endEditing(true)
       // self.slideMenuController()?.openLeft()
    }
    
    @IBAction func clickToBtnBackItem(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        
     //   slideMenuController()?.navigationController?.popViewController(animated: true)
        _ = navigationController?.popViewController(animated: true)
    }

    func getDictFromData(data: Data) -> NSMutableDictionary {
        let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
        return dict!
    }
    
    func SAFESTRING(str: String) -> String {
        return ISVALIDSTRING(str: str) ? str : ""
    }
    func ISVALIDSTRING(str: String) -> Bool
    {
        return str != nil && (str is NSNull) == false
    }
    func checkDictionary(_ dic:NSMutableDictionary)
    {
        let Arr = dic.allKeys
        for i in 0..<Arr.count
        {
            if (dic.value(forKey: Arr[i] as! String) is NSNull) {
                dic[Arr[i]] = ""
            }
            else if (dic.value(forKey: Arr[i] as! String) is [AnyHashable: Any]) {
                let dict = dic.value(forKey: Arr[i] as! String )
                dic[Arr[i]] = dict
                checkDictionary(dict as! NSMutableDictionary)
            }
            else if (dic.value(forKey: Arr[i] as! String) is [Any])
            {
                let Arr12 = dic.value(forKey: Arr[i] as! String) as? NSMutableArray
                
                for (j, element) in (Arr12?.enumerated())!
                {
                    if (Arr12?[j] is NSMutableDictionary)
                    {
                        let dict123 = Arr12?[j]
                        let dict = dict123
                        Arr12?[j] = dict as Any
                        checkDictionary(dict as! NSMutableDictionary)
                    }
                }
            }
        }
    }
    
    
    //MARK: - Web Servce Call
    
    //MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

