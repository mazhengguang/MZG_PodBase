//
//  UILabel+Extension.swift
//  HealthStore
//
//  Created by 马争光 on 2018/9/6.
//  Copyright © 2018年 上海国民. All rights reserved.
//

import UIKit

extension UILabel {
    //便利构造函数
    convenience init(title: String,textColor: UIColor,fontName: String,fontSize: CGFloat) {
        self.init()
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        //self.font = UIFont(name: fontName, size: fontSize)
        self.sizeToFit()
    }
    
    convenience init(title: String,textColor: UIColor,fontSize: CGFloat) {
        self.init()
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.sizeToFit()
    }
    
    convenience init(title: String,textColor: UIColor,boldFontSize: CGFloat) {
        self.init()
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: boldFontSize)
        
        self.sizeToFit()
    }
  
}


extension UILabel {
    
    //根据text的字体大小和控件的宽度以及字体内容动态计算label的高度
    func getContactHeight(text: String?, width: CGFloat) -> Float {
        
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]
        let maxSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        // 计算文字占据的高度
        let size: CGSize? = text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size
        return Float(size?.height ?? 0.0)
        
    }
}


extension String {
    
    func getStringWidth(font: UIFont) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font: font]).width
    }
    
    func getStringHeigth(font: UIFont) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font: font]).height
    }
    
    func validateIdentityCard() -> Bool {
        let regex: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let test: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    func validateUserName() -> Bool {
        let regex: String = "^[A-Za-z0-9]{1,15}$"
        let test: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    func validatePhoneNumber() -> Bool { // 由于新增了许多号码，所以目前从10xxx-19xxx都加上了，实际有些是不存在的
        let regex: String = "^((10[0-9])|(11[0-9])|(12[0-9])|(13[0-9])|(14[0-9])|(15[^4,\\D])|(16[0-9])|(19[0-9])|(18[0,0-9]|(17[0-9])))\\d{8}$"
        let test: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    func validateVerifyCode() -> Bool {
        let regex: String = "^[0-9]{6}$"
        let test: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func isAlphanumericAccount() -> Bool {
        let regex: String = "[A-Za-z0-9]+"
        let test: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    //<null> 转""字符串
    mutating func changeNUll() -> (String) {
        if self == "<null>" || self == "<NULL>" || self == "<NUll>" || self == "<Null>" || self == "0.00" || self == "null" || self == "NULL" || self == "NUll" || self == "Null" {
            self = ""
        }
        return self
    }
    
    //<null> 转任意字符串
    mutating func changeNUlltoString(str: String) -> (String) {
        if self == "<null>" || self == "<NULL>" || self == "<NUll>" || self == "<Null>" || self == "0.00" || self == "null" || self == "NULL" || self == "NUll" || self == "Null" {
            self = str
        }
        return self
    }
    //时间戳->转时间
    func timestampChange() -> (String) {
        if self == "" {
            return ""
        }
        let timeInterval: TimeInterval = TimeInterval(self) ?? 0
       
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        //2.赋值
        return dateFormatter.string(from: date)
    }
    
    //时间戳->转时间  例:2015-09-21
    func timestampChangeTwo() -> (String) {
        if self == "" {
            return ""
        }
        let timeInterval: TimeInterval = TimeInterval(self) ?? 0
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //2.赋值
        return dateFormatter.string(from: date)
    }
    
    //时间戳->转时间 第三种样式
    func timestampChangeThree() -> (String) {
        if self == "" {
            return ""
        }
        let timeInterval: TimeInterval = TimeInterval(self) ?? 0
        let date = Date(timeIntervalSince1970: timeInterval / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        //2.赋值
        return dateFormatter.string(from: date)
    }
    
    //时间 -> 时间戳
    func stringToTimeStamp()->String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        let date = dfmatter.date(from: self)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
        
    }
    //时间 -> 时间戳
    func stringToTimeStampNormal()->String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let date = dfmatter.date(from: self)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
        
    }
    
    //时间 -> 时间戳  记账时间筛选
    func chargeStringToTimeStamp()->String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy.MM.dd"
        let date = dfmatter.date(from: self)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
        
    }
    
    //时间戳->转时间   记账时间筛选
    func chargeTimestampToTime() -> (String) {
        if self == "" {
            return ""
        }
        let timeInterval: TimeInterval = TimeInterval(self)!
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        //2.赋值
        return dateFormatter.string(from: date)
    }
    
    //计算字符串高度
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }
    
    //判断传入的时间差: 刚刚,几分钟之前
    func getShowFormat() -> String {
        if self == "" {
            return ""
        }
        let timeInterval: TimeInterval = TimeInterval(self)!
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale.init(identifier: "en") as Locale?
        
        let requestDate = dateFormatter.date(from: dateFormatter.string(from: date))
        if requestDate == nil{
            return "时间错误"
        }
        //获取当前时间
        var formatterString = " HH:mm"
        let calendar = Calendar.current
        //判断是否是今天
        if calendar.isDateInToday(requestDate!) {
            //获取当前时间和系统时间的差距(单位是秒)
            //强制转换为Int
            let since = Int(Date().timeIntervalSince(requestDate!))
            // 是否是刚刚
            if since < 60 {
                return "刚刚更新"
            }
            //  是否是多少分钟内
            if since < 60 * 60 {
                return "\(since/60)分钟前"
            }
            
            if since >= 60 * 60 && since < 24 * 60 * 60 {
                return "\(since/60/60)" + "小时前更新";
            }
            
            //  是否是多少小时内
            dateFormatter.dateFormat = formatterString
            //设置时间区域
            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            //格式化
            return dateFormatter.string(from: requestDate!)
        }
        //判断是否是昨天
        
        if calendar.isDateInYesterday(requestDate!) {
            formatterString = "昨天" + formatterString
        } else {
            //判断是否是一年内
            formatterString = "MM-dd" + formatterString
            //判断是否是更早期
            
            let comps = calendar.dateComponents([Calendar.Component.year], from: requestDate!, to: Date())
            
            if comps.year! >= 1 {
                formatterString = "yyyy-" + formatterString
            }
        }
        
        //按照指定的格式将日期转换为字符串
        //创建formatter
        //        let formatter = DateFormatter()
        //设置时间格式
        dateFormatter.dateFormat = formatterString
        //设置时间区域
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        //格式化
        return dateFormatter.string(from: requestDate!)
    }
    
    // 推荐&系统消息的时间显示规则: 今天:11:45  昨天, 周二, 上周-今年: 5月6号, 去年及以上:2016年3月3日
    func systemSuggestShowFormat() -> String {
        
        if self == "" {
            return ""
        }
        let timeInterval: TimeInterval = TimeInterval(self)!
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale.init(identifier: "en") as Locale?
        
        let requestDate = dateFormatter.date(from: dateFormatter.string(from: date))
        if requestDate == nil{
            return "时间错误"
        }
        //获取当前时间
        let calendar = Calendar.current
        var formatterString = " HH:mm"
        if calendar.isDateInToday(requestDate!){
            
            //设置时间格式
            dateFormatter.dateFormat = formatterString
            //设置时间区域
            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            //格式化
            return dateFormatter.string(from: requestDate!)
        }
        //昨天
        if calendar.isDateInYesterday(requestDate!) {
            formatterString = "昨天"
        } else {
            
            let since = Int(Date().timeIntervalSince(requestDate!))
            //前天-本周内的信息
            if since <= 60*60*24*8{
                
                let timeInterval: TimeInterval = TimeInterval(self)!
                let date = Date(timeIntervalSince1970: timeInterval)
                
                let interval = Int(date.timeIntervalSince1970) + NSTimeZone.local.secondsFromGMT()
                let days = Int(interval/86400) // 24*60*60
                let weekday = ((days + 4)%7+7)%7
                var temStr: String = ""
                switch weekday {
                case 1:
                    temStr = "周一"
                case 2:
                    temStr = "周二"
                case 3:
                    temStr = "周三"
                case 4:
                    temStr = "周四"
                case 5:
                    temStr = "周五"
                case 6:
                    temStr = "周六"
                default:
                    break
                    
                }
                return weekday == 0 ? "周日" : temStr
                
                
            }else{
                
                let comps = calendar.dateComponents([Calendar.Component.year], from: requestDate!, to: Date())
                
                if comps.year! >= 1 {
                    formatterString = "yyyy-MM-dd"
                }else{
                    //判断是否是一年内
                    formatterString = "MM-dd"
                }
                
            }
            
        }
        
        //按照指定的格式将日期转换为字符串
        //设置时间格式
        dateFormatter.dateFormat = formatterString
        //设置时间区域
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        //格式化
        return dateFormatter.string(from: requestDate!)
        
    }
    
//    //MARK: 字符串MD5加密
//    var md5: String {
//        
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        
//        CC_MD5(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize()
//        
//        return String(format: hash as String)
//    }
//    
    //base64编码
    func base64EncodeString(str: String) -> String {
        let data = str.data(using: String.Encoding.utf8)
        
        return (data?.base64EncodedString())!
        
    }
    //base64解码
    func base64DecodeString(str: String) -> String {
        let data = Data(base64Encoded: str)
        
        return String(data: data!, encoding: String.Encoding.utf8)!
        
        
    }
    
}

extension String {
    
    func heightWithConstrainedWidth_(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    func sizeOfTextFontSize(_ fontSize: CGFloat, maxSize: CGSize) -> CGSize {
        let attrs: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: fontSize)]
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size
        
    }
    
    // url encode
    var urlEncode: String? {
        //        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet(charactersIn: "!*'\\\";:@&=+$,/?%#[]% ").inverted)
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet(charactersIn: "`#%^{}\"[]|\\<> ").inverted)
    }
    
    // url decode
    var urlDecode: String? {
        return self.removingPercentEncoding
    }
    
    public static func dateStrFromInt(_ intTime: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: intTime / 1000)
        let dfmt = DateFormatter()
        let now = Date()
        let time = NSInteger(now.timeIntervalSince(date))
        
        if (time < 60) {
            return "刚刚"
        }else if(time < 60 * 60){
            return "\(time/60)分钟前"
        }else if(time < 60 * 60 * 24){
            return "\(time/3600)小时前"
        }else if(time < 60 * 60 * 24 * 2){
            return "昨天"
        }else{
            dfmt.dateFormat = "yyyy-MM-dd";
            return dfmt.string(from: date)
        }
    }
   
    //CFURLCreateStringByAddingPercentEscapes
    public static func urlString(_ str: String) -> String{
        let urlStr = ""
        return urlStr
    }
    public static func sizeFormate(_ size:Float) -> String {
        if size == 0 {
            return ""
        }else if size < 1024 {
            return "\(size)B"
        }else if size < 1024 * 1024 {
            return "\(String(format: "%.2f",size/1024))KB"
        }else if size < 1024 * 1024 * 1024 {
            return "\(String(format: "%.2f",size/1024/1024))MB"
        }else {
            return "\(String(format: "%.2f",size/1024/1024/1024))GB"
        }
    }
    public func isEmail() -> Bool {
        let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count))
            return matches.count > 0
        }
        catch {
            return false
        }
    }
