xquery version "1.0-ml";

module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "../src/assertions.xqy";

import module namespace qe = "com.blakeley.xqysp.query-eval" at "../../appserver-root/xquery/handlers/lib/query-eval.xqy";

declare namespace cts = "http://marklogic.com/cts";

declare %test:case function hello-world()
{
	assert:true(true())
};

declare %test:case function should-return-dog-and-cat-query()
{
	assert:equal (qe:parse ("dog and cat"),
		cts:and-query ((
			cts:word-query ("dog"), cts:word-query ("cat")
		))
	)
};

declare %test:case function should-return-dog-PLUS-cat-query()
{
	assert:equal (qe:parse ("dog +cat"),
		cts:and-query ((
			cts:word-query ("dog"), cts:word-query ("cat")
		))
	)
};

declare %test:case function should-return-dog-implicit-and-cat-query()
{
	assert:equal (qe:parse ("dog cat"),
		cts:and-query ((
			cts:word-query ("dog"), cts:word-query ("cat")
		))
	)
};

declare %test:case function should-return-dog-MINUS-cat-query()
{
	assert:equal (qe:parse ("dog -cat"),
		cts:and-query ((
			cts:word-query ("dog"),
			cts:not-query (cts:word-query ("cat"))
		))
	)
};

declare %test:case function should-return-MINUS-pub-wiley-query()
{
	assert:equal (qe:parse ("-pub: Wiley"),
		cts:not-query (cts:element-word-query ($qe:publisher-qname, "Wiley"))
	)
};

declare %test:case function should-return-implicit-anded-phrase-query()
{
	assert:equal (qe:parse ('"cattle breeds" "milk production"'),
		cts:and-query ((
			cts:word-query ("cattle breeds"), cts:word-query ("milk production")
		))
	)
};

declare %test:case function should-grouped-and-or-not-query()
{
	assert:equal (qe:parse ('(housing AND (cattle OR sheep)) not diseases'),
		cts:and-query ((
			cts:word-query ("housing"),
			cts:or-query ((
				cts:word-query ("cattle"),
				cts:word-query ("sheep")
			)),
			cts:not-query (cts:word-query ("diseases"))
		))
	)
};

declare %test:case function should-return-range-query-equals-value()
{
	assert:equal (qe:parse ("yr:[2000]"),
		cts:and-query ((
			cts:element-range-query (fn:QName("http://namespaces.cabi.org/namespaces/cabi","cabi:year"), "=", xs:untypedAtomic("2000"), (), 1), ()
		))
	)
};

declare %test:case function should-return-range-query-inclusive-start-end-values()
{
	assert:equal (qe:parse ("yr:[2000 to 2014]"),
		cts:and-query ((
			cts:element-range-query (fn:QName("http://namespaces.cabi.org/namespaces/cabi","cabi:year"), ">=", xs:untypedAtomic("2000"), (), 1), 
			cts:element-range-query (fn:QName("http://namespaces.cabi.org/namespaces/cabi","cabi:year"), "<=", xs:untypedAtomic("2014"), (), 1)
			)
		)
	)
};

declare %test:case function should-return-range-query-exclusive-start-end-values()
{
	assert:equal (qe:parse ("ex:{20001231231 to 201123131321}"),
		cts:and-query ((
			cts:element-range-query (fn:QName("http://namespaces.cabi.org/namespaces/cabi","cabi:ex"), ">", xs:untypedAtomic("20001231231"), (), 1), 
			cts:element-range-query (fn:QName("http://namespaces.cabi.org/namespaces/cabi","cabi:ex"), "<", xs:untypedAtomic("201123131321"), (), 1)
			)
		)
	)
};

