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

declare %test:case function should-return-dog-implicit-and-cat-query()
{
	assert:equal (qe:parse ("dog cat"),
		cts:and-query ((
			cts:word-query ("dog"), cts:word-query ("cat")
		))
	)
};
