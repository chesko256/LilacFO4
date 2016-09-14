scriptname lilac_test extends Lilac


function TestSuites()
	describe("Conditions", ConditionTestCases())
	describe("Matchers", MatcherTestCases())
	describe("Test Cases", TestCaseTestCases())
	describe("Messages", MessageTestCases())
endFunction


; Test Suites =================================================================

bool function ConditionTestCases()
	it("'to' should be true", case_condition_to())
	it("'notTo' should be false", case_condition_notTo())
	return true
endFunction

bool function MatcherTestCases()
	it("'beEqualTo' should evaluate equality", case_matcher_beEqualTo())
	it("'beEqualTo' should evaluate equality (untyped)", case_matcher_beEqualTo_untyped())
	it("'beLessThan' should evaluate less than", case_matcher_beLessThan())
	it("'beLessThan' should evaluate less than (untyped)", case_matcher_beLessThan_untyped())
	it("'beLessThanOrEqualTo' should evaluate less than or equal to", case_matcher_beLessThanOrEqualTo())
	it("'beLessThanOrEqualTo' should evaluate less than or equal to (untyped)", case_matcher_beLessThanOrEqualTo_untyped())
	it("'beGreaterThan' should evaluate greater than", case_matcher_beGreaterThan())
	it("'beGreaterThan' should evaluate greater than (untyped)", case_matcher_beGreaterThan_untyped())
	it("'beGreaterThanOrEqualTo' should evaluate greater than or equal to", case_matcher_beGreaterThanOrEqualTo())
	it("'beGreaterThanOrEqualTo' should evaluate greater than or equal to (untyped)", case_matcher_beGreaterThanOrEqualTo_untyped())
	it("'beTruthy' should evaluate truthiness", case_matcher_beTruthy())
	it("'beTruthy' should evaluate truthiness (untyped)", case_matcher_beTruthy_untyped())
	it("'beFalsy' should evaluate falsiness", case_matcher_beFalsy())
	it("'beFalsy' should evaluate falsiness (untyped)", case_matcher_beFalsy_untyped())
	it("'beNone' should evaluate None", case_matcher_beNone())
	it("'beNone' should evaluate None (untyped)", case_matcher_beNone_untyped())
	return true
endFunction

bool function TestCaseTestCases()
	it("should run beforeEach and afterEach before and after every test case", case_testcase_BeforeAfterEach())
	it("'describe' should run all test cases in its suite", case_testcase_describe())
	return true
endFunction

bool function MessageTestCases()
	it("should create correct step failure messages", case_message_stepfailure())
	it("should create an invalid matcher message", case_message_invalidmatcher())
	return true
endFunction


; Test Cases ==================================================================

mockLilac mockLilacTest
Armor Armor_Army_Helmet
ObjectReference TestArmorRef
Form EmptyForm

function beforeAll()
	mockLilacTest = Game.GetFormFromFile(0x000F99, "LilacTestLilac.esp") as mockLilac
	mockLilacTest.mockLastLilacDebugMessage = ""
	mockLilacTest.mockLastRaisedResultResult = true
	Armor_Army_Helmet = Game.GetFormFromFile(0x23432, "Fallout4.esm") as Armor
	TestArmorRef = Game.GetPlayer().PlaceAtMe(Armor_Army_Helmet)
	EmptyForm = None
endFunction

function beforeEach()
	mockLilacTest.ResetTestRunner()
	mockLilacTest.mockBeforeEachCallCount = 0
	mockLilacTest.mockAfterEachCallCount = 0
	mockLilacTest.mockItCallCount = 0
endFunction

function afterAll()
	mockLilacTest.mockLastLilacDebugMessage = ""
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest = None
	Armor_Army_Helmet = None
	TestArmorRef.Disable()
	TestArmorRef.Delete()
endFunction

