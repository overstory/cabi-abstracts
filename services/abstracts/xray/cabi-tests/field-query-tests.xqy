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

(: Additional Title Info :)
declare %test:case function test-additional-title-info-queries()
{
	assert:equal (qe:parse ('at: "fungus"'),
		cts:element-word-query ($qe:additional-title-info-qname, "fungus")
	)
	,
	assert:equal (qe:parse ('additional-title-data: "fungus"'),
		cts:element-word-query ($qe:additional-title-info-qname, "fungus")
	)
	,
	assert:equal (qe:parse ('additional-title-info: "fungus"'),
		cts:element-word-query ($qe:additional-title-info-qname, "fungus")
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
	assert:equal (qe:parse ('pa: 23432345'),
		cts:element-value-query ($qe:pan-qname, "23432345")
	)
	,
	assert:equal (qe:parse ('pan: 23432345'),
		cts:element-value-query ($qe:pan-qname, "23432345")
	)
};

(: ISSN :)
declare %test:case function test-ISSN-queries()
{
	assert:equal (qe:parse ('sn: 2343-2345'),
		cts:element-value-query ($qe:issn-qname, "2343-2345")
	)
	,
	assert:equal (qe:parse ('issn: 2343-2345'),
		cts:element-value-query ($qe:issn-qname, "2343-2345")
	)
};

(: ISBN :)
declare %test:case function test-ISBN-queries()
{
	assert:equal (qe:parse ('bn: 0-14-020652-3'),
		cts:element-value-query ($qe:isbn-qname, "0-14-020652-3")
	)
	,
	assert:equal (qe:parse ('isbn: 0-14-020652-3'),
		cts:element-value-query ($qe:isbn-qname, "0-14-020652-3")
	)
};

(: DOI :)
declare %test:case function test-DOI-queries()
{
	assert:equal (qe:parse ('oi: 10.1016/j.iheduc.2008.03.001'),
		cts:element-value-query ($qe:doi-qname, "10.1016/j.iheduc.2008.03.001")
	)
	,
	assert:equal (qe:parse ('doi: 10.1016/j.iheduc.2008.03.001'),
		cts:element-value-query ($qe:doi-qname, "10.1016/j.iheduc.2008.03.001")
	)
};

(: Author Affiliation :)
declare %test:case function test-affiliation-queries()
{
	assert:equal (qe:parse ('aa: cambridge'),
		cts:element-word-query ($qe:affiliation-qname, "cambridge")
	)
	,
	assert:equal (qe:parse ('affiliation: cambridge'),
		cts:element-word-query ($qe:affiliation-qname, "cambridge")
	)
	,
	assert:equal (qe:parse ('author-affiliation: cambridge'),
		cts:element-word-query ($qe:affiliation-qname, "cambridge")
	)
};

(: Email :)
declare %test:case function test-email-queries()
{
	assert:equal (qe:parse ('em: elmer.fudd@looneytunes.com'),
		cts:element-value-query ($qe:email-qname, "elmer.fudd@looneytunes.com")
	)
	,
	assert:equal (qe:parse ('email: elmer.fudd@looneytunes.com'),
		cts:element-value-query ($qe:email-qname, "elmer.fudd@looneytunes.com")
	)
};

(: Item Type :)
declare %test:case function test-item-type-queries()
{
	assert:equal (qe:parse ('it: "Journal article"'),
		cts:element-value-query ($qe:item-type-qname, "Journal article")
	)
	,
	assert:equal (qe:parse ('item-type: "Journal article"'),
		cts:element-value-query ($qe:item-type-qname, "Journal article")
	)
};

(: Language :)
declare %test:case function test-language-queries()
{
	assert:equal (qe:parse ('la: french'),
		cts:element-word-query ($qe:language-qname, "french")
	)
	,
	assert:equal (qe:parse ('lang: french'),
		cts:element-word-query ($qe:language-qname, "french")
	)
	,
	assert:equal (qe:parse ('language: french'),
		cts:element-word-query ($qe:language-qname, "french")
	)
};

(: Language of Summary :)
declare %test:case function test-language-of-summary-queries()
{
	assert:equal (qe:parse ('ls: italian'),
		cts:element-word-query ($qe:language-summary-qname, "italian")
	)
	,
	assert:equal (qe:parse ('summary-language: italian'),
		cts:element-word-query ($qe:language-summary-qname, "italian")
	)
	,
	assert:equal (qe:parse ('language-summary: italian'),
		cts:element-word-query ($qe:language-summary-qname, "italian")
	)
	,
	assert:equal (qe:parse ('language-of-summary: italian'),
		cts:element-word-query ($qe:language-summary-qname, "italian")
	)
};

(: Supplementary Information :)
declare %test:case function test-supplementary-information-queries()
{
	assert:equal (qe:parse ('ms: "panda bears are cute"'),
		cts:element-word-query ($qe:supplementary-information-qname, "panda bears are cute")
	)
	,
	assert:equal (qe:parse ('supplementary-information: "panda bears are cute"'),
		cts:element-word-query ($qe:supplementary-information-qname, "panda bears are cute")
	)
	,
	assert:equal (qe:parse ('supplementary-info: "panda bears are cute"'),
		cts:element-word-query ($qe:supplementary-information-qname, "panda bears are cute")
	)
};

(: Country of Publication :)
declare %test:case function test-country-of-publication-queries()
{
	assert:equal (qe:parse ('cp: namibia'),
		cts:element-word-query ($qe:country-qname, "namibia")
	)
	,
	assert:equal (qe:parse ('country-pub: namibia'),
		cts:element-word-query ($qe:country-qname, "namibia")
	)
	,
	assert:equal (qe:parse ('pub-country: namibia'),
		cts:element-word-query ($qe:country-qname, "namibia")
	)
	,
	assert:equal (qe:parse ('country-publication: namibia'),
		cts:element-word-query ($qe:country-qname, "namibia")
	)
	,
	assert:equal (qe:parse ('country-of-publication: namibia'),
		cts:element-word-query ($qe:country-qname, "namibia")
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


