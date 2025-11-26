(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ingresoDataCapture" element="ns1:ingresoDataCapture" location="ingresoDataCaptureTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:IngresodeDataCapture" location="../Resources/XMLSchema_-987790958.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureIn/";

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

declare function xf:ingresoDataCaptureIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $ingresoDataCapture as element(ns1:ingresoDataCapture),
    $transactionCodeDebito as xs:string,
    $transactionCodeCredito as xs:string,
    $uuid as xs:string)
    as element(ns0:IngresodeDataCapture) {
        <ns0:IngresodeDataCapture>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
			    <gtsControl></gtsControl>
			    <messageId>{ $uuid }</messageId>
			    <noOfAuth></noOfAuth>
			    <replace></replace>
			</OfsFunction>            
            <DATACAPTUREINPUTWSType id = "{ concat($ingresoDataCapture/DEPARTMENT_CODE , $ingresoDataCapture/BATCH_ID) }">
                <ACCOUNTNUMBER>{ data($ingresoDataCapture/ACCOUNT_NUMBER) }</ACCOUNTNUMBER>
                {
                	let $debit_credit := fn:string($ingresoDataCapture/DEBIT_CREDIT/text())
                	return
                		if ($debit_credit = "DEBIT") then (
                			<SIGN>D</SIGN>,
                			<TRANSACTIONCODE>{ $transactionCodeDebito }</TRANSACTIONCODE>
                		) else if ($debit_credit = "CREDIT") then (
                			<SIGN>C</SIGN>,
                			<TRANSACTIONCODE>{ $transactionCodeCredito }</TRANSACTIONCODE>
                		) else ()
                }
                <gNARRATIVE>
				{
                	for $descripcion in splitString(data($ingresoDataCapture/DESCRIPTION),34)
                		return
                			if(fn:string($descripcion) != "") then (
                				<NARRATIVE>{data($descripcion)}</NARRATIVE>
                			) else ()
                }
                </gNARRATIVE>
                <PLCATEGORY>{ data($ingresoDataCapture/PROFIT_LOSS_CATEGORY) }</PLCATEGORY>
                <ACCOUNTOFFICER>{ data($ingresoDataCapture/PROFIT_CENTER) }</ACCOUNTOFFICER>
                <PRODUCTCATEGORY>{ data($ingresoDataCapture/PRODUCT_CATEGORY) }</PRODUCTCATEGORY>                                                
                {
                    for $VALUE_DATE in $ingresoDataCapture/VALUE_DATE
                    return
                        <VALUEDATE>{ data($VALUE_DATE) }</VALUEDATE>
                }
                {
	                if (data($ingresoDataCapture/CURRENCY) = "HNL") then (
	                	<AMOUNTLCY>{ data($ingresoDataCapture/AMOUNT) }</AMOUNTLCY>
	                
	                ) else (
	                    <CURRENCY>{ data($ingresoDataCapture/CURRENCY) }</CURRENCY>,
	                    <AMOUNTFCY>{ data($ingresoDataCapture/AMOUNT) }</AMOUNTFCY>
	               	)
				}
            </DATACAPTUREINPUTWSType>
        </ns0:IngresodeDataCapture>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $ingresoDataCapture as element(ns1:ingresoDataCapture) external;
declare variable $transactionCodeDebito as xs:string external;
declare variable $transactionCodeCredito as xs:string external; 
declare variable $uuid as xs:string external;

xf:ingresoDataCaptureIn($autenticacionRequestHeader,
    $ingresoDataCapture,
    $transactionCodeDebito,
    $transactionCodeCredito,
    $uuid)