(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAbanks1" element="ns1:pagoRecaudoAbanks" location="../../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registroBitacoraConvenio" location="../../../xsds/RegistroBitacoraConvenio/RegistroBitacoraConvenio.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAbanksTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecAbanksRegistrarBitacoraReqIn/";

declare function xf:pagoRecAbanksRegistrarBitacoraReqIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudoAbanks1 as element(ns1:pagoRecaudoAbanks),
    $uuid as xs:string,
    $dateTime as xs:string)
    as element(ns0:registroBitacoraConvenio) {
        <ns0:registroBitacoraConvenio>
            <LOG_UUID>{ $uuid }</LOG_UUID>
            <LOG_TYPE>REQUEST</LOG_TYPE>
            <CONTRACT_ID>{ data($pagoRecaudoAbanks1/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoRecaudoAbanks1/DEBTOR_CODE) }</DEBTOR_CODE>
            <OPERATION_CODE>2</OPERATION_CODE>
            <USER>{ data($autenticacionRequestHeader1/UserName) }</USER>
            <DATE_TIME>{ $dateTime }</DATE_TIME>
			<SOAP_MESSAGE>{ $pagoRecaudoAbanks1 }</SOAP_MESSAGE>
        </ns0:registroBitacoraConvenio>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoAbanks1 as element(ns1:pagoRecaudoAbanks) external;
declare variable $uuid as xs:string external;
declare variable $dateTime as xs:string external;

xf:pagoRecAbanksRegistrarBitacoraReqIn($autenticacionRequestHeader1,
    $pagoRecaudoAbanks1,
    $uuid,
    $dateTime)