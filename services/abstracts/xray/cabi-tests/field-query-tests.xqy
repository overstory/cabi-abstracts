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
	assert:equal (qe:parse ('do: "fuzzy bunnies"'),
		cts:element-word-query ($qe:document-title-qname, "fuzzy bunnies")
	)
	,
	assert:equal (qe:parse ('doc-title: "fuzzy bunnies"'),
		cts:element-word-query ($qe:document-title-qname, "fuzzy bunnies")
	)
	,
	assert:equal (qe:parse ('document-title: "fuzzy bunnies"'),
		cts:element-word-query ($qe:document-title-qname, "fuzzy bunnies")
	)
	,
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

(: Location of Publisher :)
declare %test:case function test-location-of-publisher-queries()
{
	assert:equal (qe:parse ('lp: paris'),
		cts:element-word-query ($qe:city-qname, "paris")
	)
	,
	assert:equal (qe:parse ('pub-location: paris'),
		cts:element-word-query ($qe:city-qname, "paris")
	)
	,
	assert:equal (qe:parse ('location-of-publisher: paris'),
		cts:element-word-query ($qe:city-qname, "paris")
	)
};

(: Issue :)
declare %test:case function test-issue-queries()
{
	assert:equal (qe:parse ('no: 146'),
		cts:element-value-query ($qe:issue-qname, "146")
	)
	,
	assert:equal (qe:parse ('issue: 146'),
		cts:element-value-query ($qe:issue-qname, "146")
	)
};

(: Volume :)
declare %test:case function test-volume-queries()
{
	assert:equal (qe:parse ('vl: 99'),
		cts:element-value-query ($qe:volume-qname, "99")
	)
	,
	assert:equal (qe:parse ('volume: 99'),
		cts:element-value-query ($qe:volume-qname, "99")
	)
};

(: URL :)
declare %test:case function test-url-queries()
{
	assert:equal (qe:parse ('ur: "http://google.com"'),
		cts:element-value-query ($qe:url-qname, "http://google.com")
	)
	,
	assert:equal (qe:parse ('url: "http://google.com"'),
		cts:element-value-query ($qe:url-qname, "http://google.com")
	)
};

(: Year :)
declare %test:case function test-year-queries()
{
	assert:equal (qe:parse ('yr: 1927'),
		cts:element-value-query ($qe:year-qname, "1927")
	)
	,
	assert:equal (qe:parse ('year: 1927'),
		cts:element-value-query ($qe:year-qname, "1927")
	)
};


(: Number of References :)
declare %test:case function test-num-refs-queries()
{
	assert:equal (qe:parse ('re: 12'),
		cts:element-value-query ($qe:number-of-references-qname, "12")
	)
	,
	assert:equal (qe:parse ('num-refs: 12'),
		cts:element-value-query ($qe:number-of-references-qname, "12")
	)
	,
	assert:equal (qe:parse ('number-of-references: 12'),
		cts:element-value-query ($qe:number-of-references-qname, "12")
	)
};

(: Page Range :)
declare %test:case function test-page-range-queries()
{
	assert:equal (qe:parse ('pp: 42'),
		cts:element-word-query ($qe:page-range-qname, "42")
	)
	,
	assert:equal (qe:parse ('pages: 42'),
		cts:element-word-query ($qe:page-range-qname, "42")
	)
	,
	assert:equal (qe:parse ('page-range: 42'),
		cts:element-word-query ($qe:page-range-qname, "42")
	)
};

(: Descriptors :)
declare %test:case function test-de-queries()
{
	assert:equal (qe:parse ('de: wheat'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "wheat", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "de", "exact")
		))
	)
	,
	assert:equal (qe:parse ('descriptor: wheat'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "wheat", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "de", "exact")
		))
	)
};

(: Organism Descriptors :)
declare %test:case function test-od-queries()
{
	assert:equal (qe:parse ('od: kracken'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "kracken", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "od", "exact")
		))
	)
	,
	assert:equal (qe:parse ('organism-descriptor: kracken'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "kracken", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "od", "exact")
		))
	)
};

(: Geographic Location :)
declare %test:case function test-gl-queries()
{
	assert:equal (qe:parse ('gl: arctic'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "arctic", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "gl", "exact")
		))
	)
	,
	assert:equal (qe:parse ('geo-loc: arctic'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "arctic", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "gl", "exact")
		))
	)
	,
	assert:equal (qe:parse ('geo-location: arctic'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "arctic", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "gl", "exact")
		))
	)
	,
	assert:equal (qe:parse ('geographic-location: arctic'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "arctic", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "gl", "exact")
		))
	)
};

(: Identifier :)
declare %test:case function test-id-queries()
{
	assert:equal (qe:parse ('id: xyzzy'),
		cts:and-query ((
			cts:element-value-query ($qe:alternate-term-qname, "xyzzy", "exact"),
			cts:element-attribute-value-query ($qe:alternate-term-qname, $qe:vocab-attr-qname, "id", "exact")
		))
	)
	,
	assert:equal (qe:parse ('identifier: xyzzy'),
		cts:and-query ((
			cts:element-value-query ($qe:alternate-term-qname, "xyzzy", "exact"),
			cts:element-attribute-value-query ($qe:alternate-term-qname, $qe:vocab-attr-qname, "id", "exact")
		))
	)
};

