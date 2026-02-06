xquery version "2004-draft" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguroFacade/xq/procesamientoPreguntasIn/";

declare function xf:procesamientoPreguntasIn($plot as xs:string,
    $countQuestions as xs:string,
    $repeatQuestion as xs:string)
    as element(*) {
    
    <HEALTH_QUESTIONS>
		{
			for $i in (1 to xs:integer($countQuestions))
        		return
            		let $question := fn:tokenize(data($repeatQuestion),"\|\|")
            		let $repeatCycle := fn:tokenize(data($question[$i]),"-")
            		let $splitPlot := fn:tokenize(data($plot),"\|\|")
            		for $j in (1 to xs:integer($repeatCycle[1]))
            			return
            				<HEALTH_QUESTION>
                 		 		<ID>{ xs:integer($repeatCycle[2]) + $j }</ID>
                  				<ANSWER>{ data($splitPlot[$i+2]) }</ANSWER>
               				</HEALTH_QUESTION>
        }
	</HEALTH_QUESTIONS>
};

declare variable $plot as xs:string external;
declare variable $countQuestions as xs:string external;
declare variable $repeatQuestion as xs:string external;

xf:procesamientoPreguntasIn($plot,
    $countQuestions,
    $repeatQuestion)