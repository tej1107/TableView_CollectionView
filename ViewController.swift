
import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var arrData = Array<Any>()
    var fromFilter:Bool = false
    var arrselectedCategory1 = Array<String>()
    var arrselectedType1 = Array<String>()
    var arrselectedColor1 = Array<String>()
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(fromFilter == true)
        {
            print("Categories : \(arrselectedCategory1)")
            print("Types : \(arrselectedType1)")
            print("Color : \(arrselectedColor1)")
        }
        
        let logoutButton:UIBarButtonItem = UIBarButtonItem(title:"FILTER",style:UIBarButtonItem.Style.plain,target:self,action:#selector(FilterData))
        self.navigationItem.setRightBarButton(logoutButton, animated:false)
        
        self.Get_Data()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if(fromFilter == true)
        {
            let logoutButton:UIBarButtonItem = UIBarButtonItem(title:"FILTERED",style:UIBarButtonItem.Style.plain,target:self,action:#selector(FilterData))
            self.navigationItem.setRightBarButton(logoutButton, animated:false)
        }
        self.Get_Data()
    }
    
    func  Get_Data(){
        let url = "https://api.androidhive.info/contacts/"
        Alamofire.request(URL(string: url)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) in
            let response = self.formatResponse(data: responseObject)
            self.arrData = response["contacts"] as! [[String : AnyObject]]
            self.tableView.reloadData()
        }
    }
    
    func formatResponse(data:DataResponse<Any>)-> [String:AnyObject]
    {
        let responseObject = data.result.value as! [NSObject: AnyObject]
        let response = responseObject as! [String : AnyObject]
        return response
    }
    
    @objc func FilterData()
    {
        let FilterVC = self.storyboard?.instantiateViewController(withIdentifier: "Filter_VC") as? Filter_VC
        self.navigationController?.pushViewController(FilterVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainCell
        cell.selectionStyle = .none
        
        var dictData: [String: AnyObject] = [String: AnyObject]()
        dictData = self.arrData[indexPath.row] as! [String : AnyObject]
        cell.lblName.text = dictData["name"] as? String ?? ""
        cell.lblEmail.text = dictData["email"] as? String ?? ""
        cell.lblAddress.text = dictData["address"] as? String ?? ""
        
        let image = dictData[""] as? String ?? ""
        cell.img?.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "download.jpeg"), options: [.continueInBackground,.lowPriority], completed: {(image,error,cacheType,url) in
            
            if error == nil
            {
                cell.img?.image = image
            }
            else
            {
                cell.img?.image =  UIImage(named: "download.jpeg")
            }
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
