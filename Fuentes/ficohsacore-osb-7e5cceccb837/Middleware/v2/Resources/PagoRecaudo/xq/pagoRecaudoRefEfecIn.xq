(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns2:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Pagoderecaudoreferenciadoefec" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoRefEfecIn/";

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

declare function xf:pagoRecaudoRefEfecIn($pagoRecaudo as element(ns2:pagoRecaudo),
    $requestHeader as element(ns0:RequestHeader),
    $uuid as xs:string)
    as element(ns1:Pagoderecaudoreferenciadoefec) {
		<ns1:Pagoderecaudoreferenciadoefec>
	            <WebRequestCommon>
                	<userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),data($requestHeader/Authentication/UserName)) }</userName>
                	<password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),data($requestHeader/Authentication/Password)) }</password>
	            </WebRequestCommon>
	            <OfsFunction>
	            	<gtsControl></gtsControl>
	                <messageId>{ $uuid }</messageId>
	                <noOfAuth>1</noOfAuth>
					<replace></replace>                
	            </OfsFunction>
	            <TELLERREFCOLLCASHWSCOPYType>
	                <CURRENCY1>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</CURRENCY1>
	                <LRPAYCODE>{ data($pagoRecaudo/DEBTOR_CODE) }</LRPAYCODE>
	                <gLRINVOICENO>
	                    <mLRINVOICENO>
	                        <LRINVOICENO>
	                            {
	                                if (data($pagoRecaudo/BILL_INFORMATION/BILL_NUMBER) != "") then
	                                    (data($pagoRecaudo/BILL_INFORMATION/BILL_NUMBER))
	                                else 
	                                    data($pagoRecaudo/DEBTOR_CODE)
	                            }
							</LRINVOICENO>
	                        <LRDUEDATE>20140708</LRDUEDATE>
	                        <LRAMT>{ concat(data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) , $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</LRAMT>
	                        <LRPAYYN>Y</LRPAYYN>
	                    </mLRINVOICENO>
	                </gLRINVOICENO>
	                <gLRTAXPAYNAME>
	                    <LRTAXPAYNAME>{ data($pagoRecaudo/DEBTOR_CODE) }</LRTAXPAYNAME>
	                </gLRTAXPAYNAME>
	                <LRAGCLIENTID>{ data($pagoRecaudo/CONTRACT_ID) }</LRAGCLIENTID>
	            </TELLERREFCOLLCASHWSCOPYType>
		</ns1:Pagoderecaudoreferenciadoefec>
};

declare variable $pagoRecaudo as element(ns2:pagoRecaudo) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $uuid as xs:string external;

xf:pagoRecaudoRefEfecIn($pagoRecaudo,
    $requestHeader,
    $uuid)