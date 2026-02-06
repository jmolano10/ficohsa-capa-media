xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns0:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadecomisionACH_Validate" location="../../../BusinessServices/ACH/consultaComisionACH/xsd/XMLSchema_-1548829260.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesLocalIn/";

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

declare function xf:consultaComisionesLocalIn($requestHeader as element(ns2:RequestHeader),
    $consultaComisiones as element(ns0:consultaComisiones))
    as element(ns1:ConsultadecomisionACH_Validate) {
        <ns1:ConsultadecomisionACH_Validate>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>1</noOfAuth>
            </OfsFunction>
            <FICOHNACHONLINECOMISIONACHWSType>
            	{
                    for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="CREDIT_CURRENCY"]/VALUE
                    return
                        <CREDITCCY>{ data($VALUE) }</CREDITCCY>
                }
                {
                    for $CUSTOMER_ID in $consultaComisiones/CUSTOMER_ID
                    return
                        <CUSTOMERID>{ data($CUSTOMER_ID) }</CUSTOMERID>
                }
                {
                    for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="DEBIT_AMOUNT"]/VALUE
                    return
                        <AMOUNT>{ data($VALUE) }</AMOUNT>
                }
                {
                    for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="ACH_ACCT_TYPE"]/VALUE
                    return
                        <IDPRODUCT>{ data($VALUE) }</IDPRODUCT>
                }
            </FICOHNACHONLINECOMISIONACHWSType>
        </ns1:ConsultadecomisionACH_Validate>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaComisiones as element(ns0:consultaComisiones) external;

xf:consultaComisionesLocalIn($requestHeader,
    $consultaComisiones)