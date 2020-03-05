//
//  DotOverlay.swift
//  LoadingAnimationExperient
//
//  Created by David Rynn on 3/5/20.
//  Copyright © 2020 David Rynn. All rights reserved.
//

import UIKit

class DotLayer: CAShapeLayer {

  let animationDuration: CFTimeInterval = 0.3
  let largeDiameter: CGFloat = 5.0
  let smallDiameter: CGFloat = 2.0
  let spacer: CGFloat = 2.0

  override init() {
    super.init()
    fillColor = UIColor.black.cgColor
//    path = ovalPathSmall.cgPath
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

//  var ovalPathSmall: UIBezierPath {
//    let path1 = UIBezierPath(ovalIn: CGRect(x: 2.5, y: 2.5, width: 1.0, height: 1.0))
//    let path2 = UIBezierPath(ovalIn: CGRect(x: 8.5, y: 2.5, width: 1.0, height: 1.0))
//    let path3 = UIBezierPath(ovalIn: CGRect(x: 14.5, y: 2.5, width: 1.0, height: 1.0))
//    path1.append(path2)
//    path1.append(path3)
//    return path1
//  }
//
//  var ovalPathLarge: UIBezierPath {
//    let path1 = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 5.0, height: 5.0))
//    let path2 = UIBezierPath(ovalIn: CGRect(x: 6, y: 0, width: 5.0, height: 5.0))
//    let path3 = UIBezierPath(ovalIn: CGRect(x: 12, y: 0, width: 5.0, height: 5.0))
//    path1.append(path2)
//    path1.append(path3)
//    return path1
//  }

  private func createDots(diameter: CGFloat) -> [UIBezierPath] {
    let space = largeDiameter + spacer
    let path1 = UIBezierPath(ovalIn: CGRect(x: (largeDiameter/2 - diameter/2), y: (largeDiameter/2 - diameter/2), width: diameter, height: diameter))
    let path2 = UIBezierPath(ovalIn: CGRect(x: path1.bounds.origin.x + space,
                                            y: path1.bounds.origin.y,
                                            width: diameter,
                                            height: diameter))
    let path3 = UIBezierPath(ovalIn: CGRect(x: path2.bounds.origin.x + space,
                                            y: path2.bounds.origin.y,
                                            width: diameter,
                                            height: diameter))
    return [path1, path2, path3]
  }

  private func mergePaths(paths: [UIBezierPath]) -> UIBezierPath {
    let finalPath = UIBezierPath()
    paths.forEach {finalPath.append($0)}
    return finalPath
  }

  private func createExpandAnimation(start: CFTimeInterval, smallDot: UIBezierPath, largeDot: UIBezierPath) -> CAAnimation {
    let expandAnimation = createDotAnimation(start: start, from: smallDot, to: largeDot)
    return expandAnimation
  }

  func createDotAnimation(start: CFTimeInterval, from: UIBezierPath, to path: UIBezierPath) -> CAAnimation {
    let animation: CABasicAnimation = CABasicAnimation(keyPath: "path")
    animation.fromValue = from.cgPath
    animation.toValue = path.cgPath
    animation.duration = animationDuration
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.beginTime = start
    animation.isRemovedOnCompletion = false
    return animation
  }

  private func createContractAnimation(start: CFTimeInterval, smallDot: UIBezierPath, largeDot: UIBezierPath) -> CAAnimation {
    let contractAnimation = createDotAnimation(start: start, from: largeDot, to: smallDot)
    return contractAnimation
  }

//  func createAnimationGroups(_ dots: [UIBezierPath]) -> [CAAnimationGroup] {
//    return []
//  }

  func createAnimationGroup(smallDots: [UIBezierPath], largeDots: [UIBezierPath]) -> CAAnimationGroup {
    guard smallDots.count == largeDots.count else { fatalError("large and small dots needs to be the same number")}
    let group: CAAnimationGroup = CAAnimationGroup()
    (0...(smallDots.count - 1)).forEach { index in
      group.animations?.append(createExpandAnimation(start: group.duration, smallDot: smallDots[index], largeDot: largeDots[index]))
      group.animations?.append(createContractAnimation(start: group.duration, smallDot: smallDots[index], largeDot: largeDots[index]))
    }
    return group
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

    let smallDots = createDots(diameter: smallDiameter)
    let largeDots = createDots(diameter: largeDiameter)
    let smallPath = mergePaths(paths: smallDots)
    let largePath = mergePaths(paths: largeDots)
    path = smallPath.cgPath
    let animf = createExpandAnimation(start: 0, smallDot: smallPath, largeDot: largePath)
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

//  func contractAnimation() {
//  }
}