function afterEach()
	mockLilacTest.ResetTestRunner()
	mockLilacTest.mockBeforeEachCallCount = 0
	mockLilacTest.mockAfterEachCallCount = 0
	mockLilacTest.mockItCallCount = 0
endFunction


bool function case_condition_to()
	expectBool(self.to, to, beTruthy)
	return true
endFunction

bool function case_condition_notTo()
	expectBool(self.notTo, to, beFalsy)
	return true
endFunction

bool function case_matcher_beEqualTo()
	expectInt(5, to, beEqualTo, 5)
	expectInt(5, notTo, beEqualTo, 12)

	expectFloat(7.0, to, beEqualTo, 7.0)
	expectFloat(7.0, notTo, beEqualTo, 3.45)

	expectBool(true, to, beEqualTo, true)
	expectBool(false, to, beEqualTo, false)
	expectBool(true, notTo, beEqualTo, false)
	expectBool(false, notTo, beEqualTo, true)

	expectString("test string", to, beEqualTo, "test string")
	expectString("test string", notTo, beEqualTo, "other string")
	expectString("", to, beEqualTo, "")

	expectForm(Armor_Army_Helmet, to, beEqualTo, Armor_Army_Helmet)
	expectForm(Armor_Army_Helmet, notTo, beEqualTo, None)
	expectForm(Armor_Army_Helmet, notTo, beEqualTo, Game.GetPlayer().GetActorBase())

	expectRef(TestArmorRef, to, beEqualTo, TestArmorRef)
	expectRef(TestArmorRef, notTo, beEqualTo, None)
	expectRef(TestArmorRef, notTo, beEqualTo, Game.GetPlayer())
	return true
endFunction

bool function case_matcher_beEqualTo_untyped()
	expect(5, to, beEqualTo, 5)
	expect(5, notTo, beEqualTo, 12)

	expect(7.0, to, beEqualTo, 7.0)
	expect(7.0, notTo, beEqualTo, 3.45)

	expect(true, to, beEqualTo, true)
	expect(false, to, beEqualTo, false)
	expect(true, notTo, beEqualTo, false)
	expect(false, notTo, beEqualTo, true)

	expect("test string", to, beEqualTo, "test string")
	expect("test string", notTo, beEqualTo, "other string")
	expect("", to, beEqualTo, "")

	expect(Armor_Army_Helmet, to, beEqualTo, Armor_Army_Helmet)
	expect(Armor_Army_Helmet, notTo, beEqualTo, None)
	expect(Armor_Army_Helmet, notTo, beEqualTo, Game.GetPlayer().GetActorBase())

	expect(TestArmorRef, to, beEqualTo, TestArmorRef)
	expect(TestArmorRef, notTo, beEqualTo, None)
	expect(TestArmorRef, notTo, beEqualTo, Game.GetPlayer())
	return true
endFunction

bool function case_matcher_beLessThan()
	expectInt(3, to, beLessThan, 1000)
	expectInt(3, to, beLessThan, 4)
	expectInt(3, notTo, beLessThan, 3)
	expectInt(3, notTo, beLessThan, 1)

	expectInt(-5, to, beLessThan, 1000)
	expectInt(-5, to, beLessThan, -4)
	expectInt(-5, notTo, beLessThan, -5)
	expectInt(-5, notTo, beLessThan, -7)

	expectFloat(4.5, to, beLessThan, 100.0)
	expectFloat(4.5, to, beLessThan, 5.0)
	expectFloat(4.5, to, beLessThan, 4.6)
	expectFloat(4.5, to, beLessThan, 4.51)
	expectFloat(4.5, notTo, beLessThan, 4.5)
	expectFloat(4.5, notTo, beLessThan, 4.4)
	expectFloat(4.5, notTo, beLessThan, 1.0)

	expectFloat(-12.6, to, beLessThan, 100.0)
	expectFloat(-12.6, to, beLessThan, -12.0)
	expectFloat(-12.6, to, beLessThan, -12.5)
	expectFloat(-12.6, to, beLessThan, -12.59)
	expectFloat(-12.6, notTo, beLessThan, -12.6)
	expectFloat(-12.6, notTo, beLessThan, -13.0)
	expectFloat(-12.6, notTo, beLessThan, -100.0)
	return true
