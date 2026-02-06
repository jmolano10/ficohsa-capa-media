xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaClienteRequest" element="ns2:consultaClienteRequest" location="../../ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Client" location="../../../../v2/BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteBatch/xq/consultaClienteBatchCreditForceIn/";

declare function xf:consultaClienteBatchCreditForceIn($consultaClienteRequest as element(ns2:consultaClienteRequest),
    $type as xs:string,
    $token as xs:string)
    as element(ns0:Client) {
        <ns0:Client>
            <ns0:clientRequest>
                <ns1:Token>{ $token }</ns1:Token>
                <ns1:Type>{ $type }</ns1:Type>
                <ns1:Value>{ data($consultaClienteRequest/ns2:CUSTOMER_ID_VALUE) }</ns1:Value>
            </ns0:clientRequest>
        </ns0:Client>
};

declare variable $consultaClienteRequest as element(ns2:consultaClienteRequest) external;
declare variable $type as xs:string external;
declare variable $token as xs:string external;

xf:consultaClienteBatchCreditForceIn($consultaClienteRequest,
    $type,
    $token)