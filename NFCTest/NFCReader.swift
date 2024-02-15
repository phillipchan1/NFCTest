//
//  NFCReader.swift
//  NFCTest
//
//  Created by Phillip Chan on 2/12/24.
//

import Foundation
import CoreNFC

typealias NFCCallback = (String) -> Void

class NFCReader: NSObject, NFCNDEFReaderSessionDelegate {
    var session: NFCNDEFReaderSession?
    var callback: NFCCallback?

    func beginScanning(callback: @escaping NFCCallback) {
        self.callback = callback
        guard NFCNDEFReaderSession.readingAvailable else {
            // Notify user that NFC is not available
            return
            
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        if let message = messages.first, let record = message.records.first {
            if let payloadString = String(data: record.payload, encoding: .utf8) {
                print("NFC Tag Detected: \(payloadString)")
                callback?(payloadString)
            }
        }
    }
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Handle errors
    }
}
