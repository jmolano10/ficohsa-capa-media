(:: pragma bea:global-element-parameter parameter="$colocacionExtraATMRequest" element="ns1:colocacionExtraATMRequest" location="../xsd/colocacionExtraATMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMaestraTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/colocacionExtraATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ColocacionExtraATM/xq/consultaMaestraTarjetaDebitoIn/";
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

declare function xf:consultaMaestraTarjetaDebitoIn($colocacionExtraATMRequest as element(ns1:colocacionExtraATMRequest),
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
                    <criteriaValue>{ concat("...",data($colocacionExtraATMRequest/DEBIT_CARD)) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns0:ConsultaMaestraTarjetaDebito>
};

declare variable $colocacionExtraATMRequest as element(ns1:colocacionExtraATMRequest) external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

xf:consultaMaestraTarjetaDebitoIn($colocacionExtraATMRequest,
    $userName,
    $password)