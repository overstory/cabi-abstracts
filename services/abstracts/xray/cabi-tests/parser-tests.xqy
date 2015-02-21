xquery version "1.0-ml";

module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "../src/assertions.xqy";

import module namespace xqysp = "com.blakeley.xqysp" at "../../appserver-root/xquery/handlers/lib/xqysp.xqy";

declare default function namespace "http://www.w3.org/2005/xpath-functions";


declare %test:case function test:hello-world()
{
  assert:true(true())
};
