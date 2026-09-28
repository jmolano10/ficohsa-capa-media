(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$simulaPagoChequeCompensacion" element="ns1:simulaPagoChequeCompensacion" location="../xsd/simulaPagoChequeCompensacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Simulapagodechqporcompensacion_Validate" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/simulaPagoChequeCompensacionTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SimulaPagoChequeCompensacion/xq/simulaPagoChequeCompensacionIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare function xf:simulaPagoChequeCompensacionIn($requestHeader as element(ns2:RequestHeader),
    $simulaPagoChequeCompensacion as element(ns1:simulaPagoChequeCompensacion))
    as element(ns0:Simulapagodechqporcompensacion_Validate) {
        <ns0:Simulapagodechqporcompensacion_Validate>
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
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            {
                let $simulaPagoChequeCompensacion := $simulaPagoChequeCompensacion
                return
                    <FICOINWARDCLEARINGPREVALIDATEType id = "">
                        <ROUTECODE>{ data($simulaPagoChequeCompensacion/ROUTE_CODE) }</ROUTECODE>
                        <CLGACCOUNTNUMBER>{ data($simulaPagoChequeCompensacion/ACCOUNT_NUMBER) }</CLGACCOUNTNUMBER>
                        <CHEQUENUMBER>{ data($simulaPagoChequeCompensacion/CHEQUE_NUMBER) }</CHEQUENUMBER>
                        <CHEQUECCY>{ data($simulaPagoChequeCompensacion/CURRENCY) }</CHEQUECCY>
                        <CHEQUEAMOUNT>{ data($simulaPagoChequeCompensacion/AMOUNT) }</CHEQUEAMOUNT>
                        <CLRINGCENTRCODE>{ data($simulaPagoChequeCompensacion/COST_CENTER_CODE) }</CLRINGCENTRCODE>
                    </FICOINWARDCLEARINGPREVALIDATEType>
            }
        </ns0:Simulapagodechqporcompensacion_Validate>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $simulaPagoChequeCompensacion as element(ns1:simulaPagoChequeCompensacion) external;

xf:simulaPagoChequeCompensacionIn($requestHeader,
    $simulaPagoChequeCompensacion)