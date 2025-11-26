(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAbanks1" element="ns1:pagoRecaudoAbanks" location="../../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAbanksResponse1" element="ns1:pagoRecaudoAbanksResponse" location="../../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registroBitacoraConvenio" location="../../../xsds/RegistroBitacoraConvenio/RegistroBitacoraConvenio.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAbanksTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecaudoAbanksRegistrarBitacoraRspIn/";

declare function xf:pagoRecaudoAbanksRegistrarBitacoraRspIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudoAbanks1 as element(ns1:pagoRecaudoAbanks),
    $responseHeader1 as element(ns2:ResponseHeader),
    $pagoRecaudoAbanksResponse1 as element(ns1:pagoRecaudoAbanksResponse),
    $uuidBitacora as xs:string,
    $dateTimeBitacora as xs:string,
    $uuidBitacoraRequest as xs:string)
    as element(ns0:registroBitacoraConvenio) {
        <ns0:registroBitacoraConvenio>
            <LOG_UUID>{ $uuidBitacora }</LOG_UUID>
            <LOG_TYPE>RESPONSE</LOG_TYPE>
            <CONTRACT_ID>{ data($pagoRecaudoAbanks1/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoRecaudoAbanks1/DEBTOR_CODE) }</DEBTOR_CODE>
            <OPERATION_CODE>2</OPERATION_CODE>
            <USER>{ data($autenticacionRequestHeader1/UserName) }</USER>
            <DATE_TIME>{ $dateTimeBitacora }</DATE_TIME>
            <SOAP_MESSAGE>{ $pagoRecaudoAbanksResponse1 }</SOAP_MESSAGE>
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
        </ns0:registroBitacoraConvenio>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoAbanks1 as element(ns1:pagoRecaudoAbanks) external;
declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $pagoRecaudoAbanksResponse1 as element(ns1:pagoRecaudoAbanksResponse) external;
declare variable $uuidBitacora as xs:string external;
declare variable $dateTimeBitacora as xs:string external;
declare variable $uuidBitacoraRequest as xs:string external;

xf:pagoRecaudoAbanksRegistrarBitacoraRspIn($autenticacionRequestHeader1,
    $pagoRecaudoAbanks1,
    $responseHeader1,
    $pagoRecaudoAbanksResponse1,
    $uuidBitacora,
    $dateTimeBitacora,
    $uuidBitacoraRequest)