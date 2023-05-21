//
//  CrardValidationTest.swift
//  PaymentAppTests
//
//  Created by Тимофей Лукашевич on 21.05.23.
//

import XCTest

final class CrardValidationTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    // MARK: Credit card number
    
    func testValidCardNumbers() {
        let values: [(CreditCardType, String)] = [
            (.amex, "3782 8224 6310 005"),
            (.amex, "3714 4963 5398 431"),
            (.amex, "3787 3449 3671 000"),
            (.visa, "4111 1111 1111 1111"),
            (.visa, "4012 8888 8888 1881"),
            (.visa, "4222 2222 2222 2"),
            (.masterCard, "5500 0000 0000 0004"),
            (.masterCard, "5555 5555 5555 4444"),
            (.masterCard, "5105 1051 0510 5100"),
            (.masterCard, "2222 4107 4036 0010"),
            (.maestro, "6771 7980 2100 0008"),
            (.dinersClub, "30569309025904"),
            (.jcb, "3569 9900 1009 5841"),
            (.discover, "6011 0000 0000 0004"),
            (.unionPay, "6250 9470 0000 0014"),
            (.mir, "2200 0000 0000 0004"),
            (.mir, "2200 0000 0000 0012"),
            (.mir, "2200 0000 0000 0020"),
            (.mir, "2200 0000 0000 0046"),
        ]
        values.forEach { (item) in
            XCTAssertTrue(CreditCardNumberValidator(item.1).isValid)
            XCTAssertTrue(CardValidator().validateCardNumber(item.1))
            XCTAssertEqual(item.0, CreditCardNumberValidator(item.1).type)
            XCTAssertTrue(CreditCardNumberValidator(item.1).isValid(for: item.0))
        }
    }
    
    func testInvalidCardNumbers() {
        let values: [(CreditCardType, String)] = [
            (.amex, "3782 8224 6310 006"),
            (.amex, "3714 4963 5398 432"),
            (.amex, "3787 3449 3671 001"),
            (.amex, "3715 6536 866"),
            (.visa, "4111 1111 1111 1112"),
            (.visa, "4012 8888 8888 1882"),
            (.visa, "4222 2222 2222 3"),
            (.visa, "4222 2222 2222"),
            (.masterCard, "5500 0000 0000 0005"),
            (.masterCard, "5555 5555 5555 4445"),
            (.masterCard, "5105 1051 0510 5101"),
            (.masterCard, "2222 4107 4036 0011"),
            (.masterCard, "2222 4107 4036 0011"),
            (.maestro, "6771 7980 2100 0009"),
            (.dinersClub, "30569309025905"),
            (.dinersClub, "30569309021"),
            (.jcb, "3569 9900 1009 5842"),
            (.jcb, "3569 9900 1009 3"),
            (.discover, "6011 0000 0000 0005"),
            (.discover, "6011 0000 001"),
            (.unionPay, "6250 9470 0000 0015"),
            (.mir, "2200 0000 0000 0005"),
            (.mir, "2200 0000 0000 0013"),
            (.mir, "2200 0000 0000 0021"),
            (.mir, "2200 0000 0000 0047"),
            (.mir, "2200 0000 0000 004"),
        ]
        values.forEach { (item) in
            XCTAssertFalse(CreditCardNumberValidator(item.1).isValid)
            XCTAssertFalse(CardValidator().validateCardNumber(item.1))
            XCTAssertEqual(item.0, CreditCardNumberValidator(item.1).type)
            XCTAssertFalse(CreditCardNumberValidator(item.1).isValid(for: item.0))
        }
    }
    
    // MARK: Card expire date
    
    func testValidCardExpireDate() {
        let values = [ #"05\68"#,
                       #"10\81"#,
                       #"04/90"#,
                       #"02/47"#,
                       #"05\11"#,
                       #"02\14"#,
                       #"06\70"#,
                       #"09/97"#,
                       #"04/17"#,
                       #"12\55"#,
                       #"02/89"#,
                       #"04\09"#,
                       #"04/47"#,
                       #"12\49"#,
                       #"11/99"#,
                       #"06/42"#,
                       #"01/42"#,
                       #"03\55"#,
                       #"03/79"#,
                       #"02/73"# ]
        values.forEach { (item) in
            XCTAssertTrue(CardValidator().validateCardExpireDate(item))
        }
    }
    
    func testInvalidCardExpireDate() {
        let values = [ #"6\4099"#,
                       #"11\971"#,
                       #"09\9426"#,
                       #"19/23"#,
                       #"2p19"#,
                       #"03@33"#,
                       #"1232"#,
                       #"11/\36"#,
                       #"4\9528"#,
                       #"9/5543"#,
                       #"6\673"#,
                       #"8/7332"#,
                       #"7\1086"#,
                       #"3/1164"#,
                       #"2\5931"#,
                       #"4/180"#,
                       #"11\425"#,
                       #"7/3395"#,
                       #"8/5051"#,
                       #"11/2740"# ]
        values.forEach { (item) in
            XCTAssertFalse(CardValidator().validateCardExpireDate(item))
        }
    }
    
    
    // MARK: Card holders names
    
    func testValidCardHolderNames() {
        let values = [ "Agusti Lorrin",
                       "Algar Aoife",
                       "Yuliya Ene",
                       "Verochka Roldao",
                       "Mira Hamidah",
                       "Sima Uilliam",
                       "Ernest Cahal",
                       "Attila Iryna",
                       "Gytha Firdous",
                       "Brahma Misha",
                       "Marina Jaye",
                       "Sashka Joline",
                       "Birgit Valarie",
                       "Juozas Kylo",
                       "Kalyna Hypatos",
                       "Olalekan Tara",
                       "Sigurd Brutus",
                       "Seo Ruska",
                       "Rukmini Adetokunbo",
                       "Dacian Hedi" ]
            .map({ $0.uppercased() })
        
        values.forEach { (item) in
            XCTAssertTrue(CardValidator().validateCardHolderName(item))
        }
    }
    
    func testInvalidCardHolderNames() {
        let values = [ "Agusti LORRIN",
                       "Algar Aoife",
                       "YULIYA",
                       "VEROCHKA ROLDAÓ",
                       "MIRA HAMIDÁ",
                       "Sima ",
                       "ERNEŚT CAHAL",
                       " IRYNA",
                       "GYTHA FIRDOUS FFFD",
                       "BRAHMABRAHMABRAHMABRAHMABRAHMA MISHAFDFDFDFDFDDFDFDFFDFDDD",
                       "MARINA EÉR5",
                       "SASHKASASHKASADASDASDSADADASDSHKA JODADLINEJOLINEJOLINEFSFSAFWFASFSFAS",
                       "Birgit Valarie BirgitBirgit",
                       "Juozas ",
                       "Kalÿna Hypatos",
                       "OLALEKAN TARA2WW",
                       "Sigurd Brutus",
                       "SEO RUŠKA",
                       "Rukmini Adetokunbo Adetokunbo",
                       "DACIAN" ]
        
        values.forEach { (item) in
            XCTAssertFalse(CardValidator().validateCardHolderName(item))
        }
    }
    
    
    // MARK: Card CVV
    
    func testValidCardCVV() {
        let values = [ "011",
                       "5407",
                       "552",
                       "4939",
                       "542",
                       "6378",
                       "385",
                       "9480",
                       "7860",
                       "631",
                       "773",
                       "159",
                       "9639",
                       "140",
                       "788",
                       "4721",
                       "2640",
                       "735",
                       "779",
                       "4181" ]
        values.forEach { (item) in
            XCTAssertTrue(CardValidator().validateCardCVV(item))
        }
    }
    
    func testInvalidCardCVV() {
        let values = [ "45",
                       "25131",
                       "533291",
                       "58",
                       "4",
                       "65539",
                       "30608",
                       "674681",
                       "66040",
                       "25903",
                       "1",
                       "54137",
                       "84",
                       "68691",
                       "69657",
                       "259777",
                       "75",
                       "80",
                       "66686",
                       "160987" ]
        values.forEach { (item) in
            XCTAssertFalse(CardValidator().validateCardCVV(item))
        }
    }
    
    
}
