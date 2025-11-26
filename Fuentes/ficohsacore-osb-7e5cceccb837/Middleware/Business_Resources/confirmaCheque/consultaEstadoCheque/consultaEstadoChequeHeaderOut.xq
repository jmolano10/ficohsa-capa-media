xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$confirmaciondecheques_ValidateResponse1" element="ns0:Confirmaciondecheques_ValidateResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/consultaEstadoCheque/headerOut3/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:headerOut3($confirmaciondecheques_ValidateResponse1 as element(ns0:Confirmaciondecheques_ValidateResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	<successIndicator>SUCCESS</successIndicator>
        </ns1:ResponseHeader>
};

declare variable $confirmaciondecheques_ValidateResponse1 as element(ns0:Confirmaciondecheques_ValidateResponse) external;

xf:headerOut3($confirmaciondecheques_ValidateResponse1)