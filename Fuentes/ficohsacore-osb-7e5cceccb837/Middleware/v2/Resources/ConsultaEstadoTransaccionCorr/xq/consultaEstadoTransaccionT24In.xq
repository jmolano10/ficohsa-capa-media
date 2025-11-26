(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion" element="ns2:consultaEstadoTransaccion" location="../xsd/consultaEstadoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaEstadoTransaccion" location="../../../BusinessServices/T24/svcConsultaEstadoTransaccion/xsd/svcConsultaEstadoTransaccionTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoTransaccionTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/consultaEstadoTransaccionT24In/";

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

declare function xf:consultaEstadoTransaccionT24In($requestHeader as element(ns0:RequestHeader),
    $consultaEstadoTransaccion as element(ns2:consultaEstadoTransaccion))
    as element(ns1:ConsultaEstadoTransaccion) {
        <ns1:ConsultaEstadoTransaccion>
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
            <WSFICOCONSULTATRXTENGOType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaEstadoTransaccion/CODIGO_UNICO_TRANSACCION) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOCONSULTATRXTENGOType>
        </ns1:ConsultaEstadoTransaccion>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaEstadoTransaccion as element(ns2:consultaEstadoTransaccion) external;

xf:consultaEstadoTransaccionT24In($requestHeader,
    $consultaEstadoTransaccion)
