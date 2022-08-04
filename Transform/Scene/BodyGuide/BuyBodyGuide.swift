//
//  BuyBodyGuide.swift
//  Transform
//
//  Created by Pavel Lyutikov on 10.05.2021.
//

import Foundation
import StoreKit

extension UIApplication {
  class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let tabController = controller as? UITabBarController {
      return topViewController(controller: tabController.selectedViewController)
    }
    if let navController = controller as? UINavigationController {
      return topViewController(controller: navController.visibleViewController)
    }
    if let presented = controller?.presentedViewController {
      return topViewController(controller: presented)
    }
    return controller
  }
}

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in }))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
}


class BuyProduct: UIViewController {
    
    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    static let shared = BuyProduct()
    //real
    let premiumProductID = "com.transform.fitness.bodyGuide"
    //test
    let pr = "buyGuide"
    var productID = ""
    var productsRequest = SKProductsRequest()
    var iapProducts = [SKProduct]()
    var nonConsumablePurchaseMade = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade")
    

    func fetchAvailableProducts()  {
        productsRequest = SKProductsRequest(productIdentifiers: Set([premiumProductID, pr]))
        productsRequest.delegate = self
        productsRequest.start()
    }

    // MARK: - MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    func purchaseMyProduct(product: SKProduct) {
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
            
        // IAP Purchases dsabled on the Device
        } else {
            self.showAlert(title: "IAP", message: "Purshareses are disabled in you device!")
        }
    }
}

extension BuyProduct: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    // MARK: - REQUEST IAP PRODUCTS
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if (response.products.count > 0) {
                   iapProducts = response.products
                       
                   // 1st IAP Product (Consumable) ------------------------------------
                   let firstProduct = response.products[0] as SKProduct
                   
                   // Get its price from iTunes Connect
                   let numberFormatter = NumberFormatter()
                   numberFormatter.formatterBehavior = .behavior10_4
                   numberFormatter.numberStyle = .currency
                   numberFormatter.locale = firstProduct.priceLocale
                   let price1Str = numberFormatter.string(from: firstProduct.price)
                   
                   // Show its description
                   print(firstProduct.localizedDescription + " for just \(price1Str!)")
            
        } else {
            assertionFailure("Don't have any products")
            print("Dont have any products")
        }
    }
    
    // MARK:- IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                if let error = trans.error {
                    self.showAlert(title: "Error",
                    message: "\(error.localizedDescription)")
                   // print("🆘 \(error.localizedDescription) 🆘")
                   // assertionFailure("🆘 \(error.localizedDescription) 🆘")
                }
                switch trans.transactionState {

                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                       
                       // The Consumale product (10 coins) has been purchased -> gain 10 extra coins!
                    if productID == premiumProductID {
                           
                           // Save your purchase locally (needed only for Non-Consumable IAP)
                           nonConsumablePurchaseMade = true
                           UserDefaults.standard.set(nonConsumablePurchaseMade, forKey: "nonConsumablePurchaseMade")
                        
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulPurchaseBodyGuide"), object: nil)
                       
                           print("Premium version PURCHASED!")
                           self.showAlert(title: "Tutorial",
                                          message: "You've successfully unlocked version without add!")
                    } else {
                        print("🍡")
                    }
                       break
                       
                   case .failed:
                       SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                       self.showAlert(title: "Error",
                                      message: "Payment was failed")
                       break
                   case .restored:
                       SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                       break
                       
                   default: break
                }
            }
        }
    }
}
