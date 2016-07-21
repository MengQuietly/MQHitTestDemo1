//
//  MQBaseView.swift
//  MQHitTestDemo
//
//  Created by mengmeng on 16/7/18.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/**
 1. hitTest:withEvent:() 练习：
 2. 模仿系统：hitTest：withEvent：() 找最合适的 View
 */
class MQBaseView: UIView {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        print("\(#function)")
    }
    
    /// 此方法：寻找最合适的 View
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        
//        // 打印 hitTest View
//        print("\(#function)=\(object_getClass(self))")
//        return super.hitTest(point, withEvent: event)
        
        // 模仿系统做法
        // 1.当前控件是否能接收触摸事件
        if self.userInteractionEnabled == false || self.hidden == true || self.alpha <= 0.01 {
            return nil
        }
        
        // 2. point 是否在当前控件上
        if self.pointInside(point, withEvent: event) == false {
            return nil
        }
        
        // 3. 从后往前遍历自己的子控件
        let count = self.subviews.count
        for var i = count - 1; i >= 0;i -= 1 {
            let childV = self.subviews[i]
            // 将当前控件上的坐标系转换成子控件上的坐标系
            let childP = self.convertPoint(point, toView: childV)
            let fitView = childV.hitTest(childP, withEvent: event)

            if (fitView != nil) { // 有最合适的 View
                print("\(object_getClass(fitView))")
                return fitView
            }
        }
        
        print("\(object_getClass(self))")
        // 循环结束，没有比自己最合适的 View
        return self
        
    }

}
