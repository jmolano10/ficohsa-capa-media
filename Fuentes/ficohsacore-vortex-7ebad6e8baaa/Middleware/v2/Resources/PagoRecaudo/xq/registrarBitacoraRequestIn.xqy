xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registroBitacoraConvenio" location="../../../BusinessServices/registroBitacoraConvenios/xsd/registroBitacoraConvenios.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/registrarBitacoraRequestIn/";

declare function xf:RegistrarBitacoraRequestIn($requestHeader as element(ns2:RequestHeader) ?,
    $pagoRecaudo as element(ns0:pagoRecaudo) ?,
    $uuid as xs:string ?,
    $dateTime as xs:string ?)
    as element(ns1:registroBitacoraConvenio) {
        <ns1:registroBitacoraConvenio>
            <LOG_UUID>{ $uuid }</LOG_UUID>
            <LOG_TYPE>REQUEST</LOG_TYPE>
            <CONTRACT_ID>{ data($pagoRecaudo/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoRecaudo/DEBTOR_CODE) }</DEBTOR_CODE>
            <OPERATION_CODE>2</OPERATION_CODE>
            <USER>{ data($requestHeader/Authentication/UserName) }</USER>
            <DATE_TIME>{ $dateTime }</DATE_TIME>
            <SOAP_MESSAGE>{ $pagoRecaudo }</SOAP_MESSAGE>
        </ns1:registroBitacoraConvenio>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;
declare variable $uuid as xs:string external;
declare variable $dateTime as xs:string external;

xf:RegistrarBitacoraRequestIn($requestHeader,
    $pagoRecaudo,
    $uuid,
    $dateTime)