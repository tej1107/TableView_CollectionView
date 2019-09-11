//
//  Filter_VC.swift
//  Test
//
//  Created by esparkbiz on 9/4/19.
//  Copyright © 2019 esparkbiz. All rights reserved.
//

import UIKit

class Filter_VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var btnFilter: UIButton!
    
    var arrCategory = Array<String>()
    var arrType = Array<String>()
    var arrColor = Array<String>()
    
    var arrselectedCategory = Array<String>()
    var arrselectedType = Array<String>()
    var arrselectedColor = Array<String>()
    
    @IBOutlet var CollViewCategory: UICollectionView!
     @IBOutlet var CollViewType: UICollectionView!
    @IBOutlet var CollViewColor: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.arrCategory = ["Male","Female","Girl","Boy"]
        self.arrType = ["Traditional" , "Western" , "IndoWestern"]
        self.arrColor = ["Red" , "Green" , "Blue" , "Yellow" , "Purple"]
    }
    
    
    // MARK: - collectionView Datasource Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == self.CollViewCategory
        {
            return self.arrCategory.count
        }
        else if collectionView == self.CollViewType
        {
            return self.arrType.count
        }
        else if collectionView == self.CollViewColor
        {
            return self.arrColor.count
        }
        else
        {
            return 10
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if collectionView == self.CollViewCategory
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath) as! CollCell
            cell.Coll1Lbl.text = self.arrCategory[indexPath.item]
            return cell
        }
        else if collectionView == self.CollViewType
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath) as! CollCell
            cell.Coll2Lbl.text = self.arrType[indexPath.item]
            return cell
        }
        else if collectionView == self.CollViewColor
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath) as! CollCell
            cell.Coll2Lbl3.text = self.arrColor[indexPath.item]
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath) as! CollCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == self.CollViewCategory
        {
            let size = CGSize(width: (collectionView.frame.size.width)/3, height: (collectionView.frame.size.width)/3)
            return size
        }
        else if collectionView == self.CollViewType
        {
            let size = CGSize(width: (collectionView.frame.size.width)/3, height: (collectionView.frame.size.width)/3)
            return size
        }
        else if collectionView == self.CollViewColor
        {
            let size = CGSize(width: (collectionView.frame.size.width)/3, height: (collectionView.frame.size.width)/3)
            return size
        }
        else
        {
            let size = CGSize(width: (collectionView.frame.size.width - 40)/2, height: (collectionView.frame.size.width - 40)/2)
            return size
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.CollViewCategory
        {
            if self.arrselectedCategory.contains(self.arrCategory[indexPath.item])
            {
                if let index = self.arrselectedCategory.index(of: self.arrCategory[indexPath.item]) {
                    self.arrselectedCategory.remove(at: index)
                } else {
                    
                }
            }
            else
            {
                self.arrselectedCategory.append(self.arrCategory[indexPath.item])
            }
            self.CollViewCategory.reloadData()
            print(arrselectedCategory)
        }
        else if collectionView == self.CollViewType
        {
            if self.arrselectedType.contains(self.arrType[indexPath.item])
            {
                if let index = self.arrselectedType.index(of: self.arrType[indexPath.item]) {
                    self.arrselectedType.remove(at: index)
                } else {
                    
                }
            }
            else
            {
                self.arrselectedType.append(self.arrType[indexPath.item])
            }
            self.CollViewType.reloadData()
            print(arrselectedType)
        }
        else if collectionView == self.CollViewColor
        {
            if self.arrselectedColor.contains(self.arrColor[indexPath.item])
            {
                if let index = self.arrselectedColor.index(of: self.arrColor[indexPath.item]) {
                    self.arrselectedColor.remove(at: index)
                } else {
                    
                }
            }
            else
            {
                self.arrselectedColor.append(self.arrColor[indexPath.item])
            }
            self.CollViewColor.reloadData()
            print(arrselectedColor)
        }
        
    }
    
    // MARK: - filter Btn Action
    @IBAction func btnFilterAction(_ sender: Any) {

        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        VC!.fromFilter = true
        VC!.arrselectedCategory1 = arrselectedCategory
        VC!.arrselectedType1 = arrselectedType
        VC!.arrselectedColor1 = arrselectedColor
        self.navigationController?.pushViewController(VC!, animated: true)
        
    }
}
