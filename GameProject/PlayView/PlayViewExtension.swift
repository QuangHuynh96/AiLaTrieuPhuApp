//
//  PlayViewExtension.swift
//  GameProject
//
//  Created by HuynhLQ on 11/10/2022.
//

import Foundation
import AVFAudio

// MARK: sound App
extension PlayViewController {
    func playSoundBackground() {
        var urlString = Bundle.main.path(forResource: "media5", ofType: "mp3")
        if answerCount > 5 {
            urlString = Bundle.main.path(forResource: "media10", ofType: "wav")
        }
        if answerCount > 10 {
            urlString = Bundle.main.path(forResource: "media9", ofType: "wav")
        }
        if answerCount == 16 {
            urlString = Bundle.main.path(forResource: "last_game", ofType: "wav")
        }
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            playerBackground = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = playerBackground else {
                return
            }
            if !isMute {
                player.play()
            }
        } catch {
            print("error")
        }
    }

    func playSoundCorrectAnswer() {
        var urlString = Bundle.main.path(forResource: "success", ofType: "wav")
        if answerCount >= 5 {
            urlString = Bundle.main.path(forResource: "next_level", ofType: "wav")
        }
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            playerAction = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = playerAction else {
                return
            }
            if !isMute {
                player.play()
            }
        } catch {
            print("error")
        }
    }

    func playSoundFailAnswer() {
        playerBackground?.stop()
        let urlString = Bundle.main.path(forResource: "fail", ofType: "wav")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            playerAction = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = playerAction else {
                return
            }
            player.play()
        } catch {
            print("error")
        }
    }

    func playSoundUseSupport() {
        playerActionUseSupport?.stop()
        let urlString = Bundle.main.path(forResource: "5050", ofType: "wav")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            playerActionUseSupport = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = playerActionUseSupport else {
                return
            }
            player.play()
        } catch {
            print("error")
        }
    }
}
