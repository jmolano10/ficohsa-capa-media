(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$bloqueoFondosCuenta" element="ns1:bloqueoFondosCuenta" location="bloqueoFondosCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Bloqueodepasivos" location="../Resoruces/XMLSchema_524093592.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bloqueoFondosCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/bloqueoPasivos/BloqueoFondosCuenta/bloqueoFondosCuentaIn/";

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

declare function xf:bloqueoFondosCuentaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $bloqueoFondosCuenta as element(ns1:bloqueoFondosCuenta),
    $uuid as xs:string)
    as element(ns0:Bloqueodepasivos) {
        <ns0:Bloqueodepasivos>
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
            <ACLOCKEDEVENTSINPUTWSType>
                <ACCOUNTNUMBER>{ data($bloqueoFondosCuenta/ACCOUNT_NUMBER) }</ACCOUNTNUMBER>
                <DESCRIPTION>{ data($bloqueoFondosCuenta/DESCRIPTION) }</DESCRIPTION>
                {
                    for $BEGIN_DATE in $bloqueoFondosCuenta/BEGIN_DATE
                    return
                    	if ($BEGIN_DATE != "") then (
                        	<FROMDATE>{ data($BEGIN_DATE) }</FROMDATE>
                        ) else ()
                }
                <TODATE>{ data($bloqueoFondosCuenta/END_DATE) }</TODATE>
                <LOCKEDAMOUNT>{ data($bloqueoFondosCuenta/BLOCK_AMOUNT) }</LOCKEDAMOUNT>
                {
                    for $MERCHANT_CODE in $bloqueoFondosCuenta/MERCHANT_CODE
                    return
                    	if($MERCHANT_CODE != "") then (
                        	<MERCHANTCODE>{ data($MERCHANT_CODE) }</MERCHANTCODE>
                        ) else ()
                }
                {
                    for $CARD_COMPANY in $bloqueoFondosCuenta/CARD_COMPANY
                    return
                    	if($CARD_COMPANY != "") then (
                        	<CARDCOMPANY>{ data($CARD_COMPANY) }</CARDCOMPANY>
                        ) else ()
                }
                {
                    for $CURRENCY in $bloqueoFondosCuenta/CURRENCY
                    return
                    	if($CURRENCY != "") then (
                        	<CURRENCY>{ data($CURRENCY) }</CURRENCY>
                        ) else ()
                }
                {
                    for $DEBIT_CARD_NUMBER in $bloqueoFondosCuenta/DEBIT_CARD_NUMBER
                    return
                    	if($DEBIT_CARD_NUMBER != "") then (
                        	<DEBITCARDNUMBER>{ data($DEBIT_CARD_NUMBER) }</DEBITCARDNUMBER>
                        ) else ()
                }
                {
                    for $LOCK_REFERENCE_NO in $bloqueoFondosCuenta/LOCK_REFERENCE_NO
                    return
                    	if($LOCK_REFERENCE_NO != "") then (
                        	<LOCKREFERENCENO>{ data($LOCK_REFERENCE_NO) }</LOCKREFERENCENO>
                        ) else ()
                }
                {
                    for $LOCK_MOTIVE in $bloqueoFondosCuenta/LOCK_MOTIVE
                    return
                    	if($LOCK_MOTIVE != "") then (
                        	<LOCKMOTIVE>{ data($LOCK_MOTIVE) }</LOCKMOTIVE>
                        ) else ()
                }
            </ACLOCKEDEVENTSINPUTWSType>
        </ns0:Bloqueodepasivos>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $bloqueoFondosCuenta as element(ns1:bloqueoFondosCuenta) external;
declare variable $uuid as xs:string external;

xf:bloqueoFondosCuentaIn($autenticacionRequestHeader,
    $bloqueoFondosCuenta,
    $uuid)