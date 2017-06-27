//
//  ViewController.swift
//  DropListDemo
//
//  Created by 陈晓龙 on 2017/6/26.
//  Copyright © 2017年 陈晓龙. All rights reserved.
//

import UIKit
 let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       view.backgroundColor = UIColor.red
 
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        btn.backgroundColor = UIColor.green
        btn.setTitle("点击这里", for: .normal)
        btn.addTarget(self, action: #selector(dropListClick(button:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)

    }
 
    func dropListClick(button:UIButton) {

        let dropList = DropListView(frame:button.frame, arrData: ["1","2","3","4","5"]) { (str:NSString) in
            print(str)
        }
        dropList.tabWidth = 150
        dropList.tabOffset = 80
        dropList.showList()
        
    }
    
    
    
    
    
    
    
    
    

}

