(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAbanks1" element="ns0:consultaRecaudoAbanks" location="../../../xsds/ConsultaRecaudoAbanks/ConsultaRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registroBitacoraConvenio" location="../../../xsds/RegistroBitacoraConvenio/RegistroBitacoraConvenio.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAbanksTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAbanks/v2/ConsRecAbanksRegistroBitacoraIn/";

declare function xf:ConsRecAbanksRegistroBitacoraIn($consultaRecaudoAbanks1 as element(ns0:consultaRecaudoAbanks),
    $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $uuid as xs:string,
    $dateTime as xs:string)
    as element(ns1:registroBitacoraConvenio) {
        <ns1:registroBitacoraConvenio>
            <LOG_UUID>{ $uuid }</LOG_UUID>
            <LOG_TYPE>REQUEST</LOG_TYPE>
            <CONTRACT_ID>{ data($consultaRecaudoAbanks1/CONTRACT_ID) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($consultaRecaudoAbanks1/DEBTOR_CODE) }</DEBTOR_CODE>
            <OPERATION_CODE>1</OPERATION_CODE>
            <USER>{ data($autenticacionRequestHeader1/UserName) }</USER>
            <DATE_TIME>{ $dateTime }</DATE_TIME>
            <SOAP_MESSAGE>{ $consultaRecaudoAbanks1 }</SOAP_MESSAGE>
        </ns1:registroBitacoraConvenio>
};

declare variable $consultaRecaudoAbanks1 as element(ns0:consultaRecaudoAbanks) external;
declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $uuid as xs:string external;
declare variable $dateTime as xs:string external;

xf:ConsRecAbanksRegistroBitacoraIn($consultaRecaudoAbanks1,
    $autenticacionRequestHeader1,
    $uuid,
    $dateTime)