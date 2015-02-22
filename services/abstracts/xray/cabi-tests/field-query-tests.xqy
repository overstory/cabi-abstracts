xquery version "1.0-ml";

module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "../src/assertions.xqy";

import module namespace qe = "com.blakeley.xqysp.query-eval" at "../../appserver-root/xquery/handlers/lib/query-eval.xqy";

declare namespace cts = "http://marklogic.com/cts";


(: Publisher :)
declare %test:case function test-publisher-queries()
{
	assert:equal (qe:parse ("pb: wiley"),
		cts:element-word-query ($qe:publisher-qname, "wiley")
	)
	,
	assert:equal (qe:parse ("PB: wiley"),
		cts:element-word-query ($qe:publisher-qname, "wiley")
	)
	,
	assert:equal (qe:parse ("pub: wiley"),
		cts:element-word-query ($qe:publisher-qname, "wiley")
	)
	,
	assert:equal (qe:parse ("publisher: wiley"),
		cts:element-word-query ($qe:publisher-qname, "wiley")
	)
};

(: Title :)
declare %test:case function test-title-queries()
{
	assert:equal (qe:parse ('et: "fuzzy bunnies"'),
		cts:element-word-query ($qe:item-title-qname, "fuzzy bunnies")
	)
	,
	assert:equal (qe:parse ('item-title: "fuzzy bunnies"'),
		cts:element-word-query ($qe:item-title-qname, "fuzzy bunnies")
	)
	,
	assert:equal (qe:parse ('ft: "fuzzy bunnies"'),
		cts:element-word-query ($qe:non-english-title-qname, "fuzzy bunnies")
	)
	,
	assert:equal (qe:parse ('non-english-title: "fuzzy bunnies"'),
		cts:element-word-query ($qe:non-english-title-qname, "fuzzy bunnies")
	)
	,
	assert:equal (qe:parse ('net: "fuzzy bunnies"'),
		cts:element-word-query ($qe:non-english-title-qname, "fuzzy bunnies")
	)
	,
	assert:equal (qe:parse ('title: "fuzzy bunnies"'),
		cts:element-word-query (($qe:item-title-qname, $qe:non-english-title-qname), "fuzzy bunnies")
	)
	,
	assert:equal (qe:parse ('Title: "fuzzy bunnies"'),
		cts:element-word-query (($qe:item-title-qname, $qe:non-english-title-qname), "fuzzy bunnies")
	)
};

(: Conference Title :)
declare %test:case function test-conference-title-queries()
{
	assert:equal (qe:parse ('ct: "spiders"'),
		cts:element-word-query ($qe:conference-title-qname, "spiders")
	)
	,
	assert:equal (qe:parse ('conference-title: "spiders"'),
		cts:element-word-query ($qe:conference-title-qname, "spiders")
	)
};

(: Author :)
declare %test:case function test-author-queries()
{
	assert:equal (qe:parse ('au: "agatha christie"'),
		cts:element-word-query ($qe:author-qname, "agatha christie")
	)
	,
	assert:equal (qe:parse ('av: "agatha christie"'),
		cts:element-word-query ($qe:author-variant-qname, "agatha christie")
	)
	,
	assert:equal (qe:parse ('ed: "agatha christie"'),
		cts:element-word-query ($qe:editor-qname, "agatha christie")
	)
	,
	assert:equal (qe:parse ('editor: "agatha christie"'),
		cts:element-word-query ($qe:editor-qname, "agatha christie")
	)
	,
	assert:equal (qe:parse ('ad: "agatha christie"'),
		cts:element-word-query ($qe:additional-author-qname, "agatha christie")
	)
	,
	assert:equal (qe:parse ('ca: "agatha christie"'),
		cts:element-word-query ($qe:corporate-author-qname, "agatha christie")
	)
	,
	assert:equal (qe:parse ('author: "agatha christie"'),
		cts:element-word-query (($qe:author-qname, $qe:author-variant-qname, $qe:editor-qname, $qe:additional-author-qname, $qe:corporate-author-qname), "agatha christie")
	)
};

(: Abstract :)
declare %test:case function test-abstract-queries()
{
	assert:equal (qe:parse ('ab: "flesh eating zombies"'),
		cts:element-word-query ($qe:abstract-text-qname, "flesh eating zombies")
	)
	,
	assert:equal (qe:parse ('abstract: "flesh eating zombies"'),
		cts:element-word-query ($qe:abstract-text-qname, "flesh eating zombies")
	)
};

(: PA :)
declare %test:case function test-PAN-queries()
{
	assert:equal (qe:parse ('pa: "23432345"'),
		cts:element-value-query ($qe:pan-qname, "23432345")
	)
	,
	assert:equal (qe:parse ('pan: "23432345"'),
		cts:element-value-query ($qe:pan-qname, "23432345")
	)
};

(: ISSN :)
declare %test:case function test-ISSN-queries()
{
	assert:equal (qe:parse ('sn: "2343-2345"'),
		cts:element-value-query ($qe:issn-qname, "2343-2345")
	)
	,
	assert:equal (qe:parse ('issn: "2343-2345"'),
		cts:element-value-query ($qe:issn-qname, "2343-2345")
	)
};

(: ISBN :)
declare %test:case function test-ISBN-queries()
{
	assert:equal (qe:parse ('bn: "0-14-020652-3"'),
		cts:element-value-query ($qe:isbn-qname, "0-14-020652-3")
	)
	,
	assert:equal (qe:parse ('isbn: "0-14-020652-3"'),
		cts:element-value-query ($qe:isbn-qname, "0-14-020652-3")
	)
};

(: DOI :)
declare %test:case function test-DOI-queries()
{
	assert:equal (qe:parse ('oi: "10.1016/j.iheduc.2008.03.001"'),
		cts:element-value-query ($qe:doi-qname, "10.1016/j.iheduc.2008.03.001")
	)
	,
	assert:equal (qe:parse ('doi: "10.1016/j.iheduc.2008.03.001"'),
		cts:element-value-query ($qe:doi-qname, "10.1016/j.iheduc.2008.03.001")
	)
};

(: Descriptors :)
(:
declare %test:case function test-descriptor-queries()
{
	assert:equal (qe:parse ('ab: "flesh eating zombies"'),
		cts:element-word-query ($qe:abstract-text-qname, "flesh eating zombies")
	)
	,
	assert:equal (qe:parse ('abstract: "flesh eating zombies"'),
		cts:element-word-query ($qe:abstract-text-qname, "flesh eating zombies")
	)
};
 :)


