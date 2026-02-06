xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleMoraPrestamoRequest1" element="ns1:consultaDetalleMoraPrestamoRequest" location="../../ConsultasCarteraCrediticia/xsd/consultasCarteraCrediticiaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Operation" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)

declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultasCarteraCrediticia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleMoraPrestamo/xq/ConsultaDetalleMoraPrestamoHNIn/";

declare function xf:ConsultaDetalleMoraPrestamoHNIn($token as xs:string,
    $consultaDetalleMoraPrestamoRequest1 as element(ns1:consultaDetalleMoraPrestamoRequest))
    as element(ns0:Operation) {
        <ns0:Operation>
            <ns0:opReq>
            	<ns2:Operation_Id>{ data($consultaDetalleMoraPrestamoRequest1/LOAN_ID) }</ns2:Operation_Id>
                <ns2:Token>{ $token }</ns2:Token>
            </ns0:opReq>
        </ns0:Operation>
};

declare variable $token as xs:string external;
declare variable $consultaDetalleMoraPrestamoRequest1 as element(ns1:consultaDetalleMoraPrestamoRequest) external;

xf:ConsultaDetalleMoraPrestamoHNIn($token,
    $consultaDetalleMoraPrestamoRequest1)