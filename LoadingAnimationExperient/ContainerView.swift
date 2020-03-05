//
//  ContainerView.swift
//  LoadingAnimationExperient
//
//  Created by David Rynn on 3/5/20.
//  Copyright © 2020 David Rynn. All rights reserved.
//

import UIKit
class ContainerView: UIView {

  var parentFrame :CGRect = CGRect.zero
  let ovalLayer = DotLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addOval() {
    layer.addSublayer(ovalLayer)
    ovalLayer.pulse()
//    ovalLayer.expand()
//    Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: "wobbleOval",
//    userInfo: nil, repeats: false)

  }


}