endFunction

bool function case_matcher_beLessThan_untyped()
	expect(3, to, beLessThan, 1000)
	expect(3, to, beLessThan, 4)
	expect(3, notTo, beLessThan, 3)
	expect(3, notTo, beLessThan, 1)

	expect(-5, to, beLessThan, 1000)
	expect(-5, to, beLessThan, -4)
	expect(-5, notTo, beLessThan, -5)
	expect(-5, notTo, beLessThan, -7)

	expect(4.5, to, beLessThan, 100.0)
	expect(4.5, to, beLessThan, 5.0)
	expect(4.5, to, beLessThan, 4.6)
	expect(4.5, to, beLessThan, 4.51)
	expect(4.5, notTo, beLessThan, 4.5)
	expect(4.5, notTo, beLessThan, 4.4)
	expect(4.5, notTo, beLessThan, 1.0)

	expect(-12.6, to, beLessThan, 100.0)
	expect(-12.6, to, beLessThan, -12.0)
	expect(-12.6, to, beLessThan, -12.5)
	expect(-12.6, to, beLessThan, -12.59)
	expect(-12.6, notTo, beLessThan, -12.6)
	expect(-12.6, notTo, beLessThan, -13.0)
	expect(-12.6, notTo, beLessThan, -100.0)
	return true
endFunction

bool function case_matcher_beLessThanOrEqualTo()
	expectInt(3, to, beLessThanOrEqualTo, 1000)
	expectInt(3, to, beLessThanOrEqualTo, 4)
	expectInt(3, to, beLessThanOrEqualTo, 3)
	expectInt(3, notTo, beLessThanOrEqualTo, 1)

	expectInt(-5, to, beLessThanOrEqualTo, 1000)
	expectInt(-5, to, beLessThanOrEqualTo, -4)
	expectInt(-5, to, beLessThanOrEqualTo, -5)
	expectInt(-5, notTo, beLessThanOrEqualTo, -7)

	expectFloat(4.5, to, beLessThanOrEqualTo, 100.0)
	expectFloat(4.5, to, beLessThanOrEqualTo, 5.0)
	expectFloat(4.5, to, beLessThanOrEqualTo, 4.6)
	expectFloat(4.5, to, beLessThanOrEqualTo, 4.51)
	expectFloat(4.5, to, beLessThanOrEqualTo, 4.5)
	expectFloat(4.5, notTo, beLessThanOrEqualTo, 4.4)
	expectFloat(4.5, notTo, beLessThanOrEqualTo, 1.0)

	expectFloat(-12.6, to, beLessThanOrEqualTo, 100.0)
	expectFloat(-12.6, to, beLessThanOrEqualTo, -12.0)
	expectFloat(-12.6, to, beLessThanOrEqualTo, -12.5)
	expectFloat(-12.6, to, beLessThanOrEqualTo, -12.59)
	expectFloat(-12.6, to, beLessThanOrEqualTo, -12.6)
	expectFloat(-12.6, notTo, beLessThanOrEqualTo, -13.0)
	expectFloat(-12.6, notTo, beLessThanOrEqualTo, -100.0)
	return true
endFunction

