(:: pragma bea:schema-type-parameter parameter="$group" type="ns1:GROUP" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../VASA/consultaSituacionFinanciera/xsd/consultaSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSituacionFinanciera";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoPA/xq/sjConsultaSituacionFinancieraVasaIn/";

declare function xf:sjConsultaSituacionFinancieraVasaIn($group as element())
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:XML_CLIENTES>{ fn-bea:serialize($group/CUSTOMERS) }</ns0:XML_CLIENTES>
        </ns0:InputParameters>
};

declare variable $group as element() external;

xf:sjConsultaSituacionFinancieraVasaIn($group)
