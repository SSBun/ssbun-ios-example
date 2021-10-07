//
//  NiblessNavigationController.swift
//  ssbun-ios-example
//
//  Created by SSBun on 2021/10/7.
//
import UIKit

open class NiblessNavigationController: UINavigationController {
  /// - Methods
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable, message: "Loading this view controller from a nib is unsupported")
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  @available(*, unavailable, message: "Loading this view controller from a nib is unsupported")
  public required init(coder aDecoder: NSCoder) {
    fatalError("Loading this view controller from a nib is unsupported")
  }
}
