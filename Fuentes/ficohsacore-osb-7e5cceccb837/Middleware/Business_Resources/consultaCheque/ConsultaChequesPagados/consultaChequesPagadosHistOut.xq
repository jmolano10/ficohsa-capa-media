(:: pragma bea:global-element-parameter parameter="$consultaChequesPagadosTTHISResponse" element="ns0:ConsultaChequesPagadosTTHISResponse" location="../Resources/XMLSchema_516353548.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequesPagadosFTHISResponse" element="ns0:ConsultaChequesPagadosFTHISResponse" location="../Resources/XMLSchema_516353548.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaChequesPagadosResponse" location="consultaChequesPagadosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesPagadosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequesPagados/consultaChequesPagadosHistOut/";

(: Devuelve los ID TT que aparecen más de una vez :)
declare function obtenerTTRepetidos($consultaChequesPagadosTTHISResponse as element(ns0:ConsultaChequesPagadosTTHISResponse)) 
	as xs:string*{
	
	for $id in $consultaChequesPagadosTTHISResponse/WSTTCHEQUESPRESENTEDHISType[1]/gWSTTCHEQUESPRESENTEDHISDetailType/mWSTTCHEQUESPRESENTEDHISDetailType/ID/text()
	return
		if (count($consultaChequesPagadosTTHISResponse/WSTTCHEQUESPRESENTEDHISType[1]/gWSTTCHEQUESPRESENTEDHISDetailType/mWSTTCHEQUESPRESENTEDHISDetailType[fn:tokenize(ID,";")[1]=fn:tokenize($id,";")[1]]/ID) > 1) then (
			$id
		) else ()	
		
};

(: Devuelve los ID FT que aparecen más de una vez :)
declare function obtenerFTRepetidos($consultaChequesPagadosFTHISResponse as element(ns0:ConsultaChequesPagadosFTHISResponse)) 
	as xs:string*{
	
	for $id in $consultaChequesPagadosFTHISResponse/WSFTCHEQUESPRESENTEDHISType[1]/gWSFTCHEQUESPRESENTEDHISDetailType/mWSFTCHEQUESPRESENTEDHISDetailType/ID/text()
	return
		if (count($consultaChequesPagadosFTHISResponse/WSFTCHEQUESPRESENTEDHISType[1]/gWSFTCHEQUESPRESENTEDHISDetailType/mWSFTCHEQUESPRESENTEDHISDetailType[fn:tokenize(ID,";")[1]=fn:tokenize($id,";")[1]]/ID) > 1) then (
			$id
		) else ()	
		
};

declare function xf:consultaChequesPagadosHistOut($consultaChequesPagadosTTHISResponse as element(ns0:ConsultaChequesPagadosTTHISResponse),
    $consultaChequesPagadosFTHISResponse as element(ns0:ConsultaChequesPagadosFTHISResponse))
    as element(ns1:consultaChequesPagadosResponse) {
        <ns1:consultaChequesPagadosResponse>
            <ns1:consultaChequesPagadosResponseType>
                {
                	let $notAllowed := obtenerTTRepetidos($consultaChequesPagadosTTHISResponse)
                    for $mWSTTCHEQUESPRESENTEDHISDetailType in $consultaChequesPagadosTTHISResponse/WSTTCHEQUESPRESENTEDHISType[1]/gWSTTCHEQUESPRESENTEDHISDetailType/mWSTTCHEQUESPRESENTEDHISDetailType
                    return
                    	if( not(fn:string($mWSTTCHEQUESPRESENTEDHISDetailType/ID/text()) = ($notAllowed)) ) then (
	                        <ns1:consultaChequesPagadosResponseRecordType>
	                            {
	                                for $ID in $mWSTTCHEQUESPRESENTEDHISDetailType/ID
	                                return
	                                    <TRANSACTION_ID>{ fn:tokenize($ID,";")[1] }</TRANSACTION_ID>
	                            }
	                            {
	                                for $CHEQUEACCOUNT in $mWSTTCHEQUESPRESENTEDHISDetailType/CHEQUEACCOUNT
	                                return
	                                    <ACCOUNT_NUMBER>{ data($CHEQUEACCOUNT) }</ACCOUNT_NUMBER>
	                            }
	                            {
	                                for $CHEQUENUMBER in $mWSTTCHEQUESPRESENTEDHISDetailType/CHEQUENUMBER
	                                return
	                                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
	                            }
	                            {
	                                for $CHEQUEAMOUNT in $mWSTTCHEQUESPRESENTEDHISDetailType/CHEQUEAMOUNT
	                                return
	                                    <AMOUNT>{ data($CHEQUEAMOUNT) }</AMOUNT>
	                            }
	                            {
	                                for $BRANCHCODE in $mWSTTCHEQUESPRESENTEDHISDetailType/BRANCHCODE
	                                return
	                                    <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
	                            }
	                            {
	                                for $CHEQUECURRENCY in $mWSTTCHEQUESPRESENTEDHISDetailType/CHEQUECURRENCY
	                                return
	                                    <CURRENCY>{ data($CHEQUECURRENCY) }</CURRENCY>
	                            }
	                            {
	                                for $CHEQUEINPUTTER in $mWSTTCHEQUESPRESENTEDHISDetailType/CHEQUEINPUTTER
	                                return
	                                    <INPUTTER>{ data($CHEQUEINPUTTER) }</INPUTTER>
	                            }
	                        </ns1:consultaChequesPagadosResponseRecordType>
	            	) else ()
                }            
                {
                	let $notAllowed := obtenerFTRepetidos($consultaChequesPagadosFTHISResponse)
                	for $mWSFTCHEQUESPRESENTEDHISDetailType in $consultaChequesPagadosFTHISResponse/WSFTCHEQUESPRESENTEDHISType[1]/gWSFTCHEQUESPRESENTEDHISDetailType/mWSFTCHEQUESPRESENTEDHISDetailType
                    return
                    	if( not(fn:string($mWSFTCHEQUESPRESENTEDHISDetailType/ID/text()) = ($notAllowed)) ) then (
	                        <ns1:consultaChequesPagadosResponseRecordType>
	                            {
	                                for $ID in $mWSFTCHEQUESPRESENTEDHISDetailType/ID
	                                return
	                                    <TRANSACTION_ID>{ fn:tokenize($ID,";")[1] }</TRANSACTION_ID>
	                            }
	                            {
	                                for $CHEQUEACCOUNT in $mWSFTCHEQUESPRESENTEDHISDetailType/CHEQUEACCOUNT
	                                return
	                                    <ACCOUNT_NUMBER>{ data($CHEQUEACCOUNT) }</ACCOUNT_NUMBER>
	                            }
	                            {
	                                for $CHEQUENUMBER in $mWSFTCHEQUESPRESENTEDHISDetailType/CHEQUENUMBER
	                                return
	                                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
	                            }
	                            {
	                                for $CHEQUEAMOUNT in $mWSFTCHEQUESPRESENTEDHISDetailType/CHEQUEAMOUNT
	                                return
	                                    <AMOUNT>{ data($CHEQUEAMOUNT) }</AMOUNT>
	                            }
	                            {
	                                for $BRANCHCODE in $mWSFTCHEQUESPRESENTEDHISDetailType/BRANCHCODE
	                                return
	                                    <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
	                            }
	                            {
	                                for $CHEQUECURRENCY in $mWSFTCHEQUESPRESENTEDHISDetailType/CHEQUECURRENCY
	                                return
	                                    <CURRENCY>{ data($CHEQUECURRENCY) }</CURRENCY>
	                            }
	                            {
	                                for $CHEQUEINPUTTER in $mWSFTCHEQUESPRESENTEDHISDetailType/CHEQUEINPUTTER
	                                return
	                                    <INPUTTER>{ data($CHEQUEINPUTTER) }</INPUTTER>
	                            }
	                        </ns1:consultaChequesPagadosResponseRecordType>
	            	) else ()
                }
            </ns1:consultaChequesPagadosResponseType>
        </ns1:consultaChequesPagadosResponse>
};

declare variable $consultaChequesPagadosTTHISResponse as element(ns0:ConsultaChequesPagadosTTHISResponse) external;
declare variable $consultaChequesPagadosFTHISResponse as element(ns0:ConsultaChequesPagadosFTHISResponse) external;

xf:consultaChequesPagadosHistOut($consultaChequesPagadosTTHISResponse,
    $consultaChequesPagadosFTHISResponse)