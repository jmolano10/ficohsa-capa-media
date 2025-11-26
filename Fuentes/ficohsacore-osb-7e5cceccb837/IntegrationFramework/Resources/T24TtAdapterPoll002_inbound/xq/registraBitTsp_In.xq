(:: pragma bea:global-element-parameter parameter="$t24TTAuthFlow" element="ns2:T24TTAuthFlow" location="../xsd/T24FicoTSPServices-T24TTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns3:InputParameters" location="../../../BusinessServices/registraBitacoraTSPPMSV/xsd/registraBitacoraTSPMasivos_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTspMasivos";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24TTAuthFlow";
declare namespace ns1 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24TtAdapterPoll002_inbound/xq/registraBitTspPmsv_In/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraTSPMasivos";

declare function xf:registraBitTspPmsv_In($t24TTAuthFlow as element(ns2:T24TTAuthFlow),
    $RATE_AMOUNT as xs:string)
    as element(ns3:InputParameters) {
        <ns3:InputParameters>
            {
                for $TransStmtEntry in $t24TTAuthFlow/ns2:TransStmtEntry
                return
                    <ns3:PV_ID_TRANSACCION>{ data($TransStmtEntry) }</ns3:PV_ID_TRANSACCION>
            }
            <ns3:PD_FECHA_VALIDA>{ data($t24TTAuthFlow/ns2:valueDate1) }</ns3:PD_FECHA_VALIDA>
            {
                for $customer2 in $t24TTAuthFlow/ns2:customer2
                return
                    <ns3:PN_CODIGO_CLIENTE>
                        {
                            if (data($t24TTAuthFlow/ns2:tfsReference) = "") then
                                (data($customer2))
                            else 
                                data($t24TTAuthFlow/ns2:customer1)
                        }
</ns3:PN_CODIGO_CLIENTE>
            }
            <ns3:PV_NUMERO_CUENTA>
                {
                    if (data($t24TTAuthFlow/ns2:tfsReference) = "") then
                        (data($t24TTAuthFlow/ns2:account2))
                    else 
                        data($t24TTAuthFlow/ns2:account1Group[1]/ns2:account1)
                }
</ns3:PV_NUMERO_CUENTA>
            {
                for $currency2 in $t24TTAuthFlow/ns2:currency2
                return
                    <ns3:PV_CODIGO_MONEDA>
                        {
                            if (data($t24TTAuthFlow/ns2:tfsReference) = "") then
                                (data($currency2))
                            else 
                                data($t24TTAuthFlow/ns2:currency1)
                        }
</ns3:PV_CODIGO_MONEDA>
            }
            {
                for $transactionCode in $t24TTAuthFlow/ns2:transactionCode
                return
                    <ns3:PV_CODIGO_TRANSACCION>{ data($transactionCode) }</ns3:PV_CODIGO_TRANSACCION>
            }
            {
                for $id in $t24TTAuthFlow/ns2:id
                return
                    <ns3:PV_REFERENCIA_FT_TT>{ data($id) }</ns3:PV_REFERENCIA_FT_TT>
            }
            {
                for $amountLocal2 in $t24TTAuthFlow/ns2:amountLocal2
                return
                    <ns3:PN_MONTO>
                        {
                            if (data($t24TTAuthFlow/ns2:tfsReference) = "") then
                                (data($amountLocal2))
                            else 
                                data($t24TTAuthFlow/ns2:account1Group[1]/ns2:amountLocal1)
                        }
</ns3:PN_MONTO>
            }
            <ns3:PN_MONTO_TSP>{ data($RATE_AMOUNT) }</ns3:PN_MONTO_TSP>
            {
                for $customer1 in $t24TTAuthFlow/ns2:customer1
                return
                    <ns3:PN_CODIGO_CLIENTE_DESTINO>
                        {
                            if (data($t24TTAuthFlow/ns2:tfsReference) = "") then
                                (data($customer1))
                            else 
                                data($t24TTAuthFlow/ns2:customer2)
                        }
</ns3:PN_CODIGO_CLIENTE_DESTINO>
            }
            <ns3:PV_NUMERO_CUENTA_DESTINO>
                {
                    if (data($t24TTAuthFlow/ns2:tfsReference) = "") then
                        (data($t24TTAuthFlow/ns2:account1Group[1]/ns2:account1))
                    else 
                        data($t24TTAuthFlow/ns2:account2)
                }
</ns3:PV_NUMERO_CUENTA_DESTINO>
            {
                for $currency1 in $t24TTAuthFlow/ns2:currency1
                return
                    <ns3:PV_CODIGO_MONEDA_DESTINO>
                        {
                            if (data($t24TTAuthFlow/ns2:tfsReference) = "") then
                                (data($currency1))
                            else 
                                data($t24TTAuthFlow/ns2:currency2)
                        }
</ns3:PV_CODIGO_MONEDA_DESTINO>
            }
            {
                for $lrAgClientId in $t24TTAuthFlow/ns2:lrAgClientId
                return
                    <ns3:PV_CODIGO_CONVENIO>{ data($lrAgClientId) }</ns3:PV_CODIGO_CONVENIO>
            }
            {
                let $result :=
                    for $narrative1 in $t24TTAuthFlow/ns2:account1Group[1]/ns2:narrative1List/ns2:narrative1
                    return
                        <ns3:PV_DESCRIPCION_MOVIMIENTO>{ data($narrative1) }</ns3:PV_DESCRIPCION_MOVIMIENTO>
                return
                    $result[1]
            }
            <ns3:PV_CODIGO_USUARIO>{ data($t24TTAuthFlow/ns2:eventCommon/ns1:operator) }</ns3:PV_CODIGO_USUARIO>
        </ns3:InputParameters>
};

declare variable $t24TTAuthFlow as element(ns2:T24TTAuthFlow) external;
declare variable $RATE_AMOUNT as xs:string external;

xf:registraBitTspPmsv_In($t24TTAuthFlow,
    $RATE_AMOUNT)