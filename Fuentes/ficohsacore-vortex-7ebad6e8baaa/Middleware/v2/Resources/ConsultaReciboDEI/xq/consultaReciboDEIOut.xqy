xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultarReciboImp/xsd/consultarRecibo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaReciboResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRecibo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEIHeaderOut/";

declare function xf:consultaReciboDEIHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaReciboResponse) {
        <ns0:consultaReciboResponse>
            <BILL_NUMBER>{ data($outputParameters/ns1:PV_IDRECIBO) }</BILL_NUMBER>
            <TAX_TYPE>{ data($outputParameters/ns1:PV_TIPOIMPUESTO) }</TAX_TYPE>
            <DESCRIPTION>{ data($outputParameters/ns1:PV_DESCRIPCION) }</DESCRIPTION>
            <BILL_DETAIL>{ data($outputParameters/ns1:PC_DETALLERECIBO) }</BILL_DETAIL>
            {
            	if (data($outputParameters/ns1:PD_FECHACAJA)) then
            		<DEBIT_DATE>{ data($outputParameters/ns1:PD_FECHACAJA) }</DEBIT_DATE>
            	else
            		""
            }
            <CREATION_DATE>{ data($outputParameters/ns1:PD_FECHAADICION) }</CREATION_DATE>
            <TAXPAYER_NAME>{ data($outputParameters/ns1:PV_CONTRIBUYENTE) }</TAXPAYER_NAME>
            <COSTUMER_DEED>{ data($outputParameters/ns1:PV_DOCUMENTO) }</COSTUMER_DEED>
            <RTN>{ data($outputParameters/ns1:PV_RTN) }</RTN>
            <CUSTOMER_ID>{ data($outputParameters/ns1:PV_CODIGOCLIENTEBANCO) }</CUSTOMER_ID>
            <USER_ID>{ data($outputParameters/ns1:PV_USERID) }</USER_ID>
            <APP_SEQUENCE>{ data($outputParameters/ns1:PV_SECUENCIAAPP) }</APP_SEQUENCE>
            <VOUCHER_TYPE>{ data($outputParameters/ns1:PN_TIPORECIBO) }</VOUCHER_TYPE>
            <VOUCHER_TYPE_DESC>{ data($outputParameters/ns1:PV_DESCRIPCIONTIPORECIBO) }</VOUCHER_TYPE_DESC>
            <T24_REF>{ data($outputParameters/ns1:PV_REFERENCIAT24) }</T24_REF>
        </ns0:consultaReciboResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaReciboDEIHeaderOut($outputParameters)