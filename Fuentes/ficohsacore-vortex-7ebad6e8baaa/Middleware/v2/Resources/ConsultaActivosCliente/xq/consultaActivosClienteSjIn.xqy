xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns1:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteRequest" element="ns3:consultaActivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:sjConsultaActivosClienteRequest" location="../../../../Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosCliente.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteSjIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";

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

declare function xf:consultaActivosClienteSjIn($requestHeader as element(ns0:RequestHeader),
    $consultadeclienteResponse as element(ns1:ConsultadeclienteResponse),
    $consultaActivosClienteRequest as element(ns3:consultaActivosClienteRequest),
    $legalIdType as xs:string)
    as element(ns2:sjConsultaActivosClienteRequest) {
        <ns2:sjConsultaActivosClienteRequest>
            <ns2:USERNAME>
                {
                    fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                    data($requestHeader/Authentication/UserName))
                }
			</ns2:USERNAME>
            <ns2:PASSWORD>
                {
                    fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                    data($requestHeader/Authentication/Password))
                }
			</ns2:PASSWORD>
            <ns2:CUSTOMER_ID>{ data($consultaActivosClienteRequest/CUSTOMER_ID) }</ns2:CUSTOMER_ID>
            {
            	if($legalIdType != "") then (
            		<ns2:LEGAL_ID_TYPE>{ $legalIdType }</ns2:LEGAL_ID_TYPE>
            	) else ()
            }
            {
            for $LEGALID in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID
            return
            	<ns2:LEGAL_ID>{ data($LEGALID) }</ns2:LEGAL_ID>
            }
        </ns2:sjConsultaActivosClienteRequest>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultadeclienteResponse as element(ns1:ConsultadeclienteResponse) external;
declare variable $consultaActivosClienteRequest as element(ns3:consultaActivosClienteRequest) external;
declare variable $legalIdType as xs:string external;

xf:consultaActivosClienteSjIn($requestHeader,
    $consultadeclienteResponse,
    $consultaActivosClienteRequest,
    $legalIdType)