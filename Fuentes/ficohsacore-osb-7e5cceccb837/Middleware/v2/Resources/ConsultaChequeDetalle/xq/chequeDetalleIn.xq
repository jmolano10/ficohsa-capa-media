(:: pragma bea:global-element-parameter parameter="$consultaChequeDetalle" element="ns1:consultaChequeDetalle" location="../../ConsultaChequesCompensacion/xsd/consultaChequesCompensacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/chequeDetalle/xsd/chequeDetalle_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/chequeDetalle";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesCompensacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaChequeDetalle/xq/chequeDetalleIn/";

declare function xf:chequeDetalleIn($consultaChequeDetalle as element(ns1:consultaChequeDetalle))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:PN_TIPO>{ xs:decimal(data($consultaChequeDetalle/TYPE)) }</ns0:PN_TIPO>
        	<ns0:PD_FECHA>{ xs:date(data($consultaChequeDetalle/DATE)) }</ns0:PD_FECHA>
            <ns0:PN_CODIGO_AGENCIA>{ data($consultaChequeDetalle/BRANCH) }</ns0:PN_CODIGO_AGENCIA>
            <ns0:PV_CODIGO_MONEDA>{ data($consultaChequeDetalle/CURRENCY) }</ns0:PV_CODIGO_MONEDA>
            <ns0:PV_CODIGO_USUARIO>{ data($consultaChequeDetalle/TELLER) }</ns0:PV_CODIGO_USUARIO>
            <ns0:PN_JORNADA>{ data($consultaChequeDetalle/JOURNAL) }</ns0:PN_JORNADA>
        </ns0:InputParameters>
};

declare variable $consultaChequeDetalle as element(ns1:consultaChequeDetalle) external;

xf:chequeDetalleIn($consultaChequeDetalle)
