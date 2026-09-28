(:: pragma bea:global-element-parameter parameter="$consultaGuiaDePago" element="ns0:consultaGuiaDePago" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/consultaGuiaDePago/xsd/ConsultaGuiaDePago_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGuiaDePago";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGuiaDePago/xq/ConsultaGuiaDePago/";

declare function xf:ConsultaGuiaDePago($consultaGuiaDePago as element(ns0:consultaGuiaDePago))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_RTN>{ data($consultaGuiaDePago/RTN) }</ns1:PV_RTN>
            <ns1:PV_NUMEROCONTRATO>{ data($consultaGuiaDePago/CONTRACT_NUMBER) }</ns1:PV_NUMEROCONTRATO>
        </ns1:InputParameters>
};

declare variable $consultaGuiaDePago as element(ns0:consultaGuiaDePago) external;

xf:ConsultaGuiaDePago($consultaGuiaDePago)