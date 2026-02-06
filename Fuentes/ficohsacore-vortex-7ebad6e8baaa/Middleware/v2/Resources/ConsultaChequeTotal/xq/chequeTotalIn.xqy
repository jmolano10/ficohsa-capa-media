xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaChequeTotal" element="ns1:consultaChequeTotal" location="../../ConsultaChequesCompensacion/xsd/consultaChequesCompensacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/chequeTotal/xsd/chequeTotal_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/chequeTotal";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesCompensacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaChequeTotal/xq/chequeTotalIn/";

declare function xf:chequeTotalIn($consultaChequeTotal as element(ns1:consultaChequeTotal))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:PN_TIPO>{ xs:decimal(data($consultaChequeTotal/TYPE)) }</ns0:PN_TIPO>
        	<ns0:PD_FECHA>{ xs:date(data($consultaChequeTotal/DATE)) }</ns0:PD_FECHA>
            <ns0:PN_CODIGO_AGENCIA>{ data($consultaChequeTotal/BRANCH) }</ns0:PN_CODIGO_AGENCIA>
            <ns0:PN_JORNADA>{ data($consultaChequeTotal/JOURNAL) }</ns0:PN_JORNADA>
            <ns0:PV_CODIGO_MONEDA>{ data($consultaChequeTotal/CURRENCY) }</ns0:PV_CODIGO_MONEDA>
            <ns0:PV_CODIGO_USUARIO>{ data($consultaChequeTotal/TELLER) }</ns0:PV_CODIGO_USUARIO>
        </ns0:InputParameters>
};

declare variable $consultaChequeTotal as element(ns1:consultaChequeTotal) external;

xf:chequeTotalIn($consultaChequeTotal)