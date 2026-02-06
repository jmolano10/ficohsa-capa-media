xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaExtraATMRequest" element="ns1:consultaExtraATMRequest" location="../xsd/consultaExtraATMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMaestraTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaExtraATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExtraATM/xq/consultaMaestraTarjetaDebitoInV2/";
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


declare function xf:consultaMaestraTarjetaDebitoIn(
	$debitCardNumber as xs:string,
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
                    <criteriaValue>{ fn:concat("...", $debitCardNumber) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns0:ConsultaMaestraTarjetaDebito>
};

declare variable $debitCardNumber as xs:string external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

xf:consultaMaestraTarjetaDebitoIn($debitCardNumber,
    $userName,
    $password)