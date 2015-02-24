xquery version "1.0-ml";
(:
 : query-eval.xqy
 :
 : Copyright (c) 2011 Michael Blakeley. All Rights Reserved.
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 : http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :
 : The use of the Apache License does not indicate that this project is
 : affiliated with the Apache Software Foundation.
 :
 :)
module namespace qe="com.blakeley.xqysp.query-eval";

import module namespace p = "com.blakeley.xqysp" at "xqysp.xqy";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

declare namespace cabi = "http://namespaces.cabi.org/namespaces/cabi";
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";

(: ------------------------------- :)

declare variable $publisher-qname := xs:QName ("cabi:publisher");
declare variable $document-title-qname := xs:QName ("cabi:document-title");
declare variable $item-title-qname := xs:QName ("cabi:item-title");
declare variable $non-english-title-qname := xs:QName ("cabi:non-english-title");
declare variable $additional-title-info-qname := xs:QName ("cabi:additional-title-info");
declare variable $author-qname := xs:QName ("cabi:author");
declare variable $author-variant-qname := xs:QName ("cabi:author-variant");
declare variable $editor-qname := xs:QName ("cabi:editor");
declare variable $additional-author-qname := xs:QName ("cabi:additional-author");
declare variable $corporate-author-qname := xs:QName ("cabi:corporate-author");
declare variable $abstract-text-qname := xs:QName ("cabi:abstract-text");
declare variable $conference-title-qname := xs:QName ("cabi:conference-title");
declare variable $pan-qname := xs:QName ("cabi:pan");
declare variable $issn-qname := xs:QName ("cabi:issn");
declare variable $isbn-qname := xs:QName ("cabi:isbn");
declare variable $doi-qname := xs:QName ("cabi:doi");
declare variable $affiliation-qname := xs:QName ("cabi:affiliation-qname");
declare variable $country-qname := xs:QName ("cabi:country");
declare variable $email-qname := xs:QName ("cabi:email");
declare variable $item-type-qname := xs:QName ("cabi:item-type");
declare variable $language-qname := xs:QName ("cabi:language");
declare variable $language-summary-qname := xs:QName ("cabi:language-summary");
declare variable $supplementary-information-qname := xs:QName ("cabi:supplementary-information");
declare variable $city-qname := xs:QName ("cabi:city");
declare variable $issue-qname := xs:QName ("cabi:issue");
declare variable $volume-qname := xs:QName ("cabi:volume");
declare variable $page-range-qname := xs:QName ("cabi:page-range");
declare variable $number-of-references-qname := xs:QName ("cabi:number-of-references");
declare variable $url-qname := xs:QName ("cabi:url");
declare variable $year-qname := xs:QName ("cabi:year");
declare variable $preferred-term-qname := xs:QName ("cabi:preferred-term");
declare variable $alternate-term-qname := xs:QName ("cabi:alternate-term");
declare variable $ancestor-term-qname := xs:QName ("cabi:ancestor-term");
declare variable $term-qname := xs:QName ("cabi:term");

declare variable $vocab-attr-qname := xs:QName ("vocab");

(: ------------------------------- :)

(: ToDo: Compound elements: affiliation, author, editor :)
(: ToDo: Look at iso country code on language element, also on country element :)
(: FixMe: LP (Location of Publisher <city>) needs remodeling :)
(: FixMe: number of references: Need to search attribute @orginal-content :)
(: FixMe: What about typed values (numeric, dates)? :)

(: Queries against QNames in this list will be generated as element value queries rather than as word queries :)
declare private variable $value-fields := (
	$url-qname, $pan-qname, $issn-qname, $isbn-qname, $doi-qname, $email-qname,
	$item-type-qname, $issue-qname, $volume-qname, $number-of-references-qname, $year-qname
);

declare private variable $field-mappings as map:map := map:map (
	<map:map xmlns:map="http://marklogic.com/xdmp/map">
		<map:entry key="pb"><map:value>{ $publisher-qname }</map:value></map:entry>
		<map:entry key="pub"><map:value>{ $publisher-qname }</map:value></map:entry>
		<map:entry key="publisher"><map:value>{ $publisher-qname }</map:value></map:entry>

		<map:entry key="do"><map:value>{ $document-title-qname }</map:value></map:entry>
		<map:entry key="doc-title"><map:value>{ $document-title-qname }</map:value></map:entry>
		<map:entry key="document-title"><map:value>{ $document-title-qname }</map:value></map:entry>
		<map:entry key="et"><map:value>{ $item-title-qname }</map:value></map:entry>
		<map:entry key="item-title"><map:value>{ $item-title-qname }</map:value></map:entry>
		<map:entry key="ft"><map:value>{ $non-english-title-qname }</map:value></map:entry>
		<map:entry key="net"><map:value>{ $non-english-title-qname }</map:value></map:entry>
		<map:entry key="non-english-title"><map:value>{ $non-english-title-qname }</map:value></map:entry>
		<map:entry key="title">
			<map:value>{ $item-title-qname }</map:value>
			<map:value>{ $non-english-title-qname }</map:value>
		</map:entry>

		<map:entry key="ct"><map:value>{ $conference-title-qname }</map:value></map:entry>
		<map:entry key="conference-title"><map:value>{ $conference-title-qname }</map:value></map:entry>

		<map:entry key="au"><map:value>{ $author-qname }</map:value></map:entry>
		<map:entry key="av"><map:value>{ $author-variant-qname }</map:value></map:entry>
		<map:entry key="ed"><map:value>{ $editor-qname }</map:value></map:entry>
		<map:entry key="editor"><map:value>{ $editor-qname }</map:value></map:entry>
		<map:entry key="ad"><map:value>{ $additional-author-qname }</map:value></map:entry>
		<map:entry key="ca"><map:value>{ $corporate-author-qname }</map:value></map:entry>
		<map:entry key="author">
			<map:value>{ $author-qname }</map:value>
			<map:value>{ $author-variant-qname }</map:value>
			<map:value>{ $editor-qname }</map:value>
			<map:value>{ $additional-author-qname }</map:value>
			<map:value>{ $corporate-author-qname }</map:value>
		</map:entry>

		<map:entry key="ab"><map:value>{ $abstract-text-qname }</map:value></map:entry>
		<map:entry key="abstract"><map:value>{ $abstract-text-qname }</map:value></map:entry>

		<map:entry key="pa"><map:value>{ $pan-qname }</map:value></map:entry>
		<map:entry key="pan"><map:value>{ $pan-qname }</map:value></map:entry>
		<map:entry key="sn"><map:value>{ $issn-qname }</map:value></map:entry>
		<map:entry key="issn"><map:value>{ $issn-qname }</map:value></map:entry>
		<map:entry key="bn"><map:value>{ $isbn-qname }</map:value></map:entry>
		<map:entry key="isbn"><map:value>{ $isbn-qname }</map:value></map:entry>
		<map:entry key="oi"><map:value>{ $doi-qname }</map:value></map:entry>
		<map:entry key="doi"><map:value>{ $doi-qname }</map:value></map:entry>

		<map:entry key="aa"><map:value>{ $affiliation-qname }</map:value></map:entry>
		<map:entry key="affiliation"><map:value>{ $affiliation-qname }</map:value></map:entry>
		<map:entry key="author-affiliation"><map:value>{ $affiliation-qname }</map:value></map:entry>

		<map:entry key="at"><map:value>{ $additional-title-info-qname }</map:value></map:entry>
		<map:entry key="additional-title-data"><map:value>{ $additional-title-info-qname }</map:value></map:entry>
		<map:entry key="additional-title-info"><map:value>{ $additional-title-info-qname }</map:value></map:entry>

		<map:entry key="cp"><map:value>{ $country-qname }</map:value></map:entry>
		<map:entry key="country-pub"><map:value>{ $country-qname }</map:value></map:entry>
		<map:entry key="pub-country"><map:value>{ $country-qname }</map:value></map:entry>
		<map:entry key="country-publication"><map:value>{ $country-qname }</map:value></map:entry>
		<map:entry key="country-of-publication"><map:value>{ $country-qname }</map:value></map:entry>

		<map:entry key="em"><map:value>{ $email-qname }</map:value></map:entry>
		<map:entry key="email"><map:value>{ $email-qname }</map:value></map:entry>

		<map:entry key="it"><map:value>{ $item-type-qname }</map:value></map:entry>
		<map:entry key="item-type"><map:value>{ $item-type-qname }</map:value></map:entry>

		<map:entry key="la"><map:value>{ $language-qname }</map:value></map:entry>
		<map:entry key="lang"><map:value>{ $language-qname }</map:value></map:entry>
		<map:entry key="language"><map:value>{ $language-qname }</map:value></map:entry>

		<map:entry key="ls"><map:value>{ $language-summary-qname }</map:value></map:entry>
		<map:entry key="language-summary"><map:value>{ $language-summary-qname }</map:value></map:entry>
		<map:entry key="summary-language"><map:value>{ $language-summary-qname }</map:value></map:entry>
		<map:entry key="language-of-summary"><map:value>{ $language-summary-qname }</map:value></map:entry>

		<map:entry key="ms"><map:value>{ $supplementary-information-qname }</map:value></map:entry>
		<map:entry key="supplementary-information"><map:value>{ $supplementary-information-qname }</map:value></map:entry>
		<map:entry key="supplementary-info"><map:value>{ $supplementary-information-qname }</map:value></map:entry>

		<map:entry key="lp"><map:value>{ $city-qname }</map:value></map:entry>
		<map:entry key="pub-location"><map:value>{ $city-qname }</map:value></map:entry>
		<map:entry key="location-of-publisher"><map:value>{ $city-qname }</map:value></map:entry>

		<map:entry key="no"><map:value>{ $issue-qname }</map:value></map:entry>
		<map:entry key="issue"><map:value>{ $issue-qname }</map:value></map:entry>

		<map:entry key="vl"><map:value>{ $volume-qname }</map:value></map:entry>
		<map:entry key="volume"><map:value>{ $volume-qname }</map:value></map:entry>

		<map:entry key="pp"><map:value>{ $page-range-qname }</map:value></map:entry>
		<map:entry key="pages"><map:value>{ $page-range-qname }</map:value></map:entry>
		<map:entry key="page-range"><map:value>{ $page-range-qname }</map:value></map:entry>

		<map:entry key="re"><map:value>{ $number-of-references-qname }</map:value></map:entry>
		<map:entry key="num-refs"><map:value>{ $number-of-references-qname }</map:value></map:entry>
		<map:entry key="number-of-references"><map:value>{ $number-of-references-qname }</map:value></map:entry>

		<map:entry key="ur"><map:value>{ $url-qname }</map:value></map:entry>
		<map:entry key="url"><map:value>{ $url-qname }</map:value></map:entry>

		<map:entry key="yr"><map:value>{ $year-qname }</map:value></map:entry>
		<map:entry key="year"><map:value>{ $year-qname }</map:value></map:entry>

		<!-- Mappings that use higher order functions are added programmatically because functions can't be atomized as an XML initializer  -->
	</map:map>
);

declare private function qe:load-query-function-enties (
) as empty-sequence()
{
	if (fn:empty (map:get ($field-mappings, "de")))
	then (
		map:put ($field-mappings, "de", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "de")),
		map:put ($field-mappings, "descriptor", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "de")),

		map:put ($field-mappings, "od", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "od")),
		map:put ($field-mappings, "organism-descriptor", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "od")),

		map:put ($field-mappings, "gl", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "gl")),
		map:put ($field-mappings, "geo-loc", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "gl")),
		map:put ($field-mappings, "geo-location", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "gl")),
		map:put ($field-mappings, "geographic-location", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "gl")),

		map:put ($field-mappings, "id", qe:subject-code-query(?, ?, $alternate-term-qname, $vocab-attr-qname, "id")),
		map:put ($field-mappings, "identifier", qe:subject-code-query(?, ?, $alternate-term-qname, $vocab-attr-qname, "id")),

		map:put ($field-mappings, "up", qe:subject-code-query(?, ?, $ancestor-term-qname, $vocab-attr-qname, "up")),
		map:put ($field-mappings, "wider", qe:subject-code-query(?, ?, $ancestor-term-qname, $vocab-attr-qname, "up")),
		map:put ($field-mappings, "broader", qe:subject-code-query(?, ?, $ancestor-term-qname, $vocab-attr-qname, "up")),

		map:put ($field-mappings, "subject",
			(
				qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "de"),
				qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "od"),
				qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "gl"),
				qe:subject-code-query(?, ?, $alternate-term-qname, $vocab-attr-qname, "id"),
				qe:subject-code-query(?, ?, $ancestor-term-qname, $vocab-attr-qname, "up")
			)
		),

		map:put ($field-mappings, "ry", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "ry")),
		map:put ($field-mappings, "registry", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "ry")),
		map:put ($field-mappings, "cas-registry", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "ry")),
		map:put ($field-mappings, "cas", qe:subject-code-query(?, ?, $preferred-term-qname, $vocab-attr-qname, "ry")),

		map:put ($field-mappings, "cc", qe:subject-code-query(?, ?, $term-qname, $vocab-attr-qname, "cc")),
		map:put ($field-mappings, "cabi-code", qe:subject-code-query(?, ?, $term-qname, $vocab-attr-qname, "cc")),
		map:put ($field-mappings, "cabicode", qe:subject-code-query(?, ?, $term-qname, $vocab-attr-qname, "cc")),

		map:put ($field-mappings, "sc", qe:subject-code-query(?, ?, $term-qname, $vocab-attr-qname, "sc")),
		map:put ($field-mappings, "cabi-subject", qe:subject-code-query(?, ?, $term-qname, $vocab-attr-qname, "sc")),
		map:put ($field-mappings, "cabisubject", qe:subject-code-query(?, ?, $term-qname, $vocab-attr-qname, "sc")),
		map:put ($field-mappings, "subject-code", qe:subject-code-query(?, ?, $term-qname, $vocab-attr-qname, "sc"))
	) else ()
};


declare private function qe:subject-code-query (
	$op as xs:string,
	$terms as element()*,
	$element-qname as xs:QName,
	$attribute-qname as xs:QName,
	$attribute-value as xs:string
) as cts:query
{
	cts:and-query ((
		cts:element-value-query ($element-qname, $terms, "exact"),
		cts:element-attribute-value-query ($element-qname, $attribute-qname, $attribute-value, "exact")
	))
};

(: ------------------------------- :)

declare private function qe:lookup-name (
	$name as xs:string
) as item()+
{
	let $_ := qe:load-query-function-enties()
	let $value := map:get ($field-mappings, fn:lower-case ($name))

	return
	if (fn:empty ($value))
	then xs:QName ("cabi:" || $name)
	else $value
};

(: ------------------------------- :)

declare private function qe:query-from-qname (
	$qnames as xs:QName+,
	$op as xs:string?,
	$list as element()*
) as cts:query?
{
	(: This function leaves many problems unresolved.
	: What if $list contains sub-expressions from nested groups?
	: What if $list contains non-string values for range queries?
	: What if a range-query needs a special collation?
	: Handle these corner-cases if you need them.
	:)

	if (empty ($list))
	then cts:element-query ($qnames, cts:and-query (()))
	else
		if ($op = ('>', '>=', '<', '<='))
		then cts:element-range-query ($qnames, $op, $list)
		else
			if (($op eq '=') or ($value-fields = $qnames))
			then cts:element-value-query ($qnames, $list)
			else cts:element-word-query ($qnames, $list)
};

declare private function qe:field (
	$name as xs:string,
	$op as xs:string?,
	$list as element()*
) as cts:query?
{
	let $targets := qe:lookup-name ($name)

	return
	typeswitch ($targets[1])
	case xs:QName return qe:query-from-qname ($targets, $op, $list)
	case text() return qe:query-from-qname (xs:QName ($targets), $op, $list)
	case function(xs:string, element()*) as cts:query
		return
		if (fn:count ($targets) = 1)
		then $targets ($op, $list)
		else cts:or-query ($targets ! . ($op, $list))		(: This iterates over all the functions, invoking each one, wrapping in an or-query :)
	default return cts:and-query ((xdmp:describe ($targets)))	(: FixMe: This means something unexpected has happened :)
};

declare private function qe:expr(
  $op as xs:string,
  $list as cts:query*)
as cts:query?
{
  (: To implement a new operator, simply add it to this code :)
  if (empty($list)) then ()
  (: simple boolean :)
  else if (empty($op) or $op eq 'and') then cts:and-query($list)
  else if ($op = ('not', '-')) then cts:not-query($list)
  else if ($op = ('or','|')) then cts:or-query($list)
  (: near and variations :)
  else if ($op eq 'near') then cts:near-query($list)
  else if (starts-with($op, 'near/')) then cts:near-query(
    $list, xs:double(substring-after($op, 'near/')))
  else if ($op eq 'onear') then cts:near-query($list, (), 'ordered')
  else if (starts-with($op, 'onear/')) then cts:near-query(
    $list, xs:double(substring-after($op, 'onear/')), 'ordered')
  else error((), 'UNEXPECTED')
};


declare function qe:eval($n as element())
as cts:query?
{
  (: walk the AST, transforming AST XML into cts:query items :)
  typeswitch($n)
  case element(p:expression) return qe:expr($n/@op, qe:eval($n/*))
  (: NB - no eval, since we may need to handle literals in qe:field too :)
  (: This code works as long as your field names match the QNames.
   : If they do not, replace xs:QName with a lookup function.
   :)
  case element(p:field) return qe:field ($n/@name/string(), $n/@op, $n/*)
  case element(p:group) return (
    if (count($n/*, 2) lt 2) then qe:eval($n/*)
    else cts:and-query(qe:eval($n/*)))
  (: NB - interesting literals should be handled by the cases above  :)
  case element(p:literal) return cts:word-query($n)
  case element(p:root) return (
    if (count($n/*, 2) lt 2) then qe:eval($n/*)
    else cts:and-query(qe:eval($n/*)))
  default return error((), 'UNEXPECTED')
};

(: public entry point :)
declare function qe:parse($qs as xs:string?) as cts:query?
{
  qe:eval(p:parse($qs))
};

(: query-eval.xqy :)
