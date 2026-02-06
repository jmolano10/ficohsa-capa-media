xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/LineasCreditoRTNTypes";
(:: import schema at "../xsd/LineasCreditoRTNTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/LineasCreditoRTN_db";
(:: import schema at "../../../BusinessServices/ABKHN/LineasCreditoRTN/xsd/LineasCreditoRTN_db_sp.xsd" ::)

declare variable $PruebaNombre as element(DocumentNumber) external;

declare function local:func($PruebaNombre as element(DocumentNumber)) as element() (:: schema-element(ns2:InputParameters) ::) {
  <ns2:InputParameters>
    <ns2:P_RTN>{fn:data($PruebaNombre)}</ns2:P_RTN>
  </ns2:InputParameters>
};

local:func($PruebaNombre)