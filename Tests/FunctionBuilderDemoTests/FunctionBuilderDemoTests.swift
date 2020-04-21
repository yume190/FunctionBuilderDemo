import XCTest
@testable import FunctionBuilderDemo

func buildString(_ isPass: Bool = false, @StringBuilder _ build: (Bool) -> String) -> String {
    return build(isPass)
}

#if swift(>=5.3)
func buildResult(_ str: String) -> String {
    return ".result(\(str))"
}
#else
func buildResult(_ str: String) -> String {
    return str
}
#endif

final class FunctionBuilderDemoTests: XCTestCase {
    /// .empty
    func testEmpty() {
        let result = buildResult(".empty")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            
        }
        let closure = buildString { _ -> String in
            
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(), result)
    }
    
    #if swift(>=5.3)
    func testSingle() {
        let result = buildResult(".single(.s(a))")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            "a"
        }
        let closure = buildString { _ -> String in
            "a"
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(), result)
    }
    #else
    /// .single(.s(a))
    ///  * closure a
    ///  * function .single(a)
    func testSingle() {
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            "a"
        }
        let closure = buildString { _ -> String in
            "a"
        }
        XCTAssertEqual(closure, "a")
        XCTAssertEqual(builder(), ".single(a)")
    }
    #endif
    
    /// .[.s(a), .s(b)]
    func testMulti() {
        let result = buildResult("[.s(a), .s(b)]")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            "a"
            "b"
        }
        let closure = buildString { _ -> String in
            "a"
            "b"
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(), result)
    }
    
    /// [.i(1), .f(2.0), .d(3.0), .s(4)]
    func testExpression() {
        let i: Int = 1
        let f: Float = 2
        let d: Double = 3
        let s: String = "4"
        let result = buildResult("[.i(1), .f(2.0), .d(3.0), .s(4)]")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            i
            f
            d
            s
        }
        let closure = buildString { _ -> String in
            i
            f
            d
            s
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(), result)
    }
    
    
    func testIfTrueEmpty() {
        let result = buildResult(".single(.if(.empty))")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            if isPass {
                
            }
        }
        let closure = buildString(true) { isPass -> String in
            if isPass {
                
            }
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(true), result)
    }
    
    func testIfTrueSingle() {
        let result = buildResult(".single(.if(.single(.s(a))))")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            if isPass {
                "a"
            }
        }
        let closure = buildString(true) { isPass -> String in
            if isPass {
                "a"
            }
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(true), result)
    }
    
    func testIfTrueMulti() {
        let result = buildResult(".single(.if([.s(a), .s(b)]))")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            if isPass {
                "a"
                "b"
            }
        }
        let closure = buildString(true) { isPass -> String in
            if isPass {
                "a"
                "b"
            }
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(true), result)
    }
    
    func testIfFalse() {
        let result = buildResult(".single(.if(nil))")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            if isPass {
                "a"
            }
        }
        let closure = buildString { isPass -> String in
            if isPass {
                "a"
            }
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(), result)
    }
    
    func testIfFalse2() {
        let i = 1
        let result = buildResult(".single(.right(.right(.single(.s(d)))")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            if isPass {
                "a"
            } else if i == 2 {
                "b"
            } else if i == 3 {
                "c"
            } else {
                "d"
            }
        }
        let closure = buildString { isPass -> String in
            if isPass {
                "a"
            } else if i == 2 {
                "b"
            } else if i == 3 {
                "c"
            } else {
                "d"
            }
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(), result)
    }
    
    func testDoSingle() {
        let result = buildResult(".single(.do(.single(.s(a))))")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            do {
                "a"
            }
        }
        let closure = buildString { isPass -> String in
            do {
                "a"
            }
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(), result)
    }
    
    func testDoMulti() {
        let result = buildResult(".single(.do([.i(1), .s(a)]))")
        @StringBuilder func builder(_ isPass: Bool = false) -> String {
            do {
                1
                "a"
            }
        }
        let closure = buildString { isPass -> String in
            do {
                1
                "a"
            }
        }
        XCTAssertEqual(closure, result)
        XCTAssertEqual(builder(), result)
    }
    
    
    static var allTests = [
        ("testExample", testEmpty),
        ("testSingle", testSingle),
        ("testMulti", testMulti),
        ("testExpression", testExpression),
        ("testIfTrueEmpty", testIfTrueEmpty),
        ("testIfTrueSingle", testIfTrueSingle),
        ("testIfTrueMulti", testIfTrueMulti),
        ("testIfFalse", testIfFalse),
        ("testIfFalse2", testIfFalse2),
        ("testDoSingle", testDoSingle),
        ("testDoMulti", testDoMulti),
    ]
}
