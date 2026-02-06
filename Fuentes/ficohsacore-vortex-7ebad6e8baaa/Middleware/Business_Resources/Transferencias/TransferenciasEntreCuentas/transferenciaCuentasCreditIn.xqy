xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns1:transferenciaCuentasRequest" location="transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Transfentrecuentasinstrcredito" location="../Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasCreditIn/";

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

(: Se encarga de partir un string en una secuencia de string de determinado tamaño :)
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:transferenciaCuentasCreditIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $transferenciaCuentasRequest as element(ns1:transferenciaCuentasRequest),
    $transactionType as xs:string,
    $uuid as xs:string)
    as element(ns0:Transfentrecuentasinstrcredito) {
        <ns0:Transfentrecuentasinstrcredito>
			<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
	            <gtsControl></gtsControl>
            	<messageId>
            	{ 
            		if (fn:string($transferenciaCuentasRequest/INTERFACE_REFERENCE_NO/text()) = "") then (
            			$uuid
            		) else (
            			fn:string($transferenciaCuentasRequest/INTERFACE_REFERENCE_NO/text())
            		)
            	}
            	</messageId>
	            <noOfAuth></noOfAuth>
	            <replace></replace>
         	</OfsFunction>
            <FUNDSTRANSFERRETAILCRSALEWSType>
            	<TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCOUNT>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <CREDITACCOUNT>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</CREDITACCOUNT>
                <CREDITAMOUNT>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</CREDITAMOUNT>
                <gPAYMENTDETAILS>
                {
                	for $descripcion in splitString(data($transferenciaCuentasRequest/DESCRIPTION),34)
                		return
                			if(fn:string($descripcion) != "") then (
                				<PAYMENTDETAILS>{concat($descripcion, ".")}</PAYMENTDETAILS>
                			) else ()
                }
                {
                	for $descripcion in tokenize($transferenciaCuentasRequest/TRANSFER_DETAILS, '\|\|')
                		return
                		for $descripcionAux in splitString(data($descripcion),34)
                		return
                			if( fn:string($descripcionAux) != "" and not( fn:contains($descripcionAux,'[') and 
                														  fn:contains($descripcionAux,']') )) then (
                				<PAYMENTDETAILS>{concat($descripcionAux, ".")}</PAYMENTDETAILS>
                			) else ()        
                }
                </gPAYMENTDETAILS>
                {
                    for $ITEM_LEVEL_1 in $transferenciaCuentasRequest/ITEM_LEVEL_1
                    return
                        <LRCATEGORY>{ data($ITEM_LEVEL_1) }</LRCATEGORY>
                }
                {
                    for $ITEM_LEVEL_2 in $transferenciaCuentasRequest/ITEM_LEVEL_2
                    return
                        <LRSUBCATEG>{ data($ITEM_LEVEL_2) }</LRSUBCATEG>
                }
                {
                    for $ITEM_LEVEL_3 in $transferenciaCuentasRequest/ITEM_LEVEL_3
                    return
                        <LRITEM>{ data($ITEM_LEVEL_3) }</LRITEM>
                }
                {
                    for $ITEM_LEVEL_4 in $transferenciaCuentasRequest/ITEM_LEVEL_4
                    return
                        <LRSUBITEM>{ data($ITEM_LEVEL_4) }</LRSUBITEM>
                }
                {
                    for $ITEM_LEVEL_5 in $transferenciaCuentasRequest/ITEM_LEVEL_5
                    return
                        <LRGROUP>{ data($ITEM_LEVEL_5) }</LRGROUP>
                }
            </FUNDSTRANSFERRETAILCRSALEWSType>
        </ns0:Transfentrecuentasinstrcredito>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns1:transferenciaCuentasRequest) external;
declare variable $transactionType as xs:string external;
declare variable $uuid as xs:string external;

xf:transferenciaCuentasCreditIn($autenticacionRequestHeader,
    $transferenciaCuentasRequest,
    $transactionType,
    $uuid)