(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/ConsultaRecaudo/xsd/ConsultaRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/RegistrarRelacionOpRecaudo/xsd/registrarRelacionOperacionRecaudo_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudo";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarRelacionOperacionRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/registroRelacionOpRecaudoIN/";

declare function xf:registroRelacionOpRecaudoIN($outputParameters1 as element(ns1:OutputParameters),
    $estado as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $PV_CONTRACT_ID_OUT in $outputParameters1/ns1:PV_CONTRACT_ID_OUT
                return
                    <ns0:CODIGO_CONTRATO>{ data($PV_CONTRACT_ID_OUT) }</ns0:CODIGO_CONTRATO>
            }
            {
                for $PV_DEBTOR_CODE_OUT in $outputParameters1/ns1:PV_DEBTOR_CODE_OUT
                return
                    <ns0:CODIGO_DEUDOR>{ data($PV_DEBTOR_CODE_OUT) }</ns0:CODIGO_DEUDOR>
            }
            <ns0:CODIGO_FACTURA>
                <ns0:CODIGO_FACTURA_ITEM>1</ns0:CODIGO_FACTURA_ITEM>
            </ns0:CODIGO_FACTURA>
            <ns0:MONEDA_FACTURA>
                {
                    for $PV_BILL_CURRENCY_ITEM in $outputParameters1/ns1:PV_BILL_CURRENCY/ns1:PV_BILL_CURRENCY_ITEM
                    return
                        <ns0:CODIGO_FACTURA_ITEM>{ data($PV_BILL_CURRENCY_ITEM) }</ns0:CODIGO_FACTURA_ITEM>
                }
            </ns0:MONEDA_FACTURA>
            <ns0:FECHA_FACTURA>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_BILL_DATE_OUT/ns1:PV_BILL_NUMBER_ITEM
                    return
                        <ns0:CODIGO_FACTURA_ITEM>{ fn:concat(fn:substring(data($PV_BILL_NUMBER_ITEM),7,4),fn:substring(data($PV_BILL_NUMBER_ITEM),4,2),fn:substring(data($PV_BILL_NUMBER_ITEM),1,2)) }</ns0:CODIGO_FACTURA_ITEM>
                }
            </ns0:FECHA_FACTURA>
            <ns0:FECHA_VENCIMIENTO>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_DUE_DATE/ns1:PV_BILL_NUMBER_ITEM
                    return
                        <ns0:CODIGO_FACTURA_ITEM>{ fn:concat(fn:substring(data($PV_BILL_NUMBER_ITEM),7,4),fn:substring(data($PV_BILL_NUMBER_ITEM),4,2),fn:substring(data($PV_BILL_NUMBER_ITEM),1,2)) }</ns0:CODIGO_FACTURA_ITEM>
                }
            </ns0:FECHA_VENCIMIENTO>
            <ns0:MONTO_FACTURA>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_BILL_AMOUNT_OUT/ns1:PV_BILL_NUMBER_ITEM
                    return
                        <ns0:CODIGO_FACTURA_ITEM>{ data($PV_BILL_NUMBER_ITEM) }</ns0:CODIGO_FACTURA_ITEM>
                }
            </ns0:MONTO_FACTURA>
            <ns0:MORA>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_LATE_FEE/ns1:PV_BILL_NUMBER_ITEM
                    return
                        <ns0:CODIGO_FACTURA_ITEM>{ data($PV_BILL_NUMBER_ITEM) }</ns0:CODIGO_FACTURA_ITEM>
                }
            </ns0:MORA>
            <ns0:MONTO_TOTAL>
                {
                    for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_TOTAL_AMOUNT/ns1:PV_BILL_NUMBER_ITEM
                    return
                        <ns0:CODIGO_FACTURA_ITEM>{ data($PV_BILL_NUMBER_ITEM) }</ns0:CODIGO_FACTURA_ITEM>
                }
            </ns0:MONTO_TOTAL>
            <ns0:MONEDA_SOLICITUD>
                {
                    for $PV_BILL_CURRENCY_ITEM in $outputParameters1/ns1:PV_BILL_CURRENCY/ns1:PV_BILL_CURRENCY_ITEM
                    return
                        <ns0:CODIGO_FACTURA_ITEM>{ data($PV_BILL_CURRENCY_ITEM) }</ns0:CODIGO_FACTURA_ITEM>
                }
            </ns0:MONEDA_SOLICITUD>
            <ns0:ESTADO>{ $estado }</ns0:ESTADO>
            {
                for $PV_DEBTOR_NAME in $outputParameters1/ns1:PV_DEBTOR_NAME
                return
                    <ns0:LISTA_VALORES>{ data($PV_DEBTOR_NAME) }</ns0:LISTA_VALORES>
            }
        </ns0:InputParameters>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $estado as xs:string external;

xf:registroRelacionOpRecaudoIN($outputParameters1,
    $estado)