//    public func isPhoneNumber() -> Bool {
//        let pattern = "^1[0-9]{10}$"
//        do {
//            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
//            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.characters.count))
//            return matches.count > 0
//        }
//        catch {
//            return false
//        }
//    }
//
    public func isPhoneNumber()-> Bool  {
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true)) {
            return true
        } else {
            return false
        }
    }
    
    public static func randomStr(length:Int) -> String {
        var output = ""
        for _ in 0..<length {
            let randomNumber = arc4random_uniform(1000) % 26 + 97
            let randomChar = Character(UnicodeScalar(randomNumber)!)
            output.append(randomChar)
        }
        return output
    }
    /* 如果使用需要导入 #import <CommonCrypto/CommonDigest.h>
     public func md5() ->String {
     let str = self.cString(using: String.Encoding.utf8)
     let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
     let digestLen = Int(CC_MD5_DIGEST_LENGTH)
     let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
     CC_MD5(str!, strLen, result)
     let hash = NSMutableString()
     for i in 0 ..< digestLen {
     hash.appendFormat("%02x", result[i])
     }
     result.deinitialize()
     return String(format: hash as String)
     }
     */
    static var documentPath : String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
    
    
    //空格，换行
    public func replaceUnneedCharatars(signString: String) -> (String) {
        var signStr = signString
        signStr = signStr.replacingOccurrences(of: "\'", with: "")
        signStr = signStr.replacingOccurrences(of: " ", with: "")
        signStr = signStr.replacingOccurrences(of: "\n", with: "")
        signStr = signStr.replacingOccurrences(of: "\\t", with: "")
        signStr = signStr.replacingOccurrences(of: "\\", with: "")
        
        return signStr
    }
    
    public func replaceArrCharatars(signString: String) -> (String) {
        var signStr = signString
        signStr = signStr.replacingOccurrences(of: "[", with: "")
        signStr = signStr.replacingOccurrences(of: "]", with: "")
        return signStr
    }
    
}

extension String {
    //时间转时间戳
    func timeToTimeStamp(time: String) -> String {
        let datefmatter = DateFormatter()
        datefmatter.dateFormat = "yyyy年MM月dd日"
        let date = datefmatter.date(from: time)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        return String(dateStamp)
    }
    
    //时间戳转时间
    func timeStampTotime(timeStamp: String) -> String {
        let timeInterval:TimeInterval =  TimeInterval(timeStamp)!
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy年MM月dd日" //自定义日期格式
        let time = dateformatter.string(from: date as Date)
        return  String(time)
    }
}

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
}

