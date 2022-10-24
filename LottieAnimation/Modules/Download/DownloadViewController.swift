//
//  DownloadViewController.swift
//  LottieAnimation
//
//  Created by Rustem Manafov on 24.10.22.
//

import Foundation
import UIKit
import Lottie

enum DownloadKeyFrames: CGFloat {
    case startProgress = 32
    case endProgress = 260
    case completion = 301
}

class DownloadViewController: UIViewController {
    
    @IBOutlet weak var progressAnimationVIew: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressAnimationVIew.backgroundColor = .clear
        startProgress()
    }
    
    private func startProgress() {
        progressAnimationVIew.play(fromFrame: 0, toFrame: DownloadKeyFrames.startProgress.rawValue, loopMode: .none) { [weak self] (_) in
            self?.download()
        }
    }
    
    private func startDownload() {
        progressAnimationVIew.play(fromFrame: DownloadKeyFrames.startProgress.rawValue, toFrame: DownloadKeyFrames.endProgress.rawValue, loopMode: .none) { [weak self] (_) in
            self?.endProgress()
        }
    }
    
    private func progress(to progress: CGFloat) {
        let progressRange = DownloadKeyFrames.endProgress.rawValue - DownloadKeyFrames.startProgress.rawValue
        let progressFrame = progressRange*progress
        let currentFrame = progressFrame + DownloadKeyFrames.startProgress.rawValue
        progressAnimationVIew.currentFrame = currentFrame
    }
    
    private func endProgress() {
        progressAnimationVIew.play(fromFrame: DownloadKeyFrames.endProgress.rawValue, toFrame: DownloadKeyFrames.completion.rawValue, loopMode: .none) { (_) in
            
        }
    }
}

extension DownloadViewController: URLSessionDownloadDelegate {
    
    private func download() {
        let url = URL(string: "https://archive.org/download/SampleVideo1280x7205mb/SampleVideo_1280x720_5mb.mp4")!
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentDownloaded: CGFloat = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.progress(to: percentDownloaded)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
            self.endProgress()
        }
    }
    
    
}
