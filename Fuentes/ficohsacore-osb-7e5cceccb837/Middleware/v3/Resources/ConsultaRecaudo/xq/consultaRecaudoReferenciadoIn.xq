xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns2:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Pagoderecaudoreferenciadoefec_Validate" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/consultaRecaudoReferenciadoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:consultaRecaudoReferenciadoIn($requestHeader as element(ns0:RequestHeader),
    $consultaRecaudo as element(ns2:consultaRecaudo))
    as element(ns1:Pagoderecaudoreferenciadoefec_Validate) {
        <ns1:Pagoderecaudoreferenciadoefec_Validate>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <TELLERREFCOLLCASHWSCOPYType>
                <CURRENCY1>{ data($consultaRecaudo/CURRENCY) }</CURRENCY1>
                <LRPAYCODE>{ data($consultaRecaudo/DEBTOR_CODE) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>123</LRINVOICENO>
                        <LRDUEDATE>{ data($consultaRecaudo/BILL_DATE) }</LRDUEDATE>
                        <LRAMT>{ concat($consultaRecaudo/CURRENCY , $consultaRecaudo/BILL_AMOUNT) }</LRAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>BANCO FICOHSA</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($consultaRecaudo/CONTRACT_ID) }</LRAGCLIENTID>
            </TELLERREFCOLLCASHWSCOPYType>
        </ns1:Pagoderecaudoreferenciadoefec_Validate>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaRecaudo as element(ns2:consultaRecaudo) external;

xf:consultaRecaudoReferenciadoIn($requestHeader,
    $consultaRecaudo)