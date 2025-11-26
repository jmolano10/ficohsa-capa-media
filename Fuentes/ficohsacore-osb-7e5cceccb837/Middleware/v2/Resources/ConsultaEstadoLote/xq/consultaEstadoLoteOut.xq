(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PMSV/consultaEstadoLote/xsd/consultarEstadoLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarEstadoLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteHeaderOut/";

declare function xf:consultaEstadoLoteHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaEstadoLoteResponse) {
        <ns0:consultaEstadoLoteResponse>
            <BANK_BATCH_ID>{ data($outputParameters/ns1:PN_NUMEROLOTE) }</BANK_BATCH_ID>
            {
                for $PV_CODIGOCLIENTE in $outputParameters/ns1:PV_CODIGOCLIENTE
                return
                    <CUSTOMER_ID>{ data($PV_CODIGOCLIENTE) }</CUSTOMER_ID>
            }
            <CUSTOMER_NAME>{ data($outputParameters/ns1:PV_NOMBRECLIENTE) }</CUSTOMER_NAME>
            <STATUS>{ data($outputParameters/ns1:PN_ESTADOLOTE) }</STATUS>
            {
                for $PV_DESCESTADOLOTE in $outputParameters/ns1:PV_DESCESTADOLOTE
                return
                    <STATUS_DESC>{ data($PV_DESCESTADOLOTE) }</STATUS_DESC>
            }
            <OPTIMISTIC>
                {
                    if (data($outputParameters/ns1:PN_OPTIMISTA) = 1) then
                        ("YES")
                    else 
                        "NO"
                }
            </OPTIMISTIC>
            {
                if (exists($outputParameters/ns1:PT_CUENTADB/ns1:ITEM)) then (
                    <ACCOUNTS>
                        {
                            let $cuentaDB := $outputParameters/ns1:PT_CUENTADB/ns1:ITEM
                            let $monto := $outputParameters/ns1:PT_MONTO/ns1:ITEM
                            let $moneda := $outputParameters/ns1:PT_MONEDA/ns1:ITEM
                            for $i in 1 to count($cuentaDB)
                            return
                                <ACCOUNT>
                                    <DEBIT_ACCOUNT>{ data($cuentaDB[$i]) }</DEBIT_ACCOUNT>
                                    <AMOUNT>{ data($monto[$i]) }</AMOUNT>
                                    <CURRENCY>{ data($moneda[$i]) }</CURRENCY>
                                </ACCOUNT>
                        }
                    </ACCOUNTS>
                )else()
            }
            {
                if(exists($outputParameters/ns1:PT_MONEDAPAGOS/ns1:ITEM)) then (
                    <PAYMENTS>
                    {
                        let $monedaPagos := $outputParameters/ns1:PT_MONEDAPAGOS/ns1:ITEM
                        let $montoPagos  := $outputParameters/ns1:PT_MONTOPAGOS/ns1:ITEM
                        let $tasaPagos   := $outputParameters/ns1:PT_TASAPAGOS/ns1:ITEM
                        for $i in 1 to count($monedaPagos)
                        return
                        <PAYMENT>
                            <CURRENCY>{ data($monedaPagos[$i]) }</CURRENCY>
                            <TOTAL_AMOUNT>{ data($montoPagos[$i]) }</TOTAL_AMOUNT>
                            <EXCHANGE_RATE>{ data($tasaPagos[$i]) }</EXCHANGE_RATE>
                        </PAYMENT>
                    }
                    </PAYMENTS>
                ) else()
            }
            <TOTAL_AMOUNT>{ data($outputParameters/ns1:PN_MONTOTOTAL) }</TOTAL_AMOUNT>
            {
                for $PN_MONTOERROR in $outputParameters/ns1:PN_MONTOERROR
                return
                    <TOTAL_AMOUNT_ERROR>{ data($PN_MONTOERROR) }</TOTAL_AMOUNT_ERROR>
            }
            <NUMBER_OF_TRANSACTIONS>{ data($outputParameters/ns1:PN_NROTRANS) }</NUMBER_OF_TRANSACTIONS>
            <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($outputParameters/ns1:PN_NROTRANSEXITO) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
            <NUMBER_OF_TRANSACTIONS_ERROR>{ data($outputParameters/ns1:PN_NROTRANSERROR) }</NUMBER_OF_TRANSACTIONS_ERROR>
            <APPLICATION_DATE>{ fn:adjust-dateTime-to-timezone(data($outputParameters/ns1:PD_FECAPLICACION), ()) }</APPLICATION_DATE>
            {
                for $processInfo in $outputParameters/ns1:PV_INFORMACIONPROCESO
                return
                <PROCESS_INFO>{ data($processInfo) }</PROCESS_INFO>
            }
        </ns0:consultaEstadoLoteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaEstadoLoteHeaderOut($outputParameters)