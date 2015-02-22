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

(: ------------------------------- :)

declare variable $publisher-qname := xs:QName ("cabi:publisher");
declare variable $item-title-qname := xs:QName ("cabi:item-type");
declare variable $non-english-title-qname := xs:QName ("cabi:non-english-title");
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

(: ------------------------------- :)

declare private variable $value-fields := ( $pan-qname, $issn-qname, $isbn-qname, $doi-qname );

declare private variable $field-qnames as map:map := map:map (
	<map:map xmlns:map="http://marklogic.com/xdmp/map">
		<map:entry key="pb"><map:value>{ $publisher-qname }</map:value></map:entry>
		<map:entry key="pub"><map:value>{ $publisher-qname }</map:value></map:entry>
		<map:entry key="publisher"><map:value>{ $publisher-qname }</map:value></map:entry>

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
	</map:map>
);

(: ------------------------------- :)

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

declare private function qe:canonical-qname (
	$name as xs:string?
) as xs:QName+
{
	let $value := map:get ($field-qnames, fn:lower-case ($name))

	return if (fn:exists ($value)) then $value else xs:QName ("cabi:" || $name)
};


declare private function qe:field (
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
  case element(p:field) return qe:field(
    qe:canonical-qname (fn:tokenize ($n/@name/string(), "(\s+)|(\s*,\s*)")), $n/@op, $n/*)
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
