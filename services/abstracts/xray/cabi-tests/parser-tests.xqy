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

(: FixMe: Does XQYSP do escaped quotes?:)
declare %test:case function should-return-escaped-quotes-phrased-ast()
{
	assert:equal (xqysp:parse ('"dog \"and\" cat"'),
		<root xmlns="com.blakeley.xqysp">
			<literal>dog "and" cat</literal>
		</root>)
};
 

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


declare %test:case function should-return-field-with-range-start-and-end-inclusive-ast()
{
    assert:equal (xqysp:parse ("ex:[123441123123 TO *]"),
    <root xmlns="com.blakeley.xqysp">
		<field name="ex" op=":">
		  <range range-type="inclusive">
		      <start-value><literal>123441123123</literal></start-value>
		      <end-value><literal>*</literal></end-value>
		  </range>
		</field>
	</root>)
};

declare %test:case function should-return-field-with-range-start-inclusive-ast()
{
    (:assert:equal (xqysp:parse ("(&#34;water use efficiency&#34; or WUE or drought or abiotic or transpirat* or &#34;water usage&#34; or &#34;water utilization&#34; or &#34;water uptake&#34; or &#34;uptake of water&#34; or &#34;water take up&#34; or &#34;water stress&#34; or &#34;water use&#34; or &#34;water efficiency&#34; or ((ros or &#34;reactive oxygen species&#34; or &#34;oxidative stress&#34;) and not (&#34;human nutrition&#34; or animal or human or pharmac* or drug or rat or mice or mouse or rats or man)) or &#34;root growth&#34; or &#34;osmotic stress&#34; or dehydrat* or &#34;moisture stress&#34; or &#34;drought stress&#34;) AND (up:(spermatophyta OR bryophyta OR pteridophyta) OR od:(plants) OR de:(plants)) AND ((cereals OR barley or hordeum or corn or maize or &#34;zea mays&#34; or rice or &#34;oryza sativa&#34; or wheat or triticum or triticale or rye or secale or &#34;oilseed plants&#34; OR canola or &#34;brassica napus&#34; or &#34;brassica rapa&#34; or &#34;brassica campestris&#34; or rapeseed or rape or sunflower or &#34;helianthus annuus&#34; or &#34;transgenic plants&#34; OR soyabean OR &#34;glycine max&#34; OR soybean or &#34;soya beans&#34; or sugarcane or &#34;sugar cane&#34; or &#34;saccharum officinarum&#34; OR &#34;saccharum spontaneum&#34; OR &#34;Arabidopsis&#34; OR &#34;field crops&#34; OR rowcrops OR &#34;grain crops&#34; OR &#34;sugar crops&#34; or sorghum or milo or alfalfa or lucerne or &#34;medicago sativa&#34; or legume or &#34;medicago truncatula&#34; or &#34;Lotus japonicas&#34; or tomato or tomatoes or tobacco or brachipodium or brachypodium or &#34;fodder legumes&#34; or &#34;Solanum lycopersicon&#34; or &#34;Lycopersicon esculentum&#34; or &#34;nicotiana tabacum&#34; or promoter* or gene or genes or genetic* or genom* or sequenc* or nucle* or polypeptide* or peptide* or protein* or pathway* or molecul* or cell* or plasmid* or vector* or chromosom* or biotech* or sequenc* or mrna or rna* or dna or cdna or transgen* or transcri* or transform* or recombina* or clon* or allele* or homolog* or ortholog* or encod*) or cabicode:(FF005) or de:(gene expression or genetic transformation or nucleotide sequences or biochemical pathways or DNA vectors or genetic engineering or transgenic plants or genetic engineering or DNA cloning)) AND ex:[20121120 TO *]"),:)
    assert:equal (xqysp:parse ("yr:[2015]"),
    <root xmlns="com.blakeley.xqysp">
		<field name="yr" op=":">
		  <range range-type="inclusive">
		      <start-value><literal>2015</literal></start-value>
		  </range>
		</field>
	</root>)
};

declare %test:case function should-return-field-with-range-start-and-end-exclusive-ast()
{
    (:assert:equal (xqysp:parse ("(&#34;water use efficiency&#34; or WUE or drought or abiotic or transpirat* or &#34;water usage&#34; or &#34;water utilization&#34; or &#34;water uptake&#34; or &#34;uptake of water&#34; or &#34;water take up&#34; or &#34;water stress&#34; or &#34;water use&#34; or &#34;water efficiency&#34; or ((ros or &#34;reactive oxygen species&#34; or &#34;oxidative stress&#34;) and not (&#34;human nutrition&#34; or animal or human or pharmac* or drug or rat or mice or mouse or rats or man)) or &#34;root growth&#34; or &#34;osmotic stress&#34; or dehydrat* or &#34;moisture stress&#34; or &#34;drought stress&#34;) AND (up:(spermatophyta OR bryophyta OR pteridophyta) OR od:(plants) OR de:(plants)) AND ((cereals OR barley or hordeum or corn or maize or &#34;zea mays&#34; or rice or &#34;oryza sativa&#34; or wheat or triticum or triticale or rye or secale or &#34;oilseed plants&#34; OR canola or &#34;brassica napus&#34; or &#34;brassica rapa&#34; or &#34;brassica campestris&#34; or rapeseed or rape or sunflower or &#34;helianthus annuus&#34; or &#34;transgenic plants&#34; OR soyabean OR &#34;glycine max&#34; OR soybean or &#34;soya beans&#34; or sugarcane or &#34;sugar cane&#34; or &#34;saccharum officinarum&#34; OR &#34;saccharum spontaneum&#34; OR &#34;Arabidopsis&#34; OR &#34;field crops&#34; OR rowcrops OR &#34;grain crops&#34; OR &#34;sugar crops&#34; or sorghum or milo or alfalfa or lucerne or &#34;medicago sativa&#34; or legume or &#34;medicago truncatula&#34; or &#34;Lotus japonicas&#34; or tomato or tomatoes or tobacco or brachipodium or brachypodium or &#34;fodder legumes&#34; or &#34;Solanum lycopersicon&#34; or &#34;Lycopersicon esculentum&#34; or &#34;nicotiana tabacum&#34; or promoter* or gene or genes or genetic* or genom* or sequenc* or nucle* or polypeptide* or peptide* or protein* or pathway* or molecul* or cell* or plasmid* or vector* or chromosom* or biotech* or sequenc* or mrna or rna* or dna or cdna or transgen* or transcri* or transform* or recombina* or clon* or allele* or homolog* or ortholog* or encod*) or cabicode:(FF005) or de:(gene expression or genetic transformation or nucleotide sequences or biochemical pathways or DNA vectors or genetic engineering or transgenic plants or genetic engineering or DNA cloning)) AND ex:[20121120 TO *]"),:)
    assert:equal (xqysp:parse ("year:{2015 To 2017}"),
    <root xmlns="com.blakeley.xqysp">
		<field name="year" op=":">
		  <range range-type="exclusive">
		      <start-value><literal>2015</literal></start-value>
		      <end-value><literal>2017</literal></end-value>
		  </range>
		</field>
	</root>)
};

declare %test:case function fail-should-not-return-field-with-range-start-and-end-exclusive-ast()
{
    (:assert:equal (xqysp:parse ("(&#34;water use efficiency&#34; or WUE or drought or abiotic or transpirat* or &#34;water usage&#34; or &#34;water utilization&#34; or &#34;water uptake&#34; or &#34;uptake of water&#34; or &#34;water take up&#34; or &#34;water stress&#34; or &#34;water use&#34; or &#34;water efficiency&#34; or ((ros or &#34;reactive oxygen species&#34; or &#34;oxidative stress&#34;) and not (&#34;human nutrition&#34; or animal or human or pharmac* or drug or rat or mice or mouse or rats or man)) or &#34;root growth&#34; or &#34;osmotic stress&#34; or dehydrat* or &#34;moisture stress&#34; or &#34;drought stress&#34;) AND (up:(spermatophyta OR bryophyta OR pteridophyta) OR od:(plants) OR de:(plants)) AND ((cereals OR barley or hordeum or corn or maize or &#34;zea mays&#34; or rice or &#34;oryza sativa&#34; or wheat or triticum or triticale or rye or secale or &#34;oilseed plants&#34; OR canola or &#34;brassica napus&#34; or &#34;brassica rapa&#34; or &#34;brassica campestris&#34; or rapeseed or rape or sunflower or &#34;helianthus annuus&#34; or &#34;transgenic plants&#34; OR soyabean OR &#34;glycine max&#34; OR soybean or &#34;soya beans&#34; or sugarcane or &#34;sugar cane&#34; or &#34;saccharum officinarum&#34; OR &#34;saccharum spontaneum&#34; OR &#34;Arabidopsis&#34; OR &#34;field crops&#34; OR rowcrops OR &#34;grain crops&#34; OR &#34;sugar crops&#34; or sorghum or milo or alfalfa or lucerne or &#34;medicago sativa&#34; or legume or &#34;medicago truncatula&#34; or &#34;Lotus japonicas&#34; or tomato or tomatoes or tobacco or brachipodium or brachypodium or &#34;fodder legumes&#34; or &#34;Solanum lycopersicon&#34; or &#34;Lycopersicon esculentum&#34; or &#34;nicotiana tabacum&#34; or promoter* or gene or genes or genetic* or genom* or sequenc* or nucle* or polypeptide* or peptide* or protein* or pathway* or molecul* or cell* or plasmid* or vector* or chromosom* or biotech* or sequenc* or mrna or rna* or dna or cdna or transgen* or transcri* or transform* or recombina* or clon* or allele* or homolog* or ortholog* or encod*) or cabicode:(FF005) or de:(gene expression or genetic transformation or nucleotide sequences or biochemical pathways or DNA vectors or genetic engineering or transgenic plants or genetic engineering or DNA cloning)) AND ex:[20121120 TO *]"),:)
    assert:not-equal (xqysp:parse ("year:{2015 until 2017}"),
    <root xmlns="com.blakeley.xqysp">
		<field name="year" op=":">
		  <range range-type="exclusive">
		      <start-value><literal>2015</literal></start-value>
		      <end-value><literal>2017</literal></end-value>
		  </range>
		</field>
	</root>)
};

declare %test:case function should-return-field-with-range-start-exclusive-ast()
{
    (:assert:equal (xqysp:parse ("(&#34;water use efficiency&#34; or WUE or drought or abiotic or transpirat* or &#34;water usage&#34; or &#34;water utilization&#34; or &#34;water uptake&#34; or &#34;uptake of water&#34; or &#34;water take up&#34; or &#34;water stress&#34; or &#34;water use&#34; or &#34;water efficiency&#34; or ((ros or &#34;reactive oxygen species&#34; or &#34;oxidative stress&#34;) and not (&#34;human nutrition&#34; or animal or human or pharmac* or drug or rat or mice or mouse or rats or man)) or &#34;root growth&#34; or &#34;osmotic stress&#34; or dehydrat* or &#34;moisture stress&#34; or &#34;drought stress&#34;) AND (up:(spermatophyta OR bryophyta OR pteridophyta) OR od:(plants) OR de:(plants)) AND ((cereals OR barley or hordeum or corn or maize or &#34;zea mays&#34; or rice or &#34;oryza sativa&#34; or wheat or triticum or triticale or rye or secale or &#34;oilseed plants&#34; OR canola or &#34;brassica napus&#34; or &#34;brassica rapa&#34; or &#34;brassica campestris&#34; or rapeseed or rape or sunflower or &#34;helianthus annuus&#34; or &#34;transgenic plants&#34; OR soyabean OR &#34;glycine max&#34; OR soybean or &#34;soya beans&#34; or sugarcane or &#34;sugar cane&#34; or &#34;saccharum officinarum&#34; OR &#34;saccharum spontaneum&#34; OR &#34;Arabidopsis&#34; OR &#34;field crops&#34; OR rowcrops OR &#34;grain crops&#34; OR &#34;sugar crops&#34; or sorghum or milo or alfalfa or lucerne or &#34;medicago sativa&#34; or legume or &#34;medicago truncatula&#34; or &#34;Lotus japonicas&#34; or tomato or tomatoes or tobacco or brachipodium or brachypodium or &#34;fodder legumes&#34; or &#34;Solanum lycopersicon&#34; or &#34;Lycopersicon esculentum&#34; or &#34;nicotiana tabacum&#34; or promoter* or gene or genes or genetic* or genom* or sequenc* or nucle* or polypeptide* or peptide* or protein* or pathway* or molecul* or cell* or plasmid* or vector* or chromosom* or biotech* or sequenc* or mrna or rna* or dna or cdna or transgen* or transcri* or transform* or recombina* or clon* or allele* or homolog* or ortholog* or encod*) or cabicode:(FF005) or de:(gene expression or genetic transformation or nucleotide sequences or biochemical pathways or DNA vectors or genetic engineering or transgenic plants or genetic engineering or DNA cloning)) AND ex:[20121120 TO *]"),:)
    assert:equal (xqysp:parse ("ex:{123456789}"),
    <root xmlns="com.blakeley.xqysp">
		<field name="ex" op=":">
		  <range range-type="exclusive">
		      <start-value><literal>123456789</literal></start-value>
		  </range>
		</field>
	</root>)
};

declare %test:case function should-return-4-items-with-lastone-range-ast()
{
    let $parsed-query :=xqysp:parse ("(&#34;water use efficiency&#34; or WUE or drought or abiotic or transpirat* or &#34;water usage&#34; or &#34;water utilization&#34; or &#34;water uptake&#34; or &#34;uptake of water&#34; or &#34;water take up&#34; or &#34;water stress&#34; or &#34;water use&#34; or &#34;water efficiency&#34; or ((ros or &#34;reactive oxygen species&#34; or &#34;oxidative stress&#34;) and not (&#34;human nutrition&#34; or animal or human or pharmac* or drug or rat or mice or mouse or rats or man)) or &#34;root growth&#34; or &#34;osmotic stress&#34; or dehydrat* or &#34;moisture stress&#34; or &#34;drought stress&#34;) AND (up:(spermatophyta OR bryophyta OR pteridophyta) OR od:(plants) OR de:(plants)) AND ((cereals OR barley or hordeum or corn or maize or &#34;zea mays&#34; or rice or &#34;oryza sativa&#34; or wheat or triticum or triticale or rye or secale or &#34;oilseed plants&#34; OR canola or &#34;brassica napus&#34; or &#34;brassica rapa&#34; or &#34;brassica campestris&#34; or rapeseed or rape or sunflower or &#34;helianthus annuus&#34; or &#34;transgenic plants&#34; OR soyabean OR &#34;glycine max&#34; OR soybean or &#34;soya beans&#34; or sugarcane or &#34;sugar cane&#34; or &#34;saccharum officinarum&#34; OR &#34;saccharum spontaneum&#34; OR &#34;Arabidopsis&#34; OR &#34;field crops&#34; OR rowcrops OR &#34;grain crops&#34; OR &#34;sugar crops&#34; or sorghum or milo or alfalfa or lucerne or &#34;medicago sativa&#34; or legume or &#34;medicago truncatula&#34; or &#34;Lotus japonicas&#34; or tomato or tomatoes or tobacco or brachipodium or brachypodium or &#34;fodder legumes&#34; or &#34;Solanum lycopersicon&#34; or &#34;Lycopersicon esculentum&#34; or &#34;nicotiana tabacum&#34; or promoter* or gene or genes or genetic* or genom* or sequenc* or nucle* or polypeptide* or peptide* or protein* or pathway* or molecul* or cell* or plasmid* or vector* or chromosom* or biotech* or sequenc* or mrna or rna* or dna or cdna or transgen* or transcri* or transform* or recombina* or clon* or allele* or homolog* or ortholog* or encod*) or cabicode:(FF005) or de:(gene expression or genetic transformation or nucleotide sequences or biochemical pathways or DNA vectors or genetic engineering or transgenic plants or genetic engineering or DNA cloning)) AND ex:[20121120 TO *]")
    let $attribute-value := fn:data ($parsed-query/xqysp:expression[1]/@op)
    let $expression-count := fn:count ($parsed-query/xqysp:expression)
    let $inner-items-count := fn:count ($parsed-query/xqysp:expression/xqysp:*)
    let $range-count := fn:count ($parsed-query/xqysp:expression/xqysp:*/xqysp:range)
    
    return 
    (
            assert:equal ($attribute-value,"and","Expression operator test"),
            assert:equal ($expression-count,1,"Expression count test"),
            assert:equal ($inner-items-count,4,"Inner items count test"),
            assert:equal ($range-count,1,"Range count test")
    )
};