bool function case_matcher_beLessThanOrEqualTo_untyped()
	expect(3, to, beLessThanOrEqualTo, 1000)
	expect(3, to, beLessThanOrEqualTo, 4)
	expect(3, to, beLessThanOrEqualTo, 3)
	expect(3, notTo, beLessThanOrEqualTo, 1)

	expect(-5, to, beLessThanOrEqualTo, 1000)
	expect(-5, to, beLessThanOrEqualTo, -4)
	expect(-5, to, beLessThanOrEqualTo, -5)
	expect(-5, notTo, beLessThanOrEqualTo, -7)

	expect(4.5, to, beLessThanOrEqualTo, 100.0)
	expect(4.5, to, beLessThanOrEqualTo, 5.0)
	expect(4.5, to, beLessThanOrEqualTo, 4.6)
	expect(4.5, to, beLessThanOrEqualTo, 4.51)
	expect(4.5, to, beLessThanOrEqualTo, 4.5)
	expect(4.5, notTo, beLessThanOrEqualTo, 4.4)
	expect(4.5, notTo, beLessThanOrEqualTo, 1.0)

	expect(-12.6, to, beLessThanOrEqualTo, 100.0)
	expect(-12.6, to, beLessThanOrEqualTo, -12.0)
	expect(-12.6, to, beLessThanOrEqualTo, -12.5)
	expect(-12.6, to, beLessThanOrEqualTo, -12.59)
	expect(-12.6, to, beLessThanOrEqualTo, -12.6)
	expect(-12.6, notTo, beLessThanOrEqualTo, -13.0)
	expect(-12.6, notTo, beLessThanOrEqualTo, -100.0)
	return true
endFunction

bool function case_matcher_beGreaterThan()
	expectInt(7, to, beGreaterThan, 5)
	expectInt(7, to, beGreaterThan, -6)
	expectInt(7, to, beGreaterThan, 6)
	expectInt(7, notTo, beGreaterThan, 7)
	expectInt(7, notTo, beGreaterThan, 8)

	expectInt(-8, to, beGreaterThan, -10)
	expectInt(-8, to, beGreaterThan, -1000)
	expectInt(-8, to, beGreaterThan, -9)
	expectInt(-8, notTo, beGreaterThan, -8)
	expectInt(-8, notTo, beGreaterThan, -7)
	expectInt(-8, notTo, beGreaterThan, 12)

	expectFloat(4.5, to, beGreaterThan, 1.0)
	expectFloat(4.5, to, beGreaterThan, 4.0)
	expectFloat(4.5, to, beGreaterThan, 4.4)
	expectFloat(4.5, to, beGreaterThan, 4.45)
	expectFloat(4.5, to, beGreaterThan, 4.4999)
	expectFloat(4.5, notTo, beGreaterThan, 4.5)
	expectFloat(4.5, notTo, beGreaterThan, 23.6)

	expectFloat(-12.6, to, beGreaterThan, -100.0)
	expectFloat(-12.6, to, beGreaterThan, -14.0)
	expectFloat(-12.6, to, beGreaterThan, -12.7)
	expectFloat(-12.6, to, beGreaterThan, -12.61)
	expectFloat(-12.6, notTo, beGreaterThan, -12.6)
	expectFloat(-12.6, notTo, beGreaterThan, -12.5)
	expectFloat(-12.6, notTo, beGreaterThan, 100.0)
	return true
endFunction

bool function case_matcher_beGreaterThan_untyped()
	expect(7, to, beGreaterThan, 5)
	expect(7, to, beGreaterThan, -6)
	expect(7, to, beGreaterThan, 6)
	expect(7, notTo, beGreaterThan, 7)
	expect(7, notTo, beGreaterThan, 8)

	expect(-8, to, beGreaterThan, -10)
	expect(-8, to, beGreaterThan, -1000)
	expect(-8, to, beGreaterThan, -9)
	expect(-8, notTo, beGreaterThan, -8)
	expect(-8, notTo, beGreaterThan, -7)
	expect(-8, notTo, beGreaterThan, 12)

	expect(4.5, to, beGreaterThan, 1.0)
	expect(4.5, to, beGreaterThan, 4.0)
	expect(4.5, to, beGreaterThan, 4.4)
	expect(4.5, to, beGreaterThan, 4.45)
	expect(4.5, to, beGreaterThan, 4.4999)
	expect(4.5, notTo, beGreaterThan, 4.5)
	expect(4.5, notTo, beGreaterThan, 23.6)

	expect(-12.6, to, beGreaterThan, -100.0)
	expect(-12.6, to, beGreaterThan, -14.0)
	expect(-12.6, to, beGreaterThan, -12.7)
	expect(-12.6, to, beGreaterThan, -12.61)
	expect(-12.6, notTo, beGreaterThan, -12.6)
	expect(-12.6, notTo, beGreaterThan, -12.5)
	expect(-12.6, notTo, beGreaterThan, 100.0)
	return true
