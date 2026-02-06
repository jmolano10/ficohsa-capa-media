xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesas1" element="ns1:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaRelConPago/xsd/consultaRelConPago_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRelConPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/consRelConPagoRem/";

declare function xf:consRelConPagoRem($pagoRemesas1 as element(ns1:pagoRemesas))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOCONTRATO>{ data($pagoRemesas1/REMITTER_ID) }</ns0:PV_CODIGOCONTRATO>
            <ns0:PV_CLAVEREMESA>{ data($pagoRemesas1/REMITTANCE_ID) }</ns0:PV_CLAVEREMESA>
        </ns0:InputParameters>
};

declare variable $pagoRemesas1 as element(ns1:pagoRemesas) external;

xf:consRelConPagoRem($pagoRemesas1)