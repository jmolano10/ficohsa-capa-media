xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaResponse" element="ns1:ConsultaResponse" location="../../../BusinessServices/External/SalesforceHNMarcaViajeroTC/wsdl/SalesforceHNMarcaViajeroTC.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:salesforceMarcaViajeroTCResponse" location="../xsd/salesforceMarcaViajeroTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/salesforceMarcaViajeroTCTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/MarcaViajero";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SalesforceMarcaViajeroTC/xq/salesforceMarcaViajeroTCHNOut/";

declare function xf:salesforceMarcaViajeroTCHNOut($consultaResponse as element(ns1:ConsultaResponse))
    as element(ns0:salesforceMarcaViajeroTCResponse) {
        <ns0:salesforceMarcaViajeroTCResponse>
            <CASE_NUMBER>{ data($consultaResponse/ns1:result/ns1:CASE_NUMBER) }</CASE_NUMBER>
        </ns0:salesforceMarcaViajeroTCResponse>
};

declare variable $consultaResponse as element(ns1:ConsultaResponse) external;

xf:salesforceMarcaViajeroTCHNOut($consultaResponse)