endFunction

bool function case_matcher_beGreaterThanOrEqualTo()
	expectInt(7, to, beGreaterThanOrEqualTo, 5)
	expectInt(7, to, beGreaterThanOrEqualTo, -6)
	expectInt(7, to, beGreaterThanOrEqualTo, 6)
	expectInt(7, to, beGreaterThanOrEqualTo, 7)
	expectInt(7, notTo, beGreaterThanOrEqualTo, 8)

	expectInt(-8, to, beGreaterThanOrEqualTo, -10)
	expectInt(-8, to, beGreaterThanOrEqualTo, -1000)
	expectInt(-8, to, beGreaterThanOrEqualTo, -9)
	expectInt(-8, to, beGreaterThanOrEqualTo, -8)
	expectInt(-8, notTo, beGreaterThanOrEqualTo, -7)
	expectInt(-8, notTo, beGreaterThanOrEqualTo, 12)

	expectFloat(4.5, to, beGreaterThanOrEqualTo, 1.0)
	expectFloat(4.5, to, beGreaterThanOrEqualTo, 4.0)
	expectFloat(4.5, to, beGreaterThanOrEqualTo, 4.4)
	expectFloat(4.5, to, beGreaterThanOrEqualTo, 4.45)
	expectFloat(4.5, to, beGreaterThanOrEqualTo, 4.4999)
	expectFloat(4.5, to, beGreaterThanOrEqualTo, 4.5)
	expectFloat(4.5, notTo, beGreaterThanOrEqualTo, 4.51)
	expectFloat(4.5, notTo, beGreaterThanOrEqualTo, 23.6)

	expectFloat(-12.6, to, beGreaterThanOrEqualTo, -100.0)
	expectFloat(-12.6, to, beGreaterThanOrEqualTo, -14.0)
	expectFloat(-12.6, to, beGreaterThanOrEqualTo, -12.7)
	expectFloat(-12.6, to, beGreaterThanOrEqualTo, -12.61)
	expectFloat(-12.6, to, beGreaterThanOrEqualTo, -12.6)
	expectFloat(-12.6, notTo, beGreaterThanOrEqualTo, -12.5)
	expectFloat(-12.6, notTo, beGreaterThanOrEqualTo, 100.0)
	return true
endFunction

bool function case_matcher_beGreaterThanOrEqualTo_untyped()
	expect(7, to, beGreaterThanOrEqualTo, 5)
	expect(7, to, beGreaterThanOrEqualTo, -6)
	expect(7, to, beGreaterThanOrEqualTo, 6)
	expect(7, to, beGreaterThanOrEqualTo, 7)
	expect(7, notTo, beGreaterThanOrEqualTo, 8)

	expect(-8, to, beGreaterThanOrEqualTo, -10)
	expect(-8, to, beGreaterThanOrEqualTo, -1000)
	expect(-8, to, beGreaterThanOrEqualTo, -9)
	expect(-8, to, beGreaterThanOrEqualTo, -8)
	expect(-8, notTo, beGreaterThanOrEqualTo, -7)
	expect(-8, notTo, beGreaterThanOrEqualTo, 12)

	expect(4.5, to, beGreaterThanOrEqualTo, 1.0)
	expect(4.5, to, beGreaterThanOrEqualTo, 4.0)
	expect(4.5, to, beGreaterThanOrEqualTo, 4.4)
	expect(4.5, to, beGreaterThanOrEqualTo, 4.45)
	expect(4.5, to, beGreaterThanOrEqualTo, 4.4999)
	expect(4.5, to, beGreaterThanOrEqualTo, 4.5)
	expect(4.5, notTo, beGreaterThanOrEqualTo, 4.51)
	expect(4.5, notTo, beGreaterThanOrEqualTo, 23.6)

	expect(-12.6, to, beGreaterThanOrEqualTo, -100.0)
	expect(-12.6, to, beGreaterThanOrEqualTo, -14.0)
	expect(-12.6, to, beGreaterThanOrEqualTo, -12.7)
	expect(-12.6, to, beGreaterThanOrEqualTo, -12.61)
	expect(-12.6, to, beGreaterThanOrEqualTo, -12.6)
	expect(-12.6, notTo, beGreaterThanOrEqualTo, -12.5)
	expect(-12.6, notTo, beGreaterThanOrEqualTo, 100.0)
	return true
