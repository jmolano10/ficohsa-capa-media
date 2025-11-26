(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transaccionSubasta" element="ns1:transaccionSubasta" location="transaccionSubastaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ConsultadetasadecambiosubastaResponse" element="ns0:ConsultadetasadecambiosubastaResponse" location="../../consultasDivisas/Resources/XMLSchema_-1176801753.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Transferenciaentrecuentas" location="../../Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transaccionSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/transaccionSubasta/transferenciaEntreCuentasIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:transferenciaEntreCuentasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $transaccionSubasta as element(ns1:transaccionSubasta),
    $ConsultadetasadecambiosubastaResponse as element(ns0:ConsultadetasadecambiosubastaResponse),
    $uuid as xs:string)
    as element(ns0:Transferenciaentrecuentas) {
        <ns0:Transferenciaentrecuentas>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
				<noOfAuth/>
				<replace/>
            </OfsFunction>            
            <FUNDSTRANSFERRETAILSALEWSType>
                <DEBITACCOUNT>{ data($transaccionSubasta/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                {
                	let $AUCTION_RATE_TYPE := fn:string($transaccionSubasta/AUCTION_RATE_TYPE/text())
                	let $TRANSACTION_AMOUNT := number($transaccionSubasta/TRANSACTION_AMOUNT)
                    return
                    	if($AUCTION_RATE_TYPE = "MIN") then (
                    		let $MIN := number($ConsultadetasadecambiosubastaResponse/WSAUCTIONRATESType[1]/gWSAUCTIONRATESDetailType/mWSAUCTIONRATESDetailType[1]/MINIMUMRATE)
                    		return
                    			<DEBITAMOUNT>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even($TRANSACTION_AMOUNT*$MIN,4),"######0.00"),0) }</DEBITAMOUNT>
                    		
                    	) else if($AUCTION_RATE_TYPE = "MAX") then (
                    		let $MAX := number($ConsultadetasadecambiosubastaResponse/WSAUCTIONRATESType[1]/gWSAUCTIONRATESDetailType/mWSAUCTIONRATESDetailType[1]/MAXIMUMRATE)
                    		return
                    			<DEBITAMOUNT>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even($TRANSACTION_AMOUNT*$MAX,4),"######0.00"),0) }</DEBITAMOUNT>
                    		
                    	) else if($AUCTION_RATE_TYPE = ("AVG","")) then (
                    		let $AVG := number($ConsultadetasadecambiosubastaResponse/WSAUCTIONRATESType[1]/gWSAUCTIONRATESDetailType/mWSAUCTIONRATESDetailType[1]/AVERAGERATE)
                    		return
                    			<DEBITAMOUNT>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even($TRANSACTION_AMOUNT*$AVG,4),"######0.00"),0) }</DEBITAMOUNT>
                    		
                    	) else if($AUCTION_RATE_TYPE = "MAN") then (
                    		let $MAN := number($transaccionSubasta/SUGGESTED_RATE)
                    		return
                    			<DEBITAMOUNT>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even($TRANSACTION_AMOUNT*$MAN,4),"######0.00"),0) }</DEBITAMOUNT>             		
                    	) else ()   
                }
                <CREDITACCOUNT>{ data($transaccionSubasta/ACCOUNT_TRANSFER/CREDIT_ACCOUNT) }</CREDITACCOUNT>
                <LRFICOAUCTION>YES</LRFICOAUCTION>
                {
                	let $AUCTION_RATE_TYPE := fn:string($transaccionSubasta/AUCTION_RATE_TYPE/text())
                	return
                		if ($AUCTION_RATE_TYPE = ("MAX","MIN","AVG")) then (
                			<LRRATEOPTION>{ $AUCTION_RATE_TYPE }</LRRATEOPTION>
                		) else if($AUCTION_RATE_TYPE = "") then (
                			<LRRATEOPTION>AVG</LRRATEOPTION>
                		) else if($AUCTION_RATE_TYPE = "MAN") then (
                			<LRRATEOPTION>{ $AUCTION_RATE_TYPE }</LRRATEOPTION>,
                			<LRAUCRATE>{ data($transaccionSubasta/SUGGESTED_RATE) }</LRAUCRATE>		
                		) else ()
                }
            </FUNDSTRANSFERRETAILSALEWSType>
        </ns0:Transferenciaentrecuentas>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $transaccionSubasta as element(ns1:transaccionSubasta) external;
declare variable $ConsultadetasadecambiosubastaResponse as element(ns0:ConsultadetasadecambiosubastaResponse) external;
declare variable $uuid as xs:string external;

xf:transferenciaEntreCuentasIn($autenticacionRequestHeader,
    $transaccionSubasta,
    $ConsultadetasadecambiosubastaResponse,
    $uuid)