//
//  DotOverlay.swift
//  LoadingAnimationExperient
//
//  Created by David Rynn on 3/5/20.
//  Copyright © 2020 David Rynn. All rights reserved.
//

import UIKit

class DotLayer: CAShapeLayer {

  let largeDiameter: CGFloat = 5.0
  let smallDiameter: CGFloat = 2.0
  let dotBuilder = LoadingDotBuilder()

  override init() {
    super.init()
    fillColor = UIColor.black.cgColor
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

//  var ovalPathSquishVertical: UIBezierPath {
//    return UIBezierPath(ovalIn: CGRect(x: 2.5, y: 20.0, width: 95.0, height: 90.0))
//  }
//
//  var ovalPathSquishHorizontal: UIBezierPath {
//    return UIBezierPath(ovalIn: CGRect(x: 5.0, y: 20.0, width: 90.0, height: 90.0))
//  }

//  func expandAnimation() {
//  }

  func pulse() {
//    let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
//    expandAnimation.fromValue = ovalPathSmall.cgPath
//    expandAnimation.toValue = ovalPathLarge.cgPath
//    expandAnimation.duration = animationDuration
//    expandAnimation.fillMode = CAMediaTimingFillMode.forwards
//    expandAnimation.beginTime = 0.0
////    expandAnimation.isRemovedOnCompletion = false
//
//    let contractAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
//    contractAnimation.fromValue = ovalPathLarge.cgPath
//    contractAnimation.toValue = ovalPathSmall.cgPath
//    contractAnimation.duration = animationDuration
//    contractAnimation.fillMode = CAMediaTimingFillMode.forwards
//    contractAnimation.beginTime = expandAnimation.beginTime + expandAnimation.duration
////    contractAnimation.isRemovedOnCompletion = false

    let smallDots = dotBuilder.create3Dots(diameter: smallDiameter)
    let largeDots = dotBuilder.create3Dots(diameter: largeDiameter)
    let smallPath = dotBuilder.mergePaths(paths: smallDots)
    let largePath = dotBuilder.mergePaths(paths: largeDots)
    path = smallPath.cgPath
    let animf = dotBuilder.createExpandAnimation(start: 0, smallDot: smallPath, largeDot: largePath)
    animf.autoreverses = true
    animf.repeatCount = 3
    add(animf, forKey: nil)
//    let animb = createContractAnimation(start: animf.duration, smallDot: smallPath, largeDot: largePath)
//    add(animb, forKey: nil)
//    let groupExp = CAAnimationGroup()
//    groupExp.animations = [animf]
//    groupExp.repeatCount = 3
//    add(groupExp, forKey: nil)
//    let group = createAnimationGroup(smallDots: smallDots, largeDots: largeDots)
//    group.repeatCount = 1
//    add(group, forKey: nil)
  }
}
