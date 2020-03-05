//
//  ViewController.swift
//  LoadingAnimationExperient
//
//  Created by David Rynn on 3/5/20.
//  Copyright © 2020 David Rynn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var containerView = ContainerView(frame: CGRect.zero)
  let button = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    addContainerView()
    addButton()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func addContainerView() {
    let boxSize: CGFloat = 100.0
    containerView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
                              y: view.bounds.height / 2 - boxSize / 2,
                              width: boxSize,
                              height: boxSize)
    containerView.parentFrame = view.frame
    view.addSubview(containerView)
    containerView.addOval()
  }

  func animateLabel() {

  }

  func addButton() {
    button.frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
    button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    view.addSubview(button)
  }

  @objc func buttonPressed(sender: UIButton!) {
    view.backgroundColor = UIColor.white
    view.subviews.forEach {
      if $0 != button {
        $0.removeFromSuperview()
      }
      containerView = ContainerView(frame: CGRect.zero)
      addContainerView()
    }
  }
}

