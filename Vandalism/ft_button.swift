//
//  ft_button.swift
//  Vandalism
//
//  Created by Prateek R Patil on 11/6/16.
//  Copyright © 2016 Prateek R Patil. All rights reserved.
//

import Foundation

import UIKit

class Message : UIView {
    
    var tapListener : UITapGestureRecognizer? = nil;
    let textLabel : UILabel = UILabel();
    let typeLabel : UILabel = UILabel();
    var callbackFunction : (()->Void)? = nil;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.typeLabel.textAlignment = NSTextAlignment.center;
        self.typeLabel.frame.origin = CGPoint(x: 0, y: 0);
        self.typeLabel.frame.size = CGSize(width: frame.size.height, height: frame.size.height);
        self.textLabel.frame.origin = CGPoint(x: 0, y: 0);
        self.textLabel.frame.size = CGSize(width: frame.size.width, height: frame.size.height);
        self.isUserInteractionEnabled = true;
        self.backgroundColor = UIColor.black;
        self.textLabel.textColor = UIColor.white;
        self.textLabel.textAlignment = .center;
        //self.tapListener = UITapGestureRecognizer(target: self, action: #selector(Message.onTap(_:)));
        self.tapListener = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)));
        self.addSubview(self.textLabel);
        self.addSubview(self.typeLabel);
        self.addGestureRecognizer(tapListener!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.typeLabel.textAlignment = NSTextAlignment.center;
        self.typeLabel.frame.origin = CGPoint(x: 0, y: 0);
        self.typeLabel.frame.size = CGSize(width: frame.size.height, height: frame.size.height);
        self.textLabel.frame.origin = CGPoint(x: frame.size.height, y: 0);
        self.textLabel.frame.size = CGSize(width: frame.size.width - frame.size.height, height: frame.size.height);
        self.isUserInteractionEnabled = true;
        self.backgroundColor = UIColor.black;
        self.textLabel.textColor = UIColor.white;
        self.tapListener = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)));
        self.addSubview(self.textLabel);
        self.addSubview(self.typeLabel);
        self.addGestureRecognizer(tapListener!);
    }
    
    func onTap(_ sender : UITapGestureRecognizer){
        let tapPosition : CGPoint = sender.location(in: self);
        let endWidth = self.frame.width / 2 + abs(self.frame.width - tapPosition.x);
        let expandingBar = UIView(frame: CGRect(x: tapPosition.x, y: 0, width: 0, height: self.frame.height));
        expandingBar.backgroundColor = UIColor(colorLiteralRed: 0.722, green: 0, blue: 0.384, alpha: 1.0);
        self.addSubview(expandingBar);
        self.sendSubview(toBack: expandingBar);
        
        UIView.animate(withDuration: 0.42, animations: {
            expandingBar.frame.size.width = 2 * endWidth;
            expandingBar.frame.origin.x = tapPosition.x - endWidth;
            expandingBar.alpha = 0;
        }, completion: {
            done in
            expandingBar.removeFromSuperview();
            self.callbackFunction?();
        })
        
        /*UIView.animateWithDuration(NSTimeInterval(0.25), animations: {
         self.layer.backgroundColor = UIColor(colorLiteralRed: 0.722, green: 0, blue: 0.384, alpha: 1.0).CGColor;
         self.textColor = UIColor.whiteColor();
         }, completion: { value in
         UIView.animateWithDuration(0.20, animations: {
         self.layer.backgroundColor = UIColor.clearColor().CGColor;
         self.textColor = UIColor.blackColor();
         }, completion: {
         value in self.callbackFunction?();
         })
         })*/
    }
}
