xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaTDCliente" element="ns1:consultaTDCliente" location="../xsd/consultaTDClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ConsultaMaestraTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTDCliente/xq/consultaTDClienteIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTDClienteTypes";

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
 
declare function getCardStatus($cardStatus as xs:string) as xs:string {
	if ($cardStatus = "ISSUED") then ("90")
    elseif ($cardStatus = "RETURNED") then ("91")
    elseif ($cardStatus = "SCRAP") then ("92")
    elseif ($cardStatus = "CANCEL") then ("93")
    elseif ($cardStatus = "ACTIVE") then ("94")
    elseif ($cardStatus = "DESTROYED") then ("95")
    elseif ($cardStatus = "BLOCKED") then ("96")
    else("")
};

declare function xf:consultaTDClienteIn($requestHeader as element(ns0:RequestHeader),
    $consultaTDCliente as element(ns1:consultaTDCliente))
    as element(ns2:ConsultaMaestraTarjetaDebito) {
    	if (data($consultaTDCliente/CARD_STATUS) != "ALL") then
        (
        <ns2:ConsultaMaestraTarjetaDebito>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICODEBITCARDCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($consultaTDCliente/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>CARD.STATUS</columnName>
                    <criteriaValue>{ getCardStatus(data($consultaTDCliente/CARD_STATUS)) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
            {
               if (data($consultaTDCliente/ACCOUNT)!="" ) then 
               (
                <enquiryInputCollection>
                    <columnName>ACCOUNT</columnName>
                    <criteriaValue>{$consultaTDCliente/ACCOUNT/text()}</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                
                )
                else()
                }
        </ns2:ConsultaMaestraTarjetaDebito>
       ) else (
       	<ns2:ConsultaMaestraTarjetaDebito>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICODEBITCARDCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($consultaTDCliente/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection> 
            </WSFICODEBITCARDCUSTOMERType>
        </ns2:ConsultaMaestraTarjetaDebito>
       
       )
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaTDCliente as element(ns1:consultaTDCliente) external;

xf:consultaTDClienteIn($requestHeader,
    $consultaTDCliente)