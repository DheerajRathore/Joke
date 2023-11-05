//
//  Date_Ext.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 02/11/23.
//

import Foundation

extension Date {
        func getFormatedDate(_ date: Date) -> String {
//        let date = Date()
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "MMM, d YYYY 'at' HH:mm:ss a"
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
}


