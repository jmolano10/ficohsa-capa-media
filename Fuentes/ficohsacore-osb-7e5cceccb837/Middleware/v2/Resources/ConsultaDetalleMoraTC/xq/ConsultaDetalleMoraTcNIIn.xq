(:: pragma bea:global-element-parameter parameter="$consultaDetalleMoraTCRequest1" element="ns1:consultaDetalleMoraTCRequest" location="../../ConsultasCarteraCrediticia/xsd/consultasCarteraCrediticiaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Operation" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)

declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultasCarteraCrediticia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleMoraTC/xq/ConsultaDEtalleMoraTcIn/";

declare function xf:ConsultaDEtalleMoraTcIn($token as xs:string,
    $consultaDetalleMoraTCRequest1 as element(ns1:consultaDetalleMoraTCRequest))
    as element(ns0:Operation) {
        <ns0:Operation>
            <ns0:opReq>
                <ns2:Operation_Id>{ data($consultaDetalleMoraTCRequest1/PRODUCTS/PRODUCT/VALUE) }</ns2:Operation_Id>
                <ns2:Token>{ $token }</ns2:Token>
            </ns0:opReq>
        </ns0:Operation>
};

declare variable $token as xs:string external;
declare variable $consultaDetalleMoraTCRequest1 as element(ns1:consultaDetalleMoraTCRequest) external;

xf:ConsultaDEtalleMoraTcIn($token,
    $consultaDetalleMoraTCRequest1)