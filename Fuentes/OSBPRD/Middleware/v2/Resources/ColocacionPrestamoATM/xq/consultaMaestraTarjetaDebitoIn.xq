(:: pragma bea:global-element-parameter parameter="$colocacionPrestamoATMRequest" element="ns1:colocacionPrestamoATMRequest" location="../xsd/colocacionPrestamoATMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMaestraTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/colocacionPrestamoATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ColocacionPrestamoATM/xq/consultaMaestraTarjetaDebitoIn/";
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

declare function xf:consultaMaestraTarjetaDebitoIn($colocacionPrestamoATMRequest as element(ns1:colocacionPrestamoATMRequest),
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
                    <criteriaValue>{ concat("...",data($colocacionPrestamoATMRequest/DEBIT_CARD)) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns0:ConsultaMaestraTarjetaDebito>
};

declare variable $colocacionPrestamoATMRequest as element(ns1:colocacionPrestamoATMRequest) external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

xf:consultaMaestraTarjetaDebitoIn($colocacionPrestamoATMRequest,
    $userName,
    $password)