xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductosMoraRequest" element="ns1:consultaProductosMoraRequest" location="../../ConsultasCarteraCrediticia/xsd/consultasCarteraCrediticiaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Client" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)

declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultasCarteraCrediticia";
declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosMora/xq/ProductosMoraCreditForceIn/";

declare function xf:ProductosMoraCreditForceIn($token as xs:string,
    $type as xs:string,
    $consultaProductosMoraRequest as element(ns1:consultaProductosMoraRequest))
    as element(ns0:Client) {
        <ns0:Client>
            <ns0:clientRequest>
                <ns2:Token>{ $token }</ns2:Token>
                <ns2:Type>{ $type }</ns2:Type>
                <ns2:Value>{ data($consultaProductosMoraRequest/CUSTOMER/CUSTOMER_ID_VALUE) }</ns2:Value>
            </ns0:clientRequest>
        </ns0:Client>
};

declare variable $token as xs:string external;
declare variable $type as xs:string external;
declare variable $consultaProductosMoraRequest as element(ns1:consultaProductosMoraRequest) external;

xf:ProductosMoraCreditForceIn($token,
    $type,
    $consultaProductosMoraRequest)