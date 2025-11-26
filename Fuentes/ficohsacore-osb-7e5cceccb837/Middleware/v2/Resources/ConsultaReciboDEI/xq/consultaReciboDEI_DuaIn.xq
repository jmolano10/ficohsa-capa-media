(:: pragma bea:global-element-parameter parameter="$consultaRecibo" element="ns1:consultaRecibo" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/consultaReciboDUA/xsd/ConsultaReciboDua_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaReciboDua";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEI_DuaIn/";

declare function xf:consultaReciboDEI_DuaIn($consultaRecibo as element(ns1:consultaRecibo))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_ID_LIQUIDACION>{ data($consultaRecibo/BILL_NUMBER) }</ns0:P_ID_LIQUIDACION>
        </ns0:InputParameters>
};

declare variable $consultaRecibo as element(ns1:consultaRecibo) external;

xf:consultaReciboDEI_DuaIn($consultaRecibo)