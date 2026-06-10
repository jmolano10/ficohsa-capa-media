<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/LineasCreditoRTNTypes";
(:: import schema at "../xsd/LineasCreditoRTNTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/LineasCreditoRTN_db";
(:: import schema at "../../../BusinessServices/ABKHN/LineasCreditoRTN/xsd/LineasCreditoRTN_db_sp.xsd" ::)

declare variable $PruebaNombre as element(DocumentNumber) external;

declare function local:func($PruebaNombre as element(DocumentNumber)) as element() (:: schema-element(ns2:InputParameters) ::) {
  &lt;ns2:InputParameters>
    &lt;ns2:P_RTN>{fn:data($PruebaNombre)}&lt;/ns2:P_RTN>
  &lt;/ns2:InputParameters>
};

local:func($PruebaNombre)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/LineasCreditoRTNTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/LineasCreditoRTN/xsd/LineasCreditoRTNTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/ABKHN/LineasCreditoRTN/xsd/LineasCreditoRTN_db_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/ABKHN/LineasCreditoRTN/xsd/LineasCreditoRTN_db_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>