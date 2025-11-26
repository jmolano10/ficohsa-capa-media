(:: pragma bea:global-element-parameter parameter="$confirmaciondecheques_ValidateResponse1" element="ns0:Confirmaciondecheques_ValidateResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaEstadoCheque1" element="ns1:consultaEstadoCheque" location="consultaEstadoChequeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoChequeResponse" location="consultaEstadoChequeTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/consultaEstadoCheque/out2/";

declare function xf:out2($confirmaciondecheques_ValidateResponse1 as element(ns0:Confirmaciondecheques_ValidateResponse),
    $consultaEstadoCheque1 as element(ns1:consultaEstadoCheque),
    $chequeStatus as xs:string)
    as element(ns1:consultaEstadoChequeResponse) {
        <ns1:consultaEstadoChequeResponse>
            <ACCOUNT_NUMBER>{ data($consultaEstadoCheque1/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <CHEQUE_NUMBER>{ data($consultaEstadoCheque1/CHEQUE_NUMBER) }</CHEQUE_NUMBER>
            {
            let $messages := $confirmaciondecheques_ValidateResponse1/Status/messages
                return
 				 				 				
 				let $flag := 
	 				if (fn:exists($messages)) 
	 				then (	 					 					
		 					for $t in tokenize($chequeStatus,'\|\|')
			 				return	           	                	                	                
			                	if (fn:contains(fn:upper-case($messages),fn:tokenize(data($t), "\:")[2])) 
			                		then (<CHEQUE_STATUS>{ fn:concat("CHEQUE ",fn:tokenize(data($t), "\:")[1]) }</CHEQUE_STATUS>)			            
			                		else()			                			    	                	 						 						 			
	 					) 					
	 				else 
	 				(
	 					<CHEQUE_STATUS>CHEQUE AVAILABLE</CHEQUE_STATUS>
	 				)
	 				 			
 				return ( if (fn:empty($flag)) then (<CHEQUE_STATUS>{ data($messages) }</CHEQUE_STATUS>) else ($flag))
            }
        </ns1:consultaEstadoChequeResponse>
};

declare variable $confirmaciondecheques_ValidateResponse1 as element(ns0:Confirmaciondecheques_ValidateResponse) external;
declare variable $consultaEstadoCheque1 as element(ns1:consultaEstadoCheque) external;
declare variable $chequeStatus as xs:string external;

xf:out2($confirmaciondecheques_ValidateResponse1,
    $consultaEstadoCheque1,
    $chequeStatus)