(: Broader :)
declare %test:case function test-up-queries()
{
	assert:equal (qe:parse ('up: mammal'),
		cts:and-query ((
			cts:element-value-query ($qe:ancestor-term-qname, "mammal", "exact"),
			cts:element-attribute-value-query ($qe:ancestor-term-qname, $qe:vocab-attr-qname, "up", "exact")
		))
	)
	,
	assert:equal (qe:parse ('broader: mammal'),
		cts:and-query ((
			cts:element-value-query ($qe:ancestor-term-qname, "mammal", "exact"),
			cts:element-attribute-value-query ($qe:ancestor-term-qname, $qe:vocab-attr-qname, "up", "exact")
		))
	)
	,
	assert:equal (qe:parse ('wider: mammal'),
		cts:and-query ((
			cts:element-value-query ($qe:ancestor-term-qname, "mammal", "exact"),
			cts:element-attribute-value-query ($qe:ancestor-term-qname, $qe:vocab-attr-qname, "up", "exact")
		))
	)
};

(: CAS Registry Numbers :)
declare %test:case function test-registry-queries()
{
	assert:equal (qe:parse ('ry: 62-50-0'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "62-50-0", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "ry", "exact")
		))
	)
	,
	assert:equal (qe:parse ('registry: 62-50-0'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "62-50-0", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "ry", "exact")
		))
	)
	,
	assert:equal (qe:parse ('cas-registry: 62-50-0'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "62-50-0", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "ry", "exact")
		))
	)
	,
	assert:equal (qe:parse ('cas: 62-50-0'),
		cts:and-query ((
			cts:element-value-query ($qe:preferred-term-qname, "62-50-0", "exact"),
			cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "ry", "exact")
		))
	)
};

(: CABI Code :)
declare %test:case function test-cabi-code-queries()
{
	assert:equal (qe:parse ('cc: fish'),
		cts:and-query ((
			cts:element-value-query ($qe:term-qname, "fish", "exact"),
			cts:element-attribute-value-query ($qe:term-qname, $qe:vocab-attr-qname, "cc", "exact")
		))
	)
	,
	assert:equal (qe:parse ('cabi-code: fish'),
		cts:and-query ((
			cts:element-value-query ($qe:term-qname, "fish", "exact"),
			cts:element-attribute-value-query ($qe:term-qname, $qe:vocab-attr-qname, "cc", "exact")
		))
	)
	,
	assert:equal (qe:parse ('cabicode: fish'),
		cts:and-query ((
			cts:element-value-query ($qe:term-qname, "fish", "exact"),
			cts:element-attribute-value-query ($qe:term-qname, $qe:vocab-attr-qname, "cc", "exact")
		))
	)
};

(: CABI Subject :)
declare %test:case function test-cabi-subject-queries()
{
	assert:equal (qe:parse ('sc: bugs'),
		cts:and-query ((
			cts:element-value-query ($qe:term-qname, "bugs", "exact"),
			cts:element-attribute-value-query ($qe:term-qname, $qe:vocab-attr-qname, "sc", "exact")
		))
	)
	,
	assert:equal (qe:parse ('subject-code: bugs'),
		cts:and-query ((
			cts:element-value-query ($qe:term-qname, "bugs", "exact"),
			cts:element-attribute-value-query ($qe:term-qname, $qe:vocab-attr-qname, "sc", "exact")
		))
	)
	,
	assert:equal (qe:parse ('cabi-subject: bugs'),
		cts:and-query ((
			cts:element-value-query ($qe:term-qname, "bugs", "exact"),
			cts:element-attribute-value-query ($qe:term-qname, $qe:vocab-attr-qname, "sc", "exact")
		))
	)
	,
	assert:equal (qe:parse ('cabisubject: bugs'),
		cts:and-query ((
			cts:element-value-query ($qe:term-qname, "bugs", "exact"),
			cts:element-attribute-value-query ($qe:term-qname, $qe:vocab-attr-qname, "sc", "exact")
		))
	)
};

(: Subject :)
declare %test:case function test-subject-queries()
{
	assert:equal (qe:parse ('subject: pest'),
		cts:or-query ((
			cts:and-query ((
				cts:element-value-query ($qe:preferred-term-qname, "pest", "exact"),
				cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "de", "exact")
			)),
			cts:and-query ((
				cts:element-value-query ($qe:preferred-term-qname, "pest", "exact"),
				cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "od", "exact")
			)),
			cts:and-query ((
				cts:element-value-query ($qe:preferred-term-qname, "pest", "exact"),
				cts:element-attribute-value-query ($qe:preferred-term-qname, $qe:vocab-attr-qname, "gl", "exact")
			)),
			cts:and-query ((
				cts:element-value-query ($qe:alternate-term-qname, "pest", "exact"),
				cts:element-attribute-value-query ($qe:alternate-term-qname, $qe:vocab-attr-qname, "id", "exact")
			)),
			cts:and-query ((
				cts:element-value-query ($qe:ancestor-term-qname, "pest", "exact"),
				cts:element-attribute-value-query ($qe:ancestor-term-qname, $qe:vocab-attr-qname, "up", "exact")
			))
		))
	)
};

