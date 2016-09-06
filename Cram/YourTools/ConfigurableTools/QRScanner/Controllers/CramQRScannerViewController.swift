//
//  CramQRScannerViewController.swift
//  Cram
//
//  Created by Harly on 16/8/19.
//  Copyright © 2016年 MogoOrg. All rights reserved.
//

import UIKit
import AVFoundation
import Async
import RxSwift

class CramQRScannerViewController: BaseViewController {
    
    @IBOutlet weak var loadingLabel: UILabel!

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var webResultView: UIWebView!
    
    var scannedUrlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showQRScanner()
    }
    
    override func configUI() {
        scanBtn.rx_tap.subscribeNext { [weak self](_) in
            guard let strongSelf = self else { return }
            strongSelf.showQRScanner()
        }.addDisposableTo(disposeBag)

//        loadingIndicator.bnd_animating <==> webResultView.bnd_alpha.map({ (alpha) -> Bool in
//            return alpha != 1
//        })
        
    }
    
    private func showQRScanner()
    {
        if QRCodeReader.supportsMetadataObjectTypes() {
            let reader = createReader()
            reader.modalPresentationStyle = .FormSheet
            reader.delegate = self
            
            
            presentViewController(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func createReader() -> QRCodeReaderViewController {
        let builder = QRCodeViewControllerBuilder { builder in
            builder.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
            builder.showTorchButton = true
            builder.showCancelButton = true
        }
        
        return QRCodeReaderViewController(builder: builder)
    }
    
    override func cramBackBtn() -> (UIButton?) {
        return backBtn
    }
    
    
}

//extension CramQRScannerViewController : UIWebViewDelegate
//{
//    func webViewDidStartLoad(webView: UIWebView) {
//        webView.bnd_alpha.next(0)
//    }
//    
//    func webViewDidFinishLoad(webView: UIWebView) {
//        UIView.animateWithDuration(0.3) { 
//            webView.bnd_alpha.next(1)
//        }
//        
//        guard scannedUrlString.containsString("pgyer") else { return }
//
//        let pswResult = webView.stringByEvaluatingJavaScriptFromString("document.getElementById('password' ).value = 123456")
//        
//        if let psw = pswResult
//        {
//            if psw == "123456"
//            {
//                webView.stringByEvaluatingJavaScriptFromString("saveData();")
//            }
//            else
//            {
//                Async.main(after: 0.3){
//                    webView.stringByEvaluatingJavaScriptFromString("install_loading ();")
//                    
//                        UIView.animateWithDuration(0.3, animations: {
//                            self.loadingLabel.alpha = 1
//                        })
//                }
//            }
//        }
//       
//    }
//}

extension CramQRScannerViewController : QRCodeReaderViewControllerDelegate
{
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true) { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.scannedUrlString = result.value
            let url = NSURL(string: result.value)
            let request = NSURLRequest(URL: url!)
            strongSelf.webResultView.loadRequest(request)

        }
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
