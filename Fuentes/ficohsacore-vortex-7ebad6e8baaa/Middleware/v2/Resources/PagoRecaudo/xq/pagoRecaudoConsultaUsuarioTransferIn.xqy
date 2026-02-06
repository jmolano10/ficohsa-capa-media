xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:local-element-parameter parameter="$requestHeader" type="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$fUNDSTRANSFERType1" type="ns0:PagoderecaudolocalylineadbctaResponse/FUNDSTRANSFERType" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoConsultaUsuarioTransferIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare function xf:pagoRecaudoConsultaUsuarioTransferIn($requestHeader as element(ns1:RequestHeader),
    $fUNDSTRANSFERType1 as element())
    as element(ns0:Consultadeusuariosdelsistema) {<ns0:Consultadeusuariosdelsistema>
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
                            for $INPUTTER in $fUNDSTRANSFERType1/gINPUTTER/INPUTTER
                            return
                                <criteriaValue>{ fn:tokenize(data($INPUTTER), "_")[2] }</criteriaValue>
                        return
                            $result[1]
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $fUNDSTRANSFERType1 as element() external;

xf:pagoRecaudoConsultaUsuarioTransferIn($requestHeader,
    $fUNDSTRANSFERType1)