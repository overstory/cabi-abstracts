xquery version "1.0-ml";

module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "../src/assertions.xqy";

import module namespace xqysp = "com.blakeley.xqysp" at "../../appserver-root/xquery/handlers/lib/xqysp.xqy";


declare %test:case function hello-world()
{
	assert:true(true())
};

declare %test:case function should-return-dog-and-cat-ast()
{
	assert:equal (xqysp:parse ("dog and cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};

declare %test:case function should-return-dog-AND-cat-ast()
{
	assert:equal (xqysp:parse ("dog AND cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};

declare %test:case function should-return-dog-PLUS-cat-ast()
{
	assert:equal (xqysp:parse ("dog +cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};


declare %test:case function should-return-dog-or-cat-ast()
{
	assert:equal (xqysp:parse ("dog or cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="or" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};

declare %test:case function should-return-dog-OR-cat-ast()
{
	assert:equal (xqysp:parse ("dog OR cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="or" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};

declare %test:case function should-return-dog-PIPE-cat-ast()
{
	assert:equal (xqysp:parse ("dog | cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="or" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};

declare %test:case function should-return-dog-near-cat-ast()
{
	assert:equal (xqysp:parse ("dog near cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="near" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};

declare %test:case function should-return-dog-NEAR-cat-ast()
{
	assert:equal (xqysp:parse ("dog NEAR cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="near" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};

declare %test:case function should-return-dog-onear-cat-ast()
{
	assert:equal (xqysp:parse ("dog onear cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="onear" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};

declare %test:case function should-return-dog-ONEAR-cat-ast()
{
	assert:equal (xqysp:parse ("dog ONEAR cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="onear" type="infix">
				<literal>dog</literal>
				<literal>cat</literal>
			</expression>
		</root>)
};



declare %test:case function should-return-phrased-ast()
{
	assert:equal (xqysp:parse ('"dog and cat"'),
		<root xmlns="com.blakeley.xqysp">
			<literal>dog and cat</literal>
		</root>)
};

(: FixMe: Does XQYSP do escaped quotes?
declare %test:case function should-return-escaped-quotes-phrased-ast()
{
	assert:equal (xqysp:parse ('"dog \"and\" cat"'),
		<root xmlns="com.blakeley.xqysp">
			<literal>dog "and" cat</literal>
		</root>)
};
 :)

declare %test:case function should-return-phrased-with-special-chars-ast()
{
	assert:equal (xqysp:parse ('"foo:dog and bar:cat"'),
		<root xmlns="com.blakeley.xqysp">
			<literal>foo:dog and bar:cat</literal>
		</root>)
};

declare %test:case function should-return-not-cat-ast()
{
	assert:equal (xqysp:parse ("dog and not cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<literal>dog</literal>
				<expression type="prefix" op="not">
					<literal>cat</literal>
				</expression>
			</expression>
		</root>)
};

declare %test:case function should-return-NOT-cat-ast()
{
	assert:equal (xqysp:parse ("dog AND NOT cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<literal>dog</literal>
				<expression type="prefix" op="not">
					<literal>cat</literal>
				</expression>
			</expression>
		</root>)
};

declare %test:case function should-return-MINUS-cat-ast()
{
	assert:equal (xqysp:parse ("dog AND -cat"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<literal>dog</literal>
				<expression type="prefix" op="not">
					<literal>cat</literal>
				</expression>
			</expression>
		</root>)
};

declare %test:case function should-return-parenthesized-lowercase-ast()
{
	assert:equal (xqysp:parse ("dog and (cat or bird)"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<literal>dog</literal>
				<expression op="or" type="infix">
					<literal>cat</literal>
					<literal>bird</literal>
				</expression>
			</expression>
		</root>)
};

declare %test:case function should-return-parenthesized-uppercase-ast()
{
	assert:equal (xqysp:parse ("dog AND (cat OR bird)"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<literal>dog</literal>
				<expression op="or" type="infix">
					<literal>cat</literal>
					<literal>bird</literal>
				</expression>
			</expression>
		</root>)
};

declare %test:case function should-return-fielded-ast()
{
	assert:equal (xqysp:parse ("mammal:dog and (cat or avian:bird)"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<field name="mammal" op=":"><literal>dog</literal></field>
				<expression op="or" type="infix">
					<literal>cat</literal>
					<field name="avian" op=":"><literal>bird</literal></field>
				</expression>
			</expression>
		</root>)
};

declare %test:case function should-return-negated-fielded-ast()
{
	assert:equal (xqysp:parse ("mammal:dog and (cat or -avian:bird)"),
		<root xmlns="com.blakeley.xqysp">
			<expression op="and" type="infix">
				<field name="mammal" op=":"><literal>dog</literal></field>
				<expression op="or" type="infix">
					<literal>cat</literal>
					<expression op="not" type="prefix">
						<field name="avian" op=":"><literal>bird</literal></field>
					</expression>
				</expression>
			</expression>
		</root>)
};


