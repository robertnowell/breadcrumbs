//
//  AugmentedLayer.swift
//  Vandalism
//
//  Created by Prateek R Patil on 11/6/16.
//  Copyright © 2016 Prateek R Patil. All rights reserved.
//

import Foundation
import UIKit

class AugmentedLayer: UIView {
    
    var manager : TransformationManager? = nil;
    var viewArray = Array<UIView>();
    var posArray = Array<Vec3D>();
    
    func _uglyInit() {
        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        testView.backgroundColor = UIColor.clear;
        let text = Message(frame: CGRect(x: 0, y: 0, width: 40, height: 40));
        text.textLabel.text = "〒";
        text.clipsToBounds = true;
        text.callbackFunction = {
            _ in
            text.textLabel.text = "Hello World!";
            text.textLabel.frame.size.width = 200;
            text.frame.size.width = 200;
        }
        testView.transform = CGAffineTransform(rotationAngle: (CGFloat)(M_PI_2));
        testView.addSubview(text);
        let testPoint = Vec3D(x: -40, y: 0, z: -20);
        self.viewArray.append(testView);
        self.posArray.append(testPoint);
        self.addSubview(testView);
        
        
        let testView2 = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        testView2.backgroundColor = UIColor.clear;
        let text2 = Message(frame: CGRect(x: 0, y: 0, width: 40, height: 40));
        text2.textLabel.text = "☎︎";
        text2.clipsToBounds = true;
        text2.callbackFunction = {
            _ in
            text2.textLabel.text = "Rob Was Here.";
            text2.textLabel.frame.size.width = 200;
            text2.frame.size.width = 200;
        }
        testView2.transform = CGAffineTransform(rotationAngle: (CGFloat)(M_PI_2));
        testView2.addSubview(text2);
        let testPoint2 = Vec3D(x: -65, y: 0, z: -15);
        self.manager = TransformationManager();
        self.viewArray.append(testView2);
        self.posArray.append(testPoint2);
        self.addSubview(testView2);
        
        let testView3 = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        testView3.backgroundColor = UIColor.clear;
        let text3 = Message(frame: CGRect(x: 0, y: 0, width: 40, height: 40));
        text3.textLabel.text = "⏣";
        text3.clipsToBounds = true;
        text3.callbackFunction = {
            _ in
            text3.textLabel.text = "Waffles are pretty good.";
            text3.textLabel.frame.size.width = 200;
            text3.frame.size.width = 200;
        }
        testView3.transform = CGAffineTransform(rotationAngle: (CGFloat)(M_PI_2));
        testView3.addSubview(text3);
        let testPoint3 = Vec3D(x: -80, y: 0, z: -15);
        self.manager = TransformationManager();
        self.viewArray.append(testView3);
        //self.posArray.append(testPoint3);
        //self.addSubview(testView3);
        
        
        let testView4 = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        testView4.backgroundColor = UIColor.clear;
        let text4 = Message(frame: CGRect(x: 0, y: 0, width: 40, height: 40));
        text4.textLabel.text = "␀";
        text4.clipsToBounds = true;
        text4.callbackFunction = {
            _ in
            text4.textLabel.text = "SIGSEGV - Haha J/K";
            text4.textLabel.frame.size.width = 200;
            text4.frame.size.width = 200;
        }
        testView4.transform = CGAffineTransform(rotationAngle: (CGFloat)(M_PI_2));
        testView4.addSubview(text4);
        let testPoint4 = Vec3D(x: -100, y: 0, z: -10);
        self.manager = TransformationManager();
        self.viewArray.append(testView4);
        self.posArray.append(testPoint4);
        //self.addSubview(testView4);
        
        
        self.manager = TransformationManager();
        self.manager?.trackPoints.append(testPoint);
        self.manager?.trackPoints.append(testPoint2);
        self.manager?.trackPoints.append(testPoint3);
        self.manager?.trackPoints.append(testPoint4);
        self.manager?.trackDots.append(Vec2D());
        self.manager?.trackDots.append(Vec2D());
        self.manager?.trackDots.append(Vec2D());
        self.manager?.trackDots.append(Vec2D());
        self.manager?.augLayer = self;
//        for v in self.viewArray {
//            self.addSubview(v);
//        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.bounds = self.frame;
        _uglyInit();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.bounds = self.frame;
        _uglyInit();
    }
    
    func update(manager: TransformationManager) {
        var i = 0;
        for p in manager.trackDots {
            let p = p as Vec2D;
            self.viewArray[i].frame.origin.x = CGFloat(p.i) * self.frame.height * 0.5 + self.frame.width * 0.5;
            self.viewArray[i].frame.origin.y = CGFloat(p.j) * self.frame.height * 0.5 + self.frame.height * 0.5;
            i += 1;
        }
    }
}
