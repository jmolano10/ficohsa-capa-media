(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAbanks1" element="ns0:consultaRecaudoAbanks" location="../../../xsds/ConsultaRecaudoAbanks/ConsultaRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAbanksResponse1" element="ns0:consultaRecaudoAbanksResponse" location="../../../xsds/ConsultaRecaudoAbanks/ConsultaRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registroBitacoraConvenio" location="../../../xsds/RegistroBitacoraConvenio/RegistroBitacoraConvenio.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAbanksTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAbanks/v2/ConsRecAbanksRegistroBitacoraRspIn/";

declare function xf:ConsRecAbanksRegistroBitacoraRspIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudoAbanks1 as element(ns0:consultaRecaudoAbanks),
    $responseHeader1 as element(ns2:ResponseHeader),
    $consultaRecaudoAbanksResponse1 as element(ns0:consultaRecaudoAbanksResponse),
    $uuidBitacora as xs:string,
    $dateTimeBitacora as xs:string,
    $traceProxy as xs:string,
    $uuidBitacoraRequest as xs:string)
    as element(ns1:registroBitacoraConvenio) {
        <ns1:registroBitacoraConvenio>
            <LOG_UUID>{ $uuidBitacora }</LOG_UUID>
            <LOG_TYPE>RESPONSE</LOG_TYPE>
            <CONTRACT_ID>{ data($consultaRecaudoAbanks1/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($consultaRecaudoAbanks1/DEBTOR_CODE) }</DEBTOR_CODE>
            <OPERATION_CODE>1</OPERATION_CODE>
            <USER>{ data($autenticacionRequestHeader1/UserName) }</USER>
            <DATE_TIME>{ $dateTimeBitacora }</DATE_TIME>
            <SOAP_MESSAGE>{ $consultaRecaudoAbanksResponse1 }</SOAP_MESSAGE>
            <REQUEST_LOG_UUID>{ $uuidBitacoraRequest }</REQUEST_LOG_UUID>
            {
                for $successIndicator in $responseHeader1/successIndicator
                return
                    <ERROR_CODE>{ data($successIndicator) }</ERROR_CODE>
            }
            {
                let $result :=
                    for $messages in $responseHeader1/messages
                    return
                        <ERROR_MESSAGE>{ data($messages) }</ERROR_MESSAGE>
                return
                    $result[1]
            }
        </ns1:registroBitacoraConvenio>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudoAbanks1 as element(ns0:consultaRecaudoAbanks) external;
declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $consultaRecaudoAbanksResponse1 as element(ns0:consultaRecaudoAbanksResponse) external;
declare variable $uuidBitacora as xs:string external;
declare variable $dateTimeBitacora as xs:string external;
declare variable $traceProxy as xs:string external;
declare variable $uuidBitacoraRequest as xs:string external;

xf:ConsRecAbanksRegistroBitacoraRspIn($autenticacionRequestHeader1,
    $consultaRecaudoAbanks1,
    $responseHeader1,
    $consultaRecaudoAbanksResponse1,
    $uuidBitacora,
    $dateTimeBitacora,
    $traceProxy,
    $uuidBitacoraRequest)