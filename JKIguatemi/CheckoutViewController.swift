//
//  CheckoutViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 23/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import PassKit

class CheckoutViewController: UIViewController {

    @IBOutlet var applePayContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let applePayButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        applePayButton.addTarget(self, action: #selector(applePayPressed), for: .touchUpInside)
        applePayContainerView.addSubview(applePayButton)
    }

    @objc func applePayPressed(sender: UIButton) {
        let paymentNetworks: [PKPaymentNetwork] = [.masterCard, .visa]
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.com.aKANJ.JKIguatemi.applepay"
            request.countryCode = "BR"
            request.currencyCode = "BRL"
            request.supportedNetworks = paymentNetworks
            request.merchantCapabilities = .capabilityCredit
            let summaryItem = PKPaymentSummaryItem(label: "Louis Vuitton", amount: NSDecimalNumber(value: 250), type: .final)
            let taxSummaryItem = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(value: 3), type: .final)
            let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: 253), type: .final)
            request.paymentSummaryItems = [summaryItem, taxSummaryItem, total]
            let authorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: request)
            authorizationViewController?.delegate = self
            present(authorizationViewController!, animated: true, completion: nil)
        }
    }
}



extension CheckoutViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: false, completion: nil)
    }
}
