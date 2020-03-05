//
//  LoadingDotBuilder.swift
//  LoadingAnimationExperient
//
//  Created by David Rynn on 3/5/20.
//  Copyright © 2020 David Rynn. All rights reserved.
//

import UIKit

struct LoadingDotBuilder {
  let animationDuration: CFTimeInterval = 0.3
  let largeDiameter: CGFloat = 5.0
  let smallDiameter: CGFloat = 2.0
  let spacer: CGFloat = 2.0

  func createDot(dotOrigin: CGPoint, diameter: CGFloat) -> UIBezierPath {
    return UIBezierPath(ovalIn: CGRect(x:dotOrigin.x - diameter/2, y: dotOrigin.y - diameter/2, width: diameter, height: diameter))
  }

  func create3Dots(diameter: CGFloat) -> [UIBezierPath] {
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

  func mergePaths(paths: [UIBezierPath]) -> UIBezierPath {
    let finalPath = UIBezierPath()
    paths.forEach {finalPath.append($0)}
    return finalPath
  }

  func createExpandAnimation(start: CFTimeInterval, smallDot: UIBezierPath, largeDot: UIBezierPath) -> CAAnimation {
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

  func createDotAnimationGroup(animations: [CAAnimation], repeatCount: Float = 1.0) -> CAAnimationGroup {
    let group = CAAnimationGroup()
    group.animations = animations
    group.repeatCount = repeatCount
    return group
  }

  func createDotsAnimationGroup(smallDots: [UIBezierPath], largeDots: [UIBezierPath]) -> CAAnimationGroup {
    guard smallDots.count == largeDots.count else { fatalError("large and small dots needs to be the same number")}
    let group: CAAnimationGroup = CAAnimationGroup()
    (0...(smallDots.count - 1)).forEach { index in
      group.animations?.append(createExpandAnimation(start: group.duration, smallDot: smallDots[index], largeDot: largeDots[index]))
      group.animations?.append(createContractAnimation(start: group.duration, smallDot: smallDots[index], largeDot: largeDots[index]))
    }
    return group
  }


}



