(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultipleResponse" element="ns0:consultaRecaudoMultipleResponse" location="../../xsds/ConsultaRecaudoMultiple/ConsultaRecaudoMultiple.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/Recaudos/RegistrarRelacionOperacionRecaudo/FLINK_OSB_REGISTRAR_OPER_RECAUDO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REGISTRAR_OPER_RECAUDO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMultiple/RegistrarOperacionRecaudoIn/";

declare function xf:RegistrarOperacionRecaudoIn($consultaRecaudoMultipleResponse as element(ns0:consultaRecaudoMultipleResponse),
    $estado as xs:string,
    $codigoDeudor as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $CONTRACT_ID in $consultaRecaudoMultipleResponse/CONTRACT_ID
                return
                    <ns1:CODIGO_CONTRATO>{ data($CONTRACT_ID) }</ns1:CODIGO_CONTRATO>
            }
			<ns1:CODIGO_DEUDOR>{ $codigoDeudor }</ns1:CODIGO_DEUDOR>
            <ns1:CODIGO_FACTURA>
                {
                    for $BILL_NUMBER in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD/BILL_NUMBER
                    return
                        <ns1:ITEM>{ data($BILL_NUMBER) }</ns1:ITEM>
                }
            </ns1:CODIGO_FACTURA>
            <ns1:MONEDA_FACTURA>
                {
                    for $BILL_CURRENCY in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD/BILL_CURRENCY
                    return
                        <ns1:ITEM>{ data($BILL_CURRENCY) }</ns1:ITEM>
                }
            </ns1:MONEDA_FACTURA>
            <ns1:FECHA_FACTURA>
                {
                    for $BILL_DATE in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD/BILL_DATE
                    return
                        <ns1:ITEM>{ data($BILL_DATE) }</ns1:ITEM>
                }
            </ns1:FECHA_FACTURA>
            <ns1:FECHA_VENCIMIENTO>
                {
                    for $DUE_DATE in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD/DUE_DATE
                    return
                        <ns1:ITEM>{ data($DUE_DATE) }</ns1:ITEM>
                }
            </ns1:FECHA_VENCIMIENTO>
            <ns1:MONTO_FACTURA>
                {
                    for $BILL_AMOUNT in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD/BILL_AMOUNT
                    return
                        <ns1:ITEM>{ data($BILL_AMOUNT) }</ns1:ITEM>
                }
            </ns1:MONTO_FACTURA>
            <ns1:MORA>
                {
                    for $LATE_FEE in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD/LATE_FEE
                    return
                        <ns1:ITEM>{ data($LATE_FEE) }</ns1:ITEM>
                }
            </ns1:MORA>
            <ns1:MONEDA_SOLICITUD>
                {
                    for $i in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD/BILL_NUMBER
                    return
                        <ns1:ITEM>{ data($consultaRecaudoMultipleResponse/REQUEST_CURRENCY) }</ns1:ITEM>
                }
            </ns1:MONEDA_SOLICITUD>
            <ns1:MONTO_TOTAL>
                {
                    for $TOTAL_AMOUNT in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD/TOTAL_AMOUNT
                    return
                        <ns1:ITEM>{ data($TOTAL_AMOUNT) }</ns1:ITEM>
                }
            </ns1:MONTO_TOTAL>
            <ns1:ESTADO>{ $estado }</ns1:ESTADO>
        </ns1:InputParameters>
};

declare variable $consultaRecaudoMultipleResponse as element(ns0:consultaRecaudoMultipleResponse) external;
declare variable $estado as xs:string external;
declare variable $codigoDeudor as xs:string external;

xf:RegistrarOperacionRecaudoIn($consultaRecaudoMultipleResponse,
    $estado,
    $codigoDeudor)