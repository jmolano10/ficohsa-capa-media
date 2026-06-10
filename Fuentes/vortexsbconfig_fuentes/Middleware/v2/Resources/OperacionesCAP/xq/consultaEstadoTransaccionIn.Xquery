<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransferenciaCAPRequest" element="ns1:consultaEstadoTransferenciaCAPRequest" location="../xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaEstadoTransaccion" location="../../../BusinessServices/T24/svcConsultaEstadoTransaccion/xsd/svcConsultaEstadoTransaccionTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/consultaEstadoTransaccionIn/";

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

declare function xf:consultaEstadoTransaccionIn($consultaEstadoTransferenciaCAPRequest as element(ns1:consultaEstadoTransferenciaCAPRequest),
    $requestHeader as element(ns2:RequestHeader))
    as element(ns0:ConsultaEstadoTransaccion) {
        <ns0:ConsultaEstadoTransaccion>
            <WebRequestCommon>
                <userName>
					{
                			fn-bea:fail-over(getUsername(data($requestHeader/Authentication/UserName)),
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
                    <criteriaValue>{ data($consultaEstadoTransferenciaCAPRequest/UUID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOCONSULTATRXTENGOType>
        </ns0:ConsultaEstadoTransaccion>
};

declare variable $consultaEstadoTransferenciaCAPRequest as element(ns1:consultaEstadoTransferenciaCAPRequest) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:consultaEstadoTransaccionIn($consultaEstadoTransferenciaCAPRequest,
    $requestHeader)]]></con:xquery>
    <con:dependency location="../xsd/operacionesCAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCAP/xsd/operacionesCAPTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/T24/svcConsultaEstadoTransaccion/xsd/svcConsultaEstadoTransaccionTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/svcConsultaEstadoTransaccion/xsd/svcConsultaEstadoTransaccionTypes"/>
    </con:dependency>
</con:xqueryEntry>