endFunction

bool function case_matcher_beTruthy()
	expectInt(1, to, beTruthy)
	expectInt(0, notTo, beTruthy)
	expectInt(-1, to, beTruthy)

	expectFloat(1.0, to, beTruthy)
	expectFloat(0.001, to, beTruthy)
	expectFloat(0.0, notTo, beTruthy)
	expectFloat(-12.5, to, beTruthy)

	expectBool(true, to, beTruthy)
	expectBool(false, notTo, beTruthy)

	expectForm(Armor_Army_Helmet, to, beTruthy)
	expectForm(EmptyForm, notTo, beTruthy)

	ObjectReference EmptyRef = None
	expectRef(TestArmorRef, to, beTruthy)
	expectRef(EmptyRef, notTo, beTruthy)

	expectString("test string", to, beTruthy)
	expectString("", notTo, beTruthy)
	return true
endFunction

bool function case_matcher_beTruthy_untyped()
	expect(1, to, beTruthy)
	expect(0, notTo, beTruthy)
	expect(-1, to, beTruthy)

	expect(1.0, to, beTruthy)
	expect(0.001, to, beTruthy)
	expect(0.0, notTo, beTruthy)
	expect(-12.5, to, beTruthy)

	expect(true, to, beTruthy)
	expect(false, notTo, beTruthy)

	expect(Armor_Army_Helmet, to, beTruthy)
	expect(EmptyForm, notTo, beTruthy)

	ObjectReference EmptyRef = None
	expect(TestArmorRef, to, beTruthy)
	expect(EmptyRef, notTo, beTruthy)

	expect("test string", to, beTruthy)
	expect("", notTo, beTruthy)
	return true
endFunction

bool function case_matcher_beFalsy()
	expectInt(1, notTo, beFalsy)
	expectInt(0, to, beFalsy)
	expectInt(-1, notTo, beFalsy)

	expectFloat(1.0, notTo, beFalsy)
	expectFloat(0.001, notTo, beFalsy)
	expectFloat(0.0, to, beFalsy)
	expectFloat(-12.5, notTo, beFalsy)

	expectBool(true, notTo, beFalsy)
	expectBool(false, to, beFalsy)

	expectForm(Armor_Army_Helmet, notTo, beFalsy)
	expectForm(EmptyForm, to, beFalsy)

	ObjectReference EmptyRef = None
	expectRef(TestArmorRef, notTo, beFalsy)
	expectRef(EmptyRef, to, beFalsy)

	expectString("test string", notTo, beFalsy)
	expectString("", to, beFalsy)
	return true
endFunction

bool function case_matcher_beFalsy_untyped()
	expect(1, notTo, beFalsy)
	expect(0, to, beFalsy)
	expect(-1, notTo, beFalsy)

	expect(1.0, notTo, beFalsy)
	expect(0.001, notTo, beFalsy)
	expect(0.0, to, beFalsy)
	expect(-12.5, notTo, beFalsy)

	expect(true, notTo, beFalsy)
	expect(false, to, beFalsy)

	expect(Armor_Army_Helmet, notTo, beFalsy)
	expect(EmptyForm, to, beFalsy)

	ObjectReference EmptyRef = None
	expect(TestArmorRef, notTo, beFalsy)
	expect(EmptyRef, to, beFalsy)

	expect("test string", notTo, beFalsy)
	expect("", to, beFalsy)
	return true
