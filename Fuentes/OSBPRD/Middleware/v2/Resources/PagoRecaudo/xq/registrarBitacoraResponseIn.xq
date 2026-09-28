(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns2:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoResponse" element="ns0:pagoRecaudoResponse" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registroBitacoraConvenio" location="../../../BusinessServices/registroBitacoraConvenios/xsd/registroBitacoraConvenios.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/registrarBitacoraResponseIn/";

declare function xf:RegistrarBitacoraResponseIn($requestHeader as element(ns2:RequestHeader) ?,
    $pagoRecaudo as element(ns0:pagoRecaudo) ?,
    $responseHeader as element(ns2:ResponseHeader) ?,
    $pagoRecaudoResponse as element(ns0:pagoRecaudoResponse) ?,
    $uuidBitacora as xs:string ?,
    $dateTimeBitacora as xs:string ?,
    $traceProxy as xs:string ?,
    $uuidBitacoraRequest as xs:string ?)
    as element(ns1:registroBitacoraConvenio) {
        <ns1:registroBitacoraConvenio>
            <LOG_UUID>{ $uuidBitacora }</LOG_UUID>
            <LOG_TYPE>RESPONSE</LOG_TYPE>
            <CONTRACT_ID>{ data($pagoRecaudo/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoRecaudo/DEBTOR_CODE) }</DEBTOR_CODE>
            <OPERATION_CODE>2</OPERATION_CODE>
            <USER>{ data($requestHeader/Authentication/UserName) }</USER>
            <DATE_TIME>{ $dateTimeBitacora }</DATE_TIME>
            <SOAP_MESSAGE>{ $pagoRecaudoResponse }</SOAP_MESSAGE>
            <REQUEST_LOG_UUID>{ $uuidBitacoraRequest }</REQUEST_LOG_UUID>
            {
                for $successIndicator in $responseHeader/successIndicator
                return
                    <ERROR_CODE>{ data($successIndicator) }</ERROR_CODE>
            }
            {
                let $result :=
                    for $messages in $responseHeader/messages
                    return
                        if (empty($messages/text())) then (
                        	<ERROR_MESSAGE>{ data($messages) }</ERROR_MESSAGE>
                        ) else ( 
                        	<ERROR_MESSAGE>{ concat(substring(data($messages),1,70),"; ",$traceProxy) }</ERROR_MESSAGE>
                        )
                return
                    $result[1]
            }
        </ns1:registroBitacoraConvenio>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;
declare variable $responseHeader as element(ns2:ResponseHeader) external;
declare variable $pagoRecaudoResponse as element(ns0:pagoRecaudoResponse) external;
declare variable $uuidBitacora as xs:string external;
declare variable $dateTimeBitacora as xs:string external;
declare variable $traceProxy as xs:string external;
declare variable $uuidBitacoraRequest as xs:string external;

xf:RegistrarBitacoraResponseIn($requestHeader,
    $pagoRecaudo,
    $responseHeader,
    $pagoRecaudoResponse,
    $uuidBitacora,
    $dateTimeBitacora,
    $traceProxy,
    $uuidBitacoraRequest)