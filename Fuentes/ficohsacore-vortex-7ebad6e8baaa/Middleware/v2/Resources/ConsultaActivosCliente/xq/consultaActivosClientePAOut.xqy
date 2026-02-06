xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaListaCuentas/xsd/consultaListaCuentas_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns2:OutputParameters" location="../../../BusinessServices/ABKPA/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaActivosCliente/xsd/consultaActivosCliente_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaActivosCliente/xq/consultaActivosClienteOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";

declare function xf:consultaActivosClienteOut($outputParameters1 as element(ns1:OutputParameters),
    $outputParameters2 as element(ns2:OutputParameters))
    as element(ns0:OutputParameters) {
        <ns0:OutputParameters>
            <ns0:OutputParametersDepositos>
                {
                    for $ASSET_TYPE in $outputParameters2/ns2:ASSET_TYPE
                    return
                        <ns0:PV_ASSET_TYPE>{ data($ASSET_TYPE) }</ns0:PV_ASSET_TYPE>
                }
                {
                    for $ASSET_NUMBER in $outputParameters2/ns2:ASSET_NUMBER
                    return
                        <ns0:PV_ASSET_NUMBER>
                            {
                                for $ASSET_NUMBER_ITEM in $ASSET_NUMBER/ns2:ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_NUMBER>
                }
                {
                    for $ASSET_NAME in $outputParameters2/ns2:ASSET_NAME
                    return
                        <ns0:PV_ASSET_NAME>
                            {
                                for $ASSET_NAME_ITEM in $ASSET_NAME/ns2:ASSET_NAME_ITEM
                                return
                                    <ns0:PV_ASSET_NAME_ITEM>{ data($ASSET_NAME_ITEM) }</ns0:PV_ASSET_NAME_ITEM>
                            }
                        </ns0:PV_ASSET_NAME>
                }
                {
                    for $ASSET_CURRENCY in $outputParameters2/ns2:ASSET_CURRENCY
                    return
                        <ns0:PV_ASSET_CURRENCY>
                            {
                                for $ASSET_NUMBER_ITEM in $ASSET_CURRENCY/ns2:ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_CURRENCY>
                }
                {
                    for $ASSET_TOTAL_BALANCE in $outputParameters2/ns2:ASSET_TOTAL_BALANCE
                    return
                        <ns0:PV_ASSET_TOTAL_BALANCE>
                            {
                                for $ASSET_NUMBER_ITEM in $ASSET_TOTAL_BALANCE/ns2:ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_TOTAL_BALANCE>
                }
                {
                    for $ASSET_RESERVE_BALANCE in $outputParameters2/ns2:ASSET_RESERVE_BALANCE
                    return
                        <ns0:PV_ASSET_RESERVE_BALANCE>
                            {
                                for $ASSET_NUMBER_ITEM in $ASSET_RESERVE_BALANCE/ns2:ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_RESERVE_BALANCE>
                }
                {
                    for $ASSET_LOCKED_BALANCE in $outputParameters2/ns2:ASSET_LOCKED_BALANCE
                    return
                        <ns0:PV_ASSET_LOCKED_BALANCE>
                            {
                                for $ASSET_NUMBER_ITEM in $ASSET_LOCKED_BALANCE/ns2:ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_LOCKED_BALANCE>
                }
                {
                    for $ASSET_VISA_FLOATING_BALANCE in $outputParameters2/ns2:ASSET_VISA_FLOATING_BALANCE
                    return
                        <ns0:PV_ASSET_VISA_FLOATING_BALANCE>
                            {
                                for $ASSET_NUMBER_ITEM in $ASSET_VISA_FLOATING_BALANCE/ns2:ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_VISA_FLOATING_BALANCE>
                }
                {
                    for $ASSET_AVAILABLE_BALANCE in $outputParameters2/ns2:ASSET_AVAILABLE_BALANCE
                    return
                        <ns0:PV_ASSET_AVAILABLE_BALANCE>
                            {
                                for $ASSET_NUMBER_ITEM in $ASSET_AVAILABLE_BALANCE/ns2:ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_AVAILABLE_BALANCE>
                }
                {
                    for $ERROR_CODE in $outputParameters2/ns2:ERROR_CODE
                    return
                        <ns0:PV_ERROR_CODE>{ data($ERROR_CODE) }</ns0:PV_ERROR_CODE>
                }
                {
                    for $ERROR_MESSAGE in $outputParameters2/ns2:ERROR_MESSAGE
                    return
                        <ns0:PV_ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ns0:PV_ERROR_MESSAGE>
                }
            </ns0:OutputParametersDepositos>
            <ns0:OutputParametersCuentas>
                {
                    for $PV_ASSET_TYPE in $outputParameters1/ns1:PV_ASSET_TYPE
                    return
                        <ns0:PV_ASSET_TYPE>{ data($PV_ASSET_TYPE) }</ns0:PV_ASSET_TYPE>
                }
                {
                    for $PV_ASSET_NUMBER in $outputParameters1/ns1:PV_ASSET_NUMBER
                    return
                        <ns0:PV_ASSET_NUMBER>
                            {
                                for $PV_ASSET_NUMBER_ITEM in $PV_ASSET_NUMBER/ns1:PV_ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($PV_ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_NUMBER>
                }
                {
                    for $PV_ASSET_NAME in $outputParameters1/ns1:PV_ASSET_NAME
                    return
                        <ns0:PV_ASSET_NAME>
                            {
                                for $PV_ASSET_NAME_ITEM in $PV_ASSET_NAME/ns1:PV_ASSET_NAME_ITEM
                                return
                                    <ns0:PV_ASSET_NAME_ITEM>{ data($PV_ASSET_NAME_ITEM) }</ns0:PV_ASSET_NAME_ITEM>
                            }
                        </ns0:PV_ASSET_NAME>
                }
                {
                    for $PV_ASSET_CURRENCY in $outputParameters1/ns1:PV_ASSET_CURRENCY
                    return
                        <ns0:PV_ASSET_CURRENCY>
                            {
                                for $PV_ASSET_NUMBER_ITEM in $PV_ASSET_CURRENCY/ns1:PV_ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($PV_ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_CURRENCY>
                }
                {
                    for $PV_ASSET_TYPE_OUT in $outputParameters1/ns1:PV_ASSET_TYPE_OUT
                    return
                        <ns0:PV_ASSET_TYPE_OUT>
                            {
                                for $PV_ASSET_NUMBER_ITEM in $PV_ASSET_TYPE_OUT/ns1:PV_ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($PV_ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_TYPE_OUT>
                }
                {
                    for $PV_ASSET_TOTAL_BALANCE in $outputParameters1/ns1:PV_ASSET_TOTAL_BALANCE
                    return
                        <ns0:PV_ASSET_TOTAL_BALANCE>
                            {
                                for $PV_ASSET_NUMBER_ITEM in $PV_ASSET_TOTAL_BALANCE/ns1:PV_ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($PV_ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_TOTAL_BALANCE>
                }
                {
                    for $PV_ASSET_RESERVE_BALANCE in $outputParameters1/ns1:PV_ASSET_RESERVE_BALANCE
                    return
                        <ns0:PV_ASSET_RESERVE_BALANCE>
                            {
                                for $PV_ASSET_NUMBER_ITEM in $PV_ASSET_RESERVE_BALANCE/ns1:PV_ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($PV_ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_RESERVE_BALANCE>
                }
                {
                    for $PV_ASSET_LOCKED_BALANCE in $outputParameters1/ns1:PV_ASSET_LOCKED_BALANCE
                    return
                        <ns0:PV_ASSET_LOCKED_BALANCE>
                            {
                                for $PV_ASSET_NUMBER_ITEM in $PV_ASSET_LOCKED_BALANCE/ns1:PV_ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($PV_ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_LOCKED_BALANCE>
                }
                {
                    for $PV_ASSET_VISA_FLOATING_BALANCE in $outputParameters1/ns1:PV_ASSET_VISA_FLOATING_BALANCE
                    return
                        <ns0:PV_ASSET_VISA_FLOATING_BALANCE>
                            {
                                for $PV_ASSET_NUMBER_ITEM in $PV_ASSET_VISA_FLOATING_BALANCE/ns1:PV_ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($PV_ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_VISA_FLOATING_BALANCE>
                }
                {
                    for $PV_ASSET_AVAILABLE_BALANCE in $outputParameters1/ns1:PV_ASSET_AVAILABLE_BALANCE
                    return
                        <ns0:PV_ASSET_AVAILABLE_BALANCE>
                            {
                                for $PV_ASSET_NUMBER_ITEM in $PV_ASSET_AVAILABLE_BALANCE/ns1:PV_ASSET_NUMBER_ITEM
                                return
                                    <ns0:PV_ASSET_NUMBER_ITEM>{ data($PV_ASSET_NUMBER_ITEM) }</ns0:PV_ASSET_NUMBER_ITEM>
                            }
                        </ns0:PV_ASSET_AVAILABLE_BALANCE>
                }
                {
                    for $PV_ASSET_PRODUCT_TYPE in $outputParameters1/ns1:PV_ASSET_PRODUCT_TYPE
                    return
                        <ns0:PV_ASSET_PRODUCT_TYPE>
                            {
                                for $PV_ASSET_NAME_ITEM in $PV_ASSET_PRODUCT_TYPE/ns1:PV_ASSET_NAME_ITEM
                                return
                                    <ns0:PV_ASSET_NAME_ITEM>{ data($PV_ASSET_NAME_ITEM) }</ns0:PV_ASSET_NAME_ITEM>
                            }
                        </ns0:PV_ASSET_PRODUCT_TYPE>
                }
                {
                    for $PV_ERROR_CODE in $outputParameters1/ns1:PV_ERROR_CODE
                    return
                        <ns0:PV_ERROR_CODE>{ data($PV_ERROR_CODE) }</ns0:PV_ERROR_CODE>
                }
                {
                    for $PV_ERROR_MESSAGE in $outputParameters1/ns1:PV_ERROR_MESSAGE
                    return
                        <ns0:PV_ERROR_MESSAGE>{ data($PV_ERROR_MESSAGE) }</ns0:PV_ERROR_MESSAGE>
                }
            </ns0:OutputParametersCuentas>
        </ns0:OutputParameters>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $outputParameters2 as element(ns2:OutputParameters) external;

xf:consultaActivosClienteOut($outputParameters1,
    $outputParameters2)