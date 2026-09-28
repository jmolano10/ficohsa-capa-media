(:: pragma bea:global-element-parameter parameter="$consultaDetalleTarjetas" element="ns0:consultaDetalleTarjetas" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadetalletarjetas" location="../../../BusinessServices/T24/svcConsultaDetalleTarjetas/xsd/XMLSchema_-271592632.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleTarjetas/xq/consultadetalletarjetasHNIn/";

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

declare function xf:consultadetalletarjetasHNIn($requestHeader as element(ns2:RequestHeader),
	$consultaDetalleTarjetas as element(ns0:consultaDetalleTarjetas))
    as element(ns1:Consultadetalletarjetas) {
        <ns1:Consultadetalletarjetas>
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
            <WSFICOCARDDETAILType>
                {
	                <enquiryInputCollection>
	                    <columnName>CARD.NUMBER</columnName>
	                    <criteriaValue>{ fn:string-join(data($consultaDetalleTarjetas/CARD_NUMBERS/CARD_NUMBER_ITEM/CARD_NUMBER), '||') }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
                }
            </WSFICOCARDDETAILType>
        </ns1:Consultadetalletarjetas>
};

declare variable $consultaDetalleTarjetas as element(ns0:consultaDetalleTarjetas) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:consultadetalletarjetasHNIn($requestHeader,
	$consultaDetalleTarjetas)