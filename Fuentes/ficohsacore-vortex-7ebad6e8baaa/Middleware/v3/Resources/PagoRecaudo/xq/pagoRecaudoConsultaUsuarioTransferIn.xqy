xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns1:FUNDSTRANSFERType" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadeusuariosdelsistema" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoRecaudo/xq/pagoRecaudoConsultaUsuarioTransferIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
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
 
declare function xf:pagoRecaudoConsultaUsuarioTransferIn($requestHeader as element(ns0:RequestHeader),
    $fUNDSTRANSFERType as element())
    as element(ns1:Consultadeusuariosdelsistema) {
        <ns1:Consultadeusuariosdelsistema>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        let $result :=
                            for $INPUTTER in $fUNDSTRANSFERType/gINPUTTER/INPUTTER
                            return
                                <criteriaValue>{ fn:tokenize(data($INPUTTER), "_")[2] }</criteriaValue>
                        return
                            $result[1]
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns1:Consultadeusuariosdelsistema>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $fUNDSTRANSFERType as element() external;

xf:pagoRecaudoConsultaUsuarioTransferIn($requestHeader,
    $fUNDSTRANSFERType)