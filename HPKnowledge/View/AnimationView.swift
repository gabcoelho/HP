//
//  AnimationView.swift
//  HPKnowledge
//
//  Created by Gabriela Coelho on 17/01/19.
//  Copyright © 2019 Gabriela Coelho. All rights reserved.
//

import UIKit
import SwiftyGif

class AnimationView: UIView {
    var logoGifImageView = UIImageView(gifImage: UIImage(gifName: "colgate"), loopCount: 1)
    var arrayGif = ["colgate","makeup","ball","body","boss","clap","door","dance","explode","fat","girrrl","head","idk","hehehe","lol","meangirls","no","pee","siriusly","smell","snape-loreal","stare"]
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.white
        let randomNumber = Int(arc4random_uniform(UInt32(self.arrayGif.count)))
        logoGifImageView = UIImageView(gifImage: UIImage(gifName: "\(self.arrayGif[randomNumber])"), loopCount: 1)
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}


extension UIView {
    
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
    
}
