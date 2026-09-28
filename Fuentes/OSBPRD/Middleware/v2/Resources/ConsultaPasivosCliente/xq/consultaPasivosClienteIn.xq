(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaPasivosClienteRequest" location="../../../BusinessServices/SJS/consultaPasivosCliente/xsd/sjConsultaPasivosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteIn/";

declare function xf:consultaPasivosClienteIn($requestHeader1 as element(ns1:RequestHeader),
    $customerId as xs:string,
    $legalId as xs:string,
    $codigoPais as xs:string)
    as element(ns0:sjConsultaPasivosClienteRequest) {
        <ns0:sjConsultaPasivosClienteRequest>
            <ns0:USERNAME>{ data($requestHeader1/Authentication/UserName) }</ns0:USERNAME>
            <ns0:PASSWORD>{ data($requestHeader1/Authentication/Password) }</ns0:PASSWORD>
            <ns0:CUSTOMER_ID>{ $customerId }</ns0:CUSTOMER_ID>
            <ns0:LEGAL_ID>{ $legalId }</ns0:LEGAL_ID>
            <ns0:COUNTRY>{ $codigoPais }</ns0:COUNTRY>
        </ns0:sjConsultaPasivosClienteRequest>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $customerId as xs:string external;
declare variable $legalId as xs:string external;
declare variable $codigoPais as xs:string external;

xf:consultaPasivosClienteIn($requestHeader1,
    $customerId,
    $legalId,
    $codigoPais)