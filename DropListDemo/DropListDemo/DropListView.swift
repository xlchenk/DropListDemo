//
//  DropListView.swift
//  DropListDemo
//
//  Created by 陈晓龙 on 2017/6/26.
//  Copyright © 2017年 陈晓龙. All rights reserved.
//

import UIKit

typealias dropListBlock = (_ contentData:NSString) ->()
private let cellId = "cellId"
class DropListView: UIView {
    private var bgView:UIView?//背景色
    private var tableView :UITableView?//列表
    private var clickFrame:CGRect?//控件位置
    var dataArray = NSArray() //存放内容的数组

    var callBlock:dropListBlock?
    var tabWidth:CGFloat = 140.0 {
        didSet{
//            let tabX = (clickFrame?.minX)!+(clickFrame?.size.width)!/2-tabWidth/2
//            let tabY = clickFrame?.maxY
//            tableView?.frame = CGRect(x: tabX, y: tabY!+5, width: tabWidth, height: CGFloat(44*dataArray.count))
            
        }
    }
    var tabOffset:CGFloat = 0.0
    
    init(frame:CGRect,arrData:NSArray,completion: @escaping dropListBlock) {//逃逸闭包，函数执行完毕后再执行闭包，逃逸闭包消耗性能 ，加关键字 @escaping
        super.init(frame: CGRect(x: 0, y: 0, width:SCREEN_WIDTH , height: SCREEN_HEIGHT))
        callBlock = completion
        clickFrame = frame
        dataArray = arrData
        
        addDropListView(array: arrData)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
  private  func addDropListView(array:NSArray) {
        dataArray = array
        
        addbgView()
        setupTableVew()
        setBezierPath()
    
    }
    
 
    //MARK:添加三角形
  private  func setBezierPath() {
        let widthX = (clickFrame?.minX)! + (clickFrame?.size.width)!/2
        let heightY = (clickFrame?.maxY)!-5
        
        let path = UIBezierPath()
        //起始点位置
        path.move(to: CGPoint(x: widthX, y: heightY))
        path.addLine(to: CGPoint(x: widthX-10, y: heightY+15))
        path.addLine(to: CGPoint(x: widthX+10, y: heightY+15))
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
    }
    
   private func addbgView() {
        bgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bgView?.backgroundColor = UIColor.lightGray
        bgView?.alpha = 0.7
        bgView?.isUserInteractionEnabled = true
        addSubview(bgView!)
        //添加一个点击收回手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        bgView?.addGestureRecognizer(tap)
    }
  
    //MARK:添列表
   private func setupTableVew() {
       tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.layer.cornerRadius = 10.0
         self.addSubview(tableView!)
    }
    
    //MARK:收回弹出列表
   @objc private func dismissView() {
        self.removeFromSuperview()
    }
    
     //MARK: -- 弹出列表
    func showList() {
        showTabAnimation()
        //显示view
        UIApplication.shared.keyWindow?.addSubview(self)
    }
  
   private func showTabAnimation() {
    var twidth:CGFloat = 0.0
    if (abs(tabOffset) >= tabWidth/2-20) {
        if (tabOffset<0){
         twidth = -(tabWidth/2-30)
        }else{
         twidth = tabWidth/2-30
        }
        
    }else{
        twidth = tabOffset
    }
 
     tabOffset = twidth
    let tabX = (clickFrame?.minX)!+(clickFrame?.size.width)!/2-tabWidth/2+tabOffset
    let tabY = clickFrame?.maxY
    tableView?.frame = CGRect(x: tabX, y: tabY!+5, width: tabWidth, height:0)
    UIView.animate(withDuration: 0.3, animations: { 
        self.tableView?.frame = CGRect(x: tabX, y: tabY!+5, width: self.tabWidth, height:  CGFloat(44*self.dataArray.count))
    }) { (finished) in }
    
    }
    
}
//MARK:- delegate and dadaSurce
extension DropListView :UITableViewDelegate,UITableViewDataSource {
   internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   internal  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
   internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = dataArray[indexPath.row] as? String
        
        return cell!
    }
    
  internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (callBlock != nil) {
            callBlock?(dataArray[indexPath.row] as? NSString ?? "无内容就就返回这个")
        }
       self.removeFromSuperview()
    }
}


