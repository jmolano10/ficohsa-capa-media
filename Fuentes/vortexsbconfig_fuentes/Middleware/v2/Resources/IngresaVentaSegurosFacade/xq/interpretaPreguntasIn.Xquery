<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguroFacade/xq/interpretaPreguntasIn/";

declare function xf:interpretaPreguntasIn($countQuestion as xs:string,
    $plot as xs:string,
    $expectedValue as xs:string)
    as element(*) {
    	&lt;ANSWER> 
    		{
       			for $i in (1 to xs:integer($countQuestion))
        			return
        				let $splitPlot := fn:tokenize(data($plot),"\|\|")
            			let $question := fn:tokenize(data($expectedValue),"\|\|")    		
            				return
            				if( compare(data($splitPlot[$i + 2 ]), data($question[$i]))!=0)then(
                    			&lt;ID>NO&lt;/ID>
            				)else()     			
           	} 
    	&lt;/ANSWER>
};

declare variable $countQuestion as xs:string external;
declare variable $plot as xs:string external;
declare variable $expectedValue as xs:string external;

xf:interpretaPreguntasIn($countQuestion,
    $plot,
    $expectedValue)</con:xquery>
</con:xqueryEntry>