<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
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
        &lt;ns1:TransferenciaACHDebitoenLinea/>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $creaTransaccionBancaria1 as element(ns0:creaTransaccionBancaria) external;

xf:creaTransaccionBanacariaACHDebitoIn($requestHeader1,
    $creaTransaccionBancaria1)</con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../xsd/creaTransaccionBancariaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CreaTransaccionBancaria/xsd/creaTransaccionBancariaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602"/>
    </con:dependency>
</con:xqueryEntry>