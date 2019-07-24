//
//  menuData.swift
//  Resort Real Estate
//
//  Created by Farido on 7/14/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON

class menuData: NSObject {

    var id: Int
    var unittypeid: Int
    var noOfroom: Int
    var areasize: Int
    var sellingprice: Int
    var numberOfshare: Int
    var sellingSharePrice: Int
    var shareAria: Int
    var countOfSoldShare: Int
    var ownerId: Int
    var unitdescription: String
    var createdat: String
    var unitName: String
    var purposetype: Int
    var locationdescription: String
    var floorNo: Int
    var locationLatit: String
    var height: String
    var locationLang: String
    var defaultimg: String
    var countoffloors: Int
    var officeid: Int
    var smillerUnits: Int
    var enablebid: Bool
    var enabledivision: Bool
    var lastbidprice: Int
    
    
    init?(dict: [String: JSON]){
        
        if let enablebid = dict["enablebid"]?.bool{
            self.enablebid = enablebid
        }else {
            self.enablebid = false
        }
        
        if let lastbidprice = dict["lastbidprice"]?.int{
            self.lastbidprice = lastbidprice
        }else {
            self.lastbidprice = 0
        }
        
        if let enabledivision = dict["enabledivision"]?.bool{
            self.enabledivision = enabledivision
        }else {
            self.enabledivision = false
        }
        
        if let officeid = dict["officeid"]?.int{
            self.officeid = officeid
        }else {
            self.officeid = 0
        }
        
        if let smillerUnits = dict["smillerUnits"]?.int{
            self.smillerUnits = smillerUnits
        }else {
            self.smillerUnits = 0
        }
        
        if let countoffloors = dict["countoffloors"]?.int{
            self.countoffloors = countoffloors
        }else {
            self.countoffloors = 0
        }
        
        if let floorNo = dict["floorNo"]?.int{
            self.floorNo = floorNo
        }else {
            self.floorNo = 0
        }
        
        if let locationLatit = dict["locationLatit"]?.string{
            self.locationLatit = locationLatit
        }else {
            self.locationLatit = ""
        }
        
        if let defaultimg = dict["defaultimg"]?.string{
            self.defaultimg = defaultimg
        }else {
            self.defaultimg = ""
        }
        
        if let locationLang = dict["locationLang"]?.string{
            self.locationLang = locationLang
        }else {
            self.locationLang = ""
        }
        
        
        if let height = dict["height"]?.string{
            self.height = height
        }else {
            self.height = ""
        }
        
        
        if let locationdescription = dict["locationdescription"]?.string{
            self.locationdescription = locationdescription
        }else {
            self.locationdescription = ""
        }
        
        
        
        
        if let id = dict["id"]?.int{
            self.id = id
        }else {
            self.id = 0
        }
        
        if let unittypeid = dict["unittypeid"]?.int {
            self.unittypeid = unittypeid
        }else {
            self.unittypeid = 0
        }
        
        if let noOfroom = dict["noOfroom"]?.int {
            self.noOfroom = noOfroom
        }else{
            self.noOfroom = 0
        }
        
        if let areasize = dict["areasize"]?.int {
            self.areasize = areasize
        }else {
            self.areasize = 0
        }
        
        if let sellingprice = dict["sellingprice"]?.int{
            self.sellingprice = sellingprice
        }else {
            self.sellingprice = 0
        }
        
        if let numberOfshare = dict["numberOfshare"]?.int {
            self.numberOfshare = numberOfshare
        }else {
            self.numberOfshare = 0
        }
        
        if let sellingSharePrice = dict["sellingSharePrice"]?.int {
            self.sellingSharePrice = sellingSharePrice
        }else {
            self.sellingSharePrice = 0
        }
        
        if let shareAria = dict["shareAria"]?.int {
            self.shareAria = shareAria
        }else {
            self.shareAria = 0
        }
        if let countOfSoldShare = dict["countOfSoldShare"]?.int{
            self.countOfSoldShare = countOfSoldShare
        }else {
            self.countOfSoldShare = 0
        }
        
        if let ownerId = dict["ownerId"]?.int {
            self.ownerId = ownerId
        }else {
            self.ownerId = 0
        }
        
        if let unitdescription = dict["unitdescription"]?.string {
            self.unitdescription = unitdescription
        }else{
            self.unitdescription = ""
        }
        
        if let createdat = dict["createdat"]?.string{
            self.createdat = createdat
        }else {
            self.createdat = ""
        }
        
        if let unitName = dict["unitName"]?.string{
            self.unitName = unitName
        }else{
            self.unitName = ""
        }
        
        if let purposetype = dict["purposetype"]?.int{
            self.purposetype = purposetype
        }else {
            self.purposetype = 0
        }
    }
}


class getAllUnitattributes: NSObject {
    
    
    var inputvalue: String
    var labelname: String
    var measruingunittext: String
    
    
    init?(dict: [String: JSON]){
        
        if let inputvalue = dict["inputvalue"]?.string{
            self.inputvalue = inputvalue
        }else {
            self.inputvalue = ""
        }
        
        if let labelname = dict["labelname"]?.string{
            self.labelname = labelname
        }else{
            self.labelname = ""
        }
        
        if let measruingunittext = dict["measruingunittext"]?.string{
            self.measruingunittext = measruingunittext
        }else {
            self.measruingunittext = ""
        }
    }
}


class getAllUnitImages: NSObject {
    
    var id: Int
    var fileName: String

    init?(dict: [String: JSON]){
        
        if let id = dict["id"]?.int{
            self.id = id
        }else {
            self.id = 0
        }
        
        if let fileName = dict["fileName"]?.string{
            self.fileName = fileName
        }else{
            self.fileName = ""
        }
    }
}

class GetAllUnitTypes: NSObject {
    
    var id: Int
    var namear: String
    var nameen: String
    
    init?(dict: [String: JSON]){
        
        if let id = dict["id"]?.int{
            self.id = id
        }else {
            self.id = 0
        }
        
        if let namear = dict["namear"]?.string{
            self.namear = namear
        }else{
            self.namear = ""
        }
        
        if let nameen = dict["nameen"]?.string{
            self.nameen = nameen
        }else{
            self.nameen = ""
        }
    }
}

