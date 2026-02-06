xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registroBitacoraConvenio" location="../../../BusinessServices/registroBitacoraConvenios/xsd/registroBitacoraConvenios.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/registrarBitacoraRequestIn/";

declare function xf:consultaRecaudoRegistrarBitacoraRequestIn($requestHeader as element(ns2:RequestHeader) ?,
    $consultaRecaudo as element(ns0:consultaRecaudo) ?,
    $uuid as xs:string ?,
    $dateTime as xs:string ?)
    as element(ns1:registroBitacoraConvenio) {
        <ns1:registroBitacoraConvenio>
            <LOG_UUID>{ $uuid }</LOG_UUID>
            <LOG_TYPE>REQUEST</LOG_TYPE>
            <CONTRACT_ID>{ data($consultaRecaudo/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($consultaRecaudo/DEBTOR_CODE) }</DEBTOR_CODE>
            <OPERATION_CODE>1</OPERATION_CODE>
            <USER>{ data($requestHeader/Authentication/UserName) }</USER>
            <DATE_TIME>{ $dateTime }</DATE_TIME>
            <SOAP_MESSAGE>{ $consultaRecaudo }</SOAP_MESSAGE>
        </ns1:registroBitacoraConvenio>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaRecaudo as element(ns0:consultaRecaudo) external;
declare variable $uuid as xs:string external;
declare variable $dateTime as xs:string external;

xf:consultaRecaudoRegistrarBitacoraRequestIn($requestHeader,
    $consultaRecaudo,
    $uuid,
    $dateTime)