endFunction

bool function case_matcher_beNone()
	expectForm(EmptyForm, to, beNone)
	expectForm(Armor_Army_Helmet, notTo, beNone)

	ObjectReference EmptyRef = None
	expectRef(EmptyRef, to, beNone)
	expectRef(TestArmorRef, notTo, beNone)
	return true
endFunction

bool function case_matcher_beNone_untyped()
	expect(EmptyForm, to, beNone)
	expect(Armor_Army_Helmet, notTo, beNone)

	ObjectReference EmptyRef = None
	expect(EmptyRef, to, beNone)
	expect(TestArmorRef, notTo, beNone)
	return true
endFunction

bool function case_message_stepfailure()
	int i = 0

	mockLilacTest.failedActuals[i] = "5"
	mockLilacTest.failedConditions[i] = to
	mockLilacTest.failedMatchers[i] = beEqualTo
	mockLilacTest.failedExpecteds[i] = "76"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 1: expected 5 to be equal to 76")

	i += 1

	mockLilacTest.failedActuals[i] = "5"
	mockLilacTest.failedConditions[i] = notTo
	mockLilacTest.failedMatchers[i] = beEqualTo
	mockLilacTest.failedExpecteds[i] = "5"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 2: expected 5 not to be equal to 5")

	i += 1

	mockLilacTest.failedActuals[i] = "98"
	mockLilacTest.failedConditions[i] = to
	mockLilacTest.failedMatchers[i] = beLessThan
	mockLilacTest.failedExpecteds[i] = "12"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 3: expected 98 to be less than 12")

	i += 1

	mockLilacTest.failedActuals[i] = "12.65"
	mockLilacTest.failedConditions[i] = notTo
	mockLilacTest.failedMatchers[i] = beLessThan
	mockLilacTest.failedExpecteds[i] = "35.97"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 4: expected 12.65 not to be less than 35.97")

	i += 1

	mockLilacTest.failedActuals[i] = "98"
	mockLilacTest.failedConditions[i] = to
	mockLilacTest.failedMatchers[i] = beLessThanOrEqualTo
	mockLilacTest.failedExpecteds[i] = "12"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 5: expected 98 to be less than or equal to 12")

	i += 1

	mockLilacTest.failedActuals[i] = "12.65"
	mockLilacTest.failedConditions[i] = notTo
	mockLilacTest.failedMatchers[i] = beLessThanOrEqualTo
	mockLilacTest.failedExpecteds[i] = "12.65"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 6: expected 12.65 not to be less than or equal to 12.65")

	i += 1

	mockLilacTest.failedActuals[i] = "12.8"
	mockLilacTest.failedConditions[i] = to
	mockLilacTest.failedMatchers[i] = beGreaterThan
	mockLilacTest.failedExpecteds[i] = "98.2"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 7: expected 12.8 to be greater than 98.2")

	i += 1

	mockLilacTest.failedActuals[i] = "12.65"
	mockLilacTest.failedConditions[i] = notTo
	mockLilacTest.failedMatchers[i] = beGreaterThan
	mockLilacTest.failedExpecteds[i] = "10.333333"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 8: expected 12.65 not to be greater than 10.333333")

	i += 1

	mockLilacTest.failedActuals[i] = "16"
	mockLilacTest.failedConditions[i] = to
	mockLilacTest.failedMatchers[i] = beGreaterThanOrEqualTo
	mockLilacTest.failedExpecteds[i] = "10356"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 9: expected 16 to be greater than or equal to 10356")

	i += 1

	mockLilacTest.failedActuals[i] = "10.333333"
	mockLilacTest.failedConditions[i] = notTo
	mockLilacTest.failedMatchers[i] = beGreaterThanOrEqualTo
	mockLilacTest.failedExpecteds[i] = "10.333333"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 10: expected 10.333333 not to be greater than or equal to 10.333333")

	i += 1

	mockLilacTest.failedActuals[i] = "false"
	mockLilacTest.failedConditions[i] = to
	mockLilacTest.failedMatchers[i] = beTruthy
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 11: expected false to be truthy")

	i += 1

	mockLilacTest.failedActuals[i] = "true"
	mockLilacTest.failedConditions[i] = notTo
	mockLilacTest.failedMatchers[i] = beTruthy
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 12: expected true not to be truthy")

	i += 1

	mockLilacTest.failedActuals[i] = "true"
	mockLilacTest.failedConditions[i] = to
	mockLilacTest.failedMatchers[i] = beFalsy
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 13: expected true to be falsy")

	i += 1

	mockLilacTest.failedActuals[i] = "false"
	mockLilacTest.failedConditions[i] = notTo
	mockLilacTest.failedMatchers[i] = beFalsy
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 14: expected false not to be falsy")

	i += 1

	mockLilacTest.failedActuals[i] = "WeaponObject"
	mockLilacTest.failedConditions[i] = to
	mockLilacTest.failedMatchers[i] = beNone
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 15: expected WeaponObject to be None")

	i += 1

	mockLilacTest.failedActuals[i] = "None"
	mockLilacTest.failedConditions[i] = notTo
	mockLilacTest.failedMatchers[i] = beNone
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), to, beEqualTo, \
		         "        - Expect 16: expected None not to be None")

	return true
