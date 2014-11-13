

set MLCPBIN=C:\mlcp-Hadoop2-1.2-1\bin
set INPUTDIR=D:/DataImports/Abstracts/TestRecords

set URIPREFIX=/abstracts
set XFORMMOD=/transform-abstract.xqy
set XFORMNS=http://cabi.org/transform

call %MLCPBIN%/mlcp.bat import -mode local -host localhost -port 12102 -username CabiAdmin -password MarkLogicDBA -input_file_path %INPUTDIR% -output_uri_prefix %URIPREFIX%  -output_uri_replace "%INPUTDIR%,''"  -transform_module %XFORMMOD% -transform_namespace %XFORMNS% -output_collections urn:cabi.org:collections:abstracts
