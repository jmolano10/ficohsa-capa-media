xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$creaTransaccionBancaria1" element="ns0:creaTransaccionBancaria" location="../xsd/creaTransaccionBancariaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:TransferenciaACHDebitoenLinea" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionBanacariaACHDebitoIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creaTransaccionBancariaTypes";

declare function xf:creaTransaccionBanacariaACHDebitoIn($requestHeader1 as element(ns2:RequestHeader),
    $creaTransaccionBancaria1 as element(ns0:creaTransaccionBancaria))
    as element(ns1:TransferenciaACHDebitoenLinea) {
        <ns1:TransferenciaACHDebitoenLinea/>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $creaTransaccionBancaria1 as element(ns0:creaTransaccionBancaria) external;

xf:creaTransaccionBanacariaACHDebitoIn($requestHeader1,
    $creaTransaccionBancaria1)