endFunction

bool function case_message_invalidmatcher()

	; expectForm
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(Armor_Army_Helmet, to, beGreaterThan, Armor_Army_Helmet)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(Armor_Army_Helmet, to, beGreaterThanOrEqualTo, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(Armor_Army_Helmet, to, beLessThan, Armor_Army_Helmet)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(Armor_Army_Helmet, to, beLessThanOrEqualTo, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(Armor_Army_Helmet, notTo, beGreaterThan, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")


	; expectRef

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectRef(TestArmorRef, to, beGreaterThan, TestArmorRef)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectRef(TestArmorRef, to, beGreaterThanOrEqualTo, TestArmorRef)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectRef(TestArmorRef, to, beLessThan, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectRef(TestArmorRef, to, beLessThanOrEqualTo, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")


	; expectInt
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectInt(5, to, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectInt(5, notTo, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")


	; expectFloat
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectFloat(3.4565, to, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")


	; expectBool
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(true, to, beGreaterThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(true, to, beGreaterThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(false, to, beLessThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(false, to, beLessThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(false, to, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(false, notTo, beLessThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")


	; expectString
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", to, beGreaterThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", to, beGreaterThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", to, beLessThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", to, beLessThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", to, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", notTo, beLessThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, to, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, to, beEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	return true
endFunction

bool function case_expect_form()

endFunction

bool function case_expect_ref()

endFunction

bool function case_expect_int()

endFunction

bool function case_expect_float()

endFunction

bool function case_expect_bool()

endFunction

bool function case_expect_string()

endFunction


bool function case_testcase_BeforeAfterEach()
	mockLilacTest.RunTests()

	; There are 2 test cases, but beforeEach and afterEach 
	; are expected to run 3 times.
	expectInt(mockLilacTest.mockBeforeEachCallCount, to, beEqualTo, 3)
	expectInt(mockLilacTest.mockAfterEachCallCount, to, beEqualTo, 3)
	return true
endFunction

bool function case_testcase_describe()
	mockLilacTest.RunTests()
	expectInt(mockLilacTest.mockItCallCount, to, beEqualTo, 2)
	return true
endFunction