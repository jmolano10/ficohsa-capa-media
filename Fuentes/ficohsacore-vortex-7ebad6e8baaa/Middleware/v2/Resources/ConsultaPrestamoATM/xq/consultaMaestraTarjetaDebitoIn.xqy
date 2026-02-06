xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPrestamoATMRequest" element="ns1:consultaPrestamoATMRequest" location="../xsd/consultaPrestamoATMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMaestraTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPrestamoATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPrestamoATM/xq/consultaMaestraTarjetaDebitoIn/";
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

declare function xf:consultaMaestraTarjetaDebitoIn($consultaPrestamoATMRequest as element(ns1:consultaPrestamoATMRequest),
    $userName as xs:string,
    $password as xs:string)
    as element(ns0:ConsultaMaestraTarjetaDebito) {
        <ns0:ConsultaMaestraTarjetaDebito>
            <WebRequestCommon>
                <userName>
                {
                	fn-bea:fail-over( getUsername($userName),$userName)
                }
                </userName>
                <password>
                {
                	fn-bea:fail-over( getPassword($userName), $password)
                }
                </password>
            </WebRequestCommon>
            <WSFICODEBITCARDCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ fn:concat("...", fn:data($consultaPrestamoATMRequest/PRODUCT_VALUE)) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns0:ConsultaMaestraTarjetaDebito>
};

declare variable $consultaPrestamoATMRequest as element(ns1:consultaPrestamoATMRequest) external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

xf:consultaMaestraTarjetaDebitoIn($consultaPrestamoATMRequest,
    $userName,
    $password)