(:: pragma bea:global-element-parameter parameter="$bloqueoCertificadoDeposito1" element="ns0:bloqueoCertificadoDeposito" location="../xsd/bloqueoCertificadoDepositoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Bloqueodepasivos" location="../../../../Business_Resources/bloqueoCertificadoDeposito/Resources/XMLSchema_524093592.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/bloqueoCertificadoDepositoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoCertificadoDeposito/xq/bloqueoCertificadoDepositoIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:bloqueoCertificadoDepositoIn($bloqueoCertificadoDeposito1 as element(ns0:bloqueoCertificadoDeposito),
    $requestHeader1 as element(ns2:RequestHeader))
    as element(ns1:Bloqueodepasivos) {
        <ns1:Bloqueodepasivos>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }
                </userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }
                </password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <ACLOCKEDEVENTSINPUTWSType>
                <ACCOUNTNUMBER>{ data($bloqueoCertificadoDeposito1/DEPOSIT_NUMBER) }</ACCOUNTNUMBER>
                {
                    for $DESCRIPTION in $bloqueoCertificadoDeposito1/DESCRIPTION
                    return
                        <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                }
                <FROMDATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",data($bloqueoCertificadoDeposito1/BEGIN_DATE)) }</FROMDATE>
                <TODATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",data($bloqueoCertificadoDeposito1/END_DATE)) }</TODATE>
                <LOCKEDAMOUNT>{ xs:string(data($bloqueoCertificadoDeposito1/BLOCK_AMOUNT)) }</LOCKEDAMOUNT>
            </ACLOCKEDEVENTSINPUTWSType>
        </ns1:Bloqueodepasivos>
};

declare variable $bloqueoCertificadoDeposito1 as element(ns0:bloqueoCertificadoDeposito) external;
declare variable $requestHeader1 as element(ns2:RequestHeader) external;

xf:bloqueoCertificadoDepositoIn($bloqueoCertificadoDeposito1,
    $requestHeader1)
