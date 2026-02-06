xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registraParametrizacion" element="ns2:registraParametrizacion" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RegistraParametrizacionBancos" location="../../../BusinessServices/T24/RegistraParametrizacion/xsd/registraParametrizacion.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraParametrizacion/xq/registraParametrizacionBancosIn/";

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

declare function xf:registraParametrizacionBancosIn($requestHeader1 as element(ns0:RequestHeader),
    $registraParametrizacion as element(ns2:registraParametrizacion))
    as element(ns1:RegistraParametrizacionBancos) {
        <ns1:RegistraParametrizacionBancos>
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
	            <gtsControl/>
	            <messageId/>
	            <noOfAuth/>
	            <replace/>
            </OfsFunction>             
            <FICOHACHBANKBENACCOUNTINPUTWSType id = "{ data($registraParametrizacion/ID_CEPROBAN) }">
                <gDESCRIPTION>
                    {
                        for $NAME in $registraParametrizacion/NAME
                        return
                            <DESCRIPTION>{ data($NAME) }</DESCRIPTION>
                    }
                </gDESCRIPTION>
                <gPAYTYPE>
                    {
                        for $PRODUCT_TYPE in $registraParametrizacion/PRODUCT_TYPE
                        return
                            <mPAYTYPE>
                                {
                                    for $TYPE in $PRODUCT_TYPE/TYPE
                                    return
                                        <PAYTYPE>{ data($TYPE) }</PAYTYPE>
                                }
                                {
                                    for $MIN_LENGTH in $PRODUCT_TYPE/MIN_LENGTH
                                    return
                                        <MINIMUMLENGTH>{ data($MIN_LENGTH) }</MINIMUMLENGTH>
                                }
                                {
                                    for $MAX_LENGTH in $PRODUCT_TYPE/MAX_LENGTH
                                    return
                                        <MAXIMUMLENGTH>{ data($MAX_LENGTH) }</MAXIMUMLENGTH>
                                }
                                {
                                    for $LEAD_ZERO in $PRODUCT_TYPE/LEAD_ZERO
                                    return
                                        <LEADINGZEROS>{ data($LEAD_ZERO) }</LEADINGZEROS>
                                }
                                <ADDERR>{ data($PRODUCT_TYPE/MESSAGE_ERROR) }</ADDERR>
                            </mPAYTYPE>
                    }
                </gPAYTYPE>
                <gACHROUTCURRENCY>
                    {
                        for $ROUTE in $registraParametrizacion/ROUTE
                        return
                            <mACHROUTCURRENCY>
                                <ACHROUTCURRENCY>{ data($ROUTE/ROUTE_CURRENCY) }</ACHROUTCURRENCY>
                                <ACHROUTINGNUM>{ data($ROUTE/ROUTE_NUMBER) }</ACHROUTINGNUM>
                            </mACHROUTCURRENCY>
                    }
                </gACHROUTCURRENCY>
                {
                    for $BANK_STATUS in $registraParametrizacion/BANK_STATUS
                    return
                        <STATUSBANK>{ data($BANK_STATUS) }</STATUSBANK>
                }
                {
                    for $OPERATION_TYPE in $registraParametrizacion/OPERATION_TYPE
                    return
	                    if(fn:data(fn:upper-case(fn:string( $OPERATION_TYPE)))= 'BANK')
	                    then
	                        <ISPI>NO</ISPI>
	                    else if(fn:data(fn:upper-case(fn:string( $OPERATION_TYPE)))= 'PI')
	                    then
	                    	<ISPI>SI</ISPI>
	                    else()
                }                
                {
                    for $ID_BANK_CEPROBAN in $registraParametrizacion/ID_BANK_CEPROBAN
                    return
                        <PIBANK>{ data($ID_BANK_CEPROBAN) }</PIBANK>
                }
            </FICOHACHBANKBENACCOUNTINPUTWSType>
        </ns1:RegistraParametrizacionBancos>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $registraParametrizacion as element(ns2:registraParametrizacion) external;

xf:registraParametrizacionBancosIn($requestHeader1,
    $registraParametrizacion)