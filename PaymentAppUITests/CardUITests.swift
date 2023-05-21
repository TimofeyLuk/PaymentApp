//
//  CardUITests.swift
//  PaymentAppUITests
//
//  Created by Тимофей Лукашевич on 20.05.23.
//

import XCTest

final class CardUITests: XCTestCase {

    private let timeout: Double = 1
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testCardFront() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()
        
        let cardNumberField = app.textFields["CardNumberField"]
        let cardExpireDateField = app.textFields["CardExpireDateField"]
        let cardHolderNameField = app.textFields["CardHolderNameField"]
        
        let flipCardButton = app.buttons["FlipCardButton"]
        let paymentButton = app.buttons["PaymentButton"]
        
        let cardCVVField = app.textFields["CardCVVField"]
        
        // Card front exist
        XCTAssertTrue(cardNumberField.waitForExistence(timeout: timeout))
        XCTAssertTrue(cardExpireDateField.waitForExistence(timeout: timeout))
        XCTAssertTrue(cardHolderNameField.waitForExistence(timeout: timeout))
        XCTAssertTrue(flipCardButton.waitForExistence(timeout: timeout))
        XCTAssertFalse(paymentButton.waitForExistence(timeout: timeout))
        
        // Card back not exist
        XCTAssertFalse(cardCVVField.waitForExistence(timeout: timeout))
        XCTAssertEqual(flipCardButton.label, "Next")
    }
    

    func testCardBack() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()
        
        let cardNumberField = app.textFields["CardNumberField"]
        let cardExpireDateField = app.textFields["CardExpireDateField"]
        let cardHolderNameField = app.textFields["CardHolderNameField"]
        
        let flipCardButton = app.buttons["FlipCardButton"]
        let paymentButton = app.buttons["PaymentButton"]
        
        let cardCVVField = app.textFields["CardCVVField"]
        
        // Card flip
        XCTAssertTrue(flipCardButton.waitForExistence(timeout: timeout))
        flipCardButton.tap()
        
        
        // Card back exist
        XCTAssertTrue(cardCVVField.waitForExistence(timeout: timeout))
        XCTAssertEqual(flipCardButton.label, "Back")
        XCTAssertFalse(paymentButton.waitForExistence(timeout: timeout))
        XCTAssertFalse(paymentButton.waitForExistence(timeout: timeout))
        
        // Card front not exist
        XCTAssertFalse(cardNumberField.waitForExistence(timeout: timeout))
        XCTAssertFalse(cardExpireDateField.waitForExistence(timeout: timeout))
        XCTAssertFalse(cardHolderNameField.waitForExistence(timeout: timeout))
    }
    
    
    func testCardFilling() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()
        
        let cardNumberField = app.textFields["CardNumberField"]
        let cardExpireDateField = app.textFields["CardExpireDateField"]
        let cardHolderNameField = app.textFields["CardHolderNameField"]
        
        let flipCardButton = app.buttons["FlipCardButton"]
        let paymentButton = app.buttons["PaymentButton"]
        
        let cardCVVField = app.textFields["CardCVVField"]
        
        // Card front filling
        cardNumberField.tap()
        cardNumberField.typeText("4111111111111111")
        cardExpireDateField.tap()
        cardExpireDateField.typeText("1122")
        cardHolderNameField.tap()
        cardHolderNameField.typeText("Agusti Lorrin")
        
        XCTAssertEqual(cardNumberField.value as? String, "4111 1111 1111 1111")
        XCTAssertEqual(cardExpireDateField.value as? String, "11/22")
        XCTAssertEqual(cardHolderNameField.value as? String, "AGUSTI LORRIN")
        XCTAssertFalse(paymentButton.waitForExistence(timeout: timeout))
        
        // Card flip
        XCTAssertTrue(flipCardButton.waitForExistence(timeout: timeout))
        flipCardButton.tap()
        XCTAssertTrue(cardCVVField.waitForExistence(timeout: timeout))
        
        // Card back filling
        cardCVVField.tap()
        cardCVVField.typeText("1111222")
        
        XCTAssertEqual(cardCVVField.value as? String, "1111")
        
        // Paymet avalable
        XCTAssertTrue(paymentButton.waitForExistence(timeout: timeout))
        
        // Card validation
        XCTAssertTrue(flipCardButton.waitForExistence(timeout: timeout))
        flipCardButton.tap()
        XCTAssertTrue(cardNumberField.waitForExistence(timeout: timeout))
        
        cardNumberField.tap()
        // invalid card number
        
        cardNumberField.clearAndEnter(text: "4111 1111 1111 1112")
        XCTAssertEqual(cardNumberField.value as? String, "4111 1111 1111 1112")
 
        paymentButton.tap()
        
        let cardNumberError = app.staticTexts["CardValidationError\(CardValidationError.wrongCreditCardNumber.id)"]
        XCTAssertTrue(cardNumberError.waitForExistence(timeout: timeout))
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}


fileprivate extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnter(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}
