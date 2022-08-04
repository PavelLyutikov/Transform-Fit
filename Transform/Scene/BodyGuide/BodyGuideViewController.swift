//
//  ViewController.swift
//  PDF-Demo
//
//  Created by lan on 2017/6/27.
//  Copyright © 2017年 com.tzshlyt.demo. All rights reserved.
//

import UIKit
import PDFKit
import SnapKit

class BodyGuideViewController: UIViewController {
    
    private var pdfdocument: PDFDocument?
    private var pdfview: PDFView!
    private var pdfThumbView: PDFThumbnailView!
    private weak var observe : NSObjectProtocol?
    
    let totalSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let topPositPDF: CGFloat!
        if totalSize.height >= 920 {
            topPositPDF = 100
        } else if totalSize.height >= 830 && totalSize.height <= 919 {
            topPositPDF = 100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPositPDF = 100
        } else if totalSize.height <= 670 {
            topPositPDF = 100
        } else {
            topPositPDF = 100
        }
        pdfview = PDFView(frame: CGRect(x: 0, y: topPositPDF, width: view.frame.width, height: view.frame.height - 100))
        
        let url = Bundle.main.url(forResource: "bodyGuide", withExtension: "pdf")
        pdfdocument = PDFDocument(url: url!)
        
        pdfview.document = pdfdocument
        pdfview.displayMode = PDFDisplayMode.singlePageContinuous
        pdfview.autoScales = true
        view.addSubview(pdfview)
        
        let topPositThumb: CGFloat!
        if totalSize.height >= 920 {
            topPositThumb = 50
        } else if totalSize.height >= 830 && totalSize.height <= 919 {
            topPositThumb = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPositThumb = 50
        } else if totalSize.height <= 670 {
            topPositThumb = 50
        } else {
            topPositThumb = 50
        }
        pdfThumbView = PDFThumbnailView(frame: CGRect(x: 0, y: topPositThumb, width: view.frame.width, height: 50))
        pdfThumbView.layoutMode = .horizontal
        pdfThumbView.pdfView = pdfview
        pdfThumbView.backgroundColor = #colorLiteral(red: 0.996739924, green: 0.8055360913, blue: 0.6442965865, alpha: 1)
        view.addSubview(pdfThumbView)
        
        
        //Закладка
        let savedPageNumber = UserDefaults.standard.integer(forKey: "bookmarkedPage")
        pdfview.go(to: pdfdocument!.page(at:savedPageNumber)!)
        
        
        dismissButton.addTarget(self, action: #selector(buttonDismiss(sender:)), for: .touchUpInside)
    }
//MARK: Dismiss
    @objc lazy var dismissButton: UIButton = {
        let positX: CGFloat!
        let leidTrail: CGFloat!
        if totalSize.height >= 830 {
            positX = 120
            leidTrail = 15
        } else if totalSize.height <= 800 {
            positX = 35
            leidTrail = 25
        } else {
            positX = 120
            leidTrail = 30
        }
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "closeBlack"), for: .normal)
        btn.layer.zPosition = 6
        self.view.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(positX)
            make.trailing.equalToSuperview().inset(leidTrail)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        return btn
    }()
    @objc func buttonDismiss(sender: UIButton) {

        //закладка
        let pageNumber = pdfdocument!.index(for: pdfview.currentPage!)
        UserDefaults.standard.set(pageNumber, forKey: "bookmarkedPage")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        let vc = MenuBodyGuideViewController()
        vc.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(vc, animated: false, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BodyGuideViewController: ThumbnailGridViewControllerDelegate {
    func thumbnailGridViewController(_ thumbnailGridViewController: ThumbnailGridViewController, didSelectPage page: PDFPage) {
        pdfview.go(to: page)
    }
}

extension BodyGuideViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
    }
}
