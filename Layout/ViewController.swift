//
//  ViewController.swift
//  Layout
//
//  Created by tm on 2018/9/16.
//  Copyright © 2018年 tm. All rights reserved.
//

import UIKit

/**
 view 大小约束是在自己上
 view 的位置约束是在父视图的上
 */

class ViewController: UIViewController {

    var topView = UIView()
    var bottomView = Bundle.main.loadNibNamed("InputBarView", owner: nil, options: nil)?.first as! InputBarView
    var otherBottomBtn = UIButton.init(type: UIButtonType.custom)
    
    // MARK: - life
    override func viewDidLoad() {
        super.viewDidLoad()
    
        topView.backgroundColor = UIColor.orange
        bottomView.backgroundColor = UIColor.red
        
        otherBottomBtn.setTitle("隐藏底部", for: .normal)
        otherBottomBtn.setTitle("显示底部", for: .selected)
        otherBottomBtn.setTitleColor(UIColor.white, for: .normal)
        otherBottomBtn.addTarget(self, action: #selector(hiddenBottomView), for: UIControlEvents.touchUpInside)
        otherBottomBtn.backgroundColor = UIColor.blue
        
        // 先添加到时图上
        view.addSubview(topView)
        view.addSubview(bottomView)
        view.addSubview(otherBottomBtn)
        
//        if #available(iOS 11.0, *) {
//
//        }
        
        // 注意：这儿的写法是针对与iOS 11.0
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            if #available(iOS 11.0, *) {
//                topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            }else{
                topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            }
            
            topView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        
        otherBottomBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            otherBottomBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            otherBottomBtn.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -40),
            otherBottomBtn.widthAnchor.constraint(equalToConstant: 80),
            otherBottomBtn.heightAnchor.constraint(equalToConstant: 80)
            ])
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("ViewController viewDidLayoutSubviews")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - action
    @objc func hiddenBottomView(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            bottomView.isHidden = true
            for constraint in view.constraints {
                if let item = constraint.firstItem as? UIButton, item == otherBottomBtn, constraint.firstAttribute == NSLayoutAttribute.bottom {
                    self.view.removeConstraint(constraint)
                    self.view.addConstraint(self.otherBottomBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor))
                }
            }
            
        }else{
            bottomView.isHidden = false
            
            for constraint in view.constraints {
                if let item = constraint.firstItem as? UIButton, item == otherBottomBtn, constraint.firstAttribute == NSLayoutAttribute.bottom {
                    self.view.removeConstraint(constraint)
                    self.view.addConstraint(self.otherBottomBtn.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: -40))
                }
            }
        }
    }

}

