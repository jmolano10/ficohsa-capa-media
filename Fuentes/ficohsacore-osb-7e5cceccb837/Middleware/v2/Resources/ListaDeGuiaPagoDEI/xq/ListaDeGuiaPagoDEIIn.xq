(:: pragma bea:global-element-parameter parameter="$listaDeGuiaPago" element="ns0:listaDeGuiaPago" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/listaDeGuiaPago/xsd/ListaDeGuiaPago_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ListaDeGuiaPago";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListaDeGuiaPago/xq/ListaDeGuiaPagoIn/";

declare function xf:ListaDeGuiaPagoIn($listaDeGuiaPago as element(ns0:listaDeGuiaPago))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_RTN>{ data($listaDeGuiaPago/RTN) }</ns1:PV_RTN>
            <ns1:PV_NUMEROCONTRATO>{ data($listaDeGuiaPago/CONTRACT_NUMBER) }</ns1:PV_NUMEROCONTRATO>
        </ns1:InputParameters>
};

declare variable $listaDeGuiaPago as element(ns0:listaDeGuiaPago) external;

xf:ListaDeGuiaPagoIn($listaDeGuiaPago)