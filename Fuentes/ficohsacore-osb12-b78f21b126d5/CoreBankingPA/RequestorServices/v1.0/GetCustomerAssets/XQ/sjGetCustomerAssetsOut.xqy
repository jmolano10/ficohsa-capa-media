xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
(:: import schema at "../XSD/GetCustomerAssetsPA_SJ.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";
(:: import schema at "../../../../ProviderServices/XSD/GetAccountsList/GetAccountsList_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetTermDepositsList/GetTermDepositsList_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sjGetCustomerAssetsOut";

declare variable $getAccountsListRSP as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $getTermDepositsListRSP as element() (:: schema-element(ns3:OutputParameters) ::) external;

declare function ns1:sjGetCustomerAssetsOut($getAccountsListRSP as element() (:: schema-element(ns2:OutputParameters) ::), 
                                            $getTermDepositsListRSP as element() (:: schema-element(ns3:OutputParameters) ::)) 
                                            as element() (:: schema-element(ns4:OutputParameters) ::) {
    <ns4:OutputParameters>
        <ns4:OutputParametersDepositos>
            {
                if ($getTermDepositsListRSP/ns3:ASSET_TYPE)
                then <ns4:PV_ASSET_TYPE>{fn:data($getTermDepositsListRSP/ns3:ASSET_TYPE)}</ns4:PV_ASSET_TYPE>
                else ()
            }
            {
                if ($getTermDepositsListRSP/ns3:ASSET_NUMBER)
                then <ns4:PV_ASSET_NUMBER>
                    {
                        for $ASSET_NUMBER_ITEM in $getTermDepositsListRSP/ns3:ASSET_NUMBER/ns3:ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($ASSET_NUMBER_ITEM)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_NUMBER>
                else ()
            }
            {
                if ($getTermDepositsListRSP/ns3:ASSET_NAME)
                then <ns4:PV_ASSET_NAME>
                    {
                        for $ASSET_NAME_ITEM in $getTermDepositsListRSP/ns3:ASSET_NAME/ns3:ASSET_NAME_ITEM
                        return 
                        <ns4:PV_ASSET_NAME_ITEM>{fn:data($ASSET_NAME_ITEM)}</ns4:PV_ASSET_NAME_ITEM>
                    }</ns4:PV_ASSET_NAME>
                else ()
            }
            {
                if ($getTermDepositsListRSP/ns3:ASSET_CURRENCY)
                then <ns4:PV_ASSET_CURRENCY>
                    {
                        for $ASSET_NUMBER_ITEM1 in $getTermDepositsListRSP/ns3:ASSET_CURRENCY/ns3:ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($ASSET_NUMBER_ITEM1)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_CURRENCY>
                else ()
            }
            <ns4:PV_ASSET_TYPE_OUT>
                <ns4:PV_ASSET_NUMBER_ITEM></ns4:PV_ASSET_NUMBER_ITEM>
            </ns4:PV_ASSET_TYPE_OUT>
            {
                if ($getTermDepositsListRSP/ns3:ASSET_TOTAL_BALANCE)
                then <ns4:PV_ASSET_TOTAL_BALANCE>
                    {
                        for $ASSET_NUMBER_ITEM2 in $getTermDepositsListRSP/ns3:ASSET_TOTAL_BALANCE/ns3:ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($ASSET_NUMBER_ITEM2)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_TOTAL_BALANCE>
                else ()
            }
            {
                if ($getTermDepositsListRSP/ns3:ASSET_RESERVE_BALANCE)
                then <ns4:PV_ASSET_RESERVE_BALANCE>
                    {
                        for $ASSET_NUMBER_ITEM3 in $getTermDepositsListRSP/ns3:ASSET_RESERVE_BALANCE/ns3:ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($ASSET_NUMBER_ITEM3)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_RESERVE_BALANCE>
                else ()
            }
            {
                if ($getTermDepositsListRSP/ns3:ASSET_LOCKED_BALANCE)
                then <ns4:PV_ASSET_LOCKED_BALANCE>
                    {
                        for $ASSET_NUMBER_ITEM4 in $getTermDepositsListRSP/ns3:ASSET_LOCKED_BALANCE/ns3:ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($ASSET_NUMBER_ITEM4)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_LOCKED_BALANCE>
                else ()
            }
            {
                if ($getTermDepositsListRSP/ns3:ASSET_VISA_FLOATING_BALANCE)
                then <ns4:PV_ASSET_VISA_FLOATING_BALANCE>
                    {
                        for $ASSET_NUMBER_ITEM5 in $getTermDepositsListRSP/ns3:ASSET_VISA_FLOATING_BALANCE/ns3:ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($ASSET_NUMBER_ITEM5)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_VISA_FLOATING_BALANCE>
                else ()
            }
            {
                if ($getTermDepositsListRSP/ns3:ASSET_AVAILABLE_BALANCE)
                then <ns4:PV_ASSET_AVAILABLE_BALANCE>
                    {
                        for $ASSET_NUMBER_ITEM6 in $getTermDepositsListRSP/ns3:ASSET_AVAILABLE_BALANCE/ns3:ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($ASSET_NUMBER_ITEM6)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_AVAILABLE_BALANCE>
                else ()
            }
            <ns4:PV_ASSET_PRODUCT_TYPE>
                <ns4:PV_ASSET_NAME_ITEM></ns4:PV_ASSET_NAME_ITEM>
            </ns4:PV_ASSET_PRODUCT_TYPE>
            {
                if ($getTermDepositsListRSP/ns3:ERROR_CODE)
                then <ns4:PV_ERROR_CODE>{fn:data($getTermDepositsListRSP/ns3:ERROR_CODE)}</ns4:PV_ERROR_CODE>
                else ()
            }
            {
                if ($getTermDepositsListRSP/ns3:ERROR_MESSAGE)
                then <ns4:PV_ERROR_MESSAGE>{fn:data($getTermDepositsListRSP/ns3:ERROR_MESSAGE)}</ns4:PV_ERROR_MESSAGE>
                else ()
            }
        </ns4:OutputParametersDepositos>
        <ns4:OutputParametersCuentas>
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_TYPE)
                then <ns4:PV_ASSET_TYPE>{fn:data($getAccountsListRSP/ns2:PV_ASSET_TYPE)}</ns4:PV_ASSET_TYPE>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_NUMBER)
                then <ns4:PV_ASSET_NUMBER>
                    {
                        for $PV_ASSET_NUMBER_ITEM in $getAccountsListRSP/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NUMBER_ITEM)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_NUMBER>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_NAME)
                then <ns4:PV_ASSET_NAME>
                    {
                        for $PV_ASSET_NAME_ITEM in $getAccountsListRSP/ns2:PV_ASSET_NAME/ns2:PV_ASSET_NAME_ITEM
                        return 
                        <ns4:PV_ASSET_NAME_ITEM>{fn:data($PV_ASSET_NAME_ITEM)}</ns4:PV_ASSET_NAME_ITEM>
                    }</ns4:PV_ASSET_NAME>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_CURRENCY)
                then <ns4:PV_ASSET_CURRENCY>
                    {
                        for $PV_ASSET_NUMBER_ITEM1 in $getAccountsListRSP/ns2:PV_ASSET_CURRENCY/ns2:PV_ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NUMBER_ITEM1)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_CURRENCY>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_TYPE_OUT)
                then <ns4:PV_ASSET_TYPE_OUT>
                    {
                        for $PV_ASSET_NUMBER_ITEM2 in $getAccountsListRSP/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NUMBER_ITEM2)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_TYPE_OUT>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_TOTAL_BALANCE)
                then <ns4:PV_ASSET_TOTAL_BALANCE>
                    {
                        for $PV_ASSET_NUMBER_ITEM3 in $getAccountsListRSP/ns2:PV_ASSET_TOTAL_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NUMBER_ITEM3)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_TOTAL_BALANCE>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_RESERVE_BALANCE)
                then <ns4:PV_ASSET_RESERVE_BALANCE>
                    {
                        for $PV_ASSET_NUMBER_ITEM4 in $getAccountsListRSP/ns2:PV_ASSET_RESERVE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NUMBER_ITEM4)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_RESERVE_BALANCE>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_LOCKED_BALANCE)
                then <ns4:PV_ASSET_LOCKED_BALANCE>
                    {
                        for $PV_ASSET_NUMBER_ITEM5 in $getAccountsListRSP/ns2:PV_ASSET_LOCKED_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NUMBER_ITEM5)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_LOCKED_BALANCE>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_VISA_FLOATING_BALANCE)
                then <ns4:PV_ASSET_VISA_FLOATING_BALANCE>
                    {
                        for $PV_ASSET_NUMBER_ITEM6 in $getAccountsListRSP/ns2:PV_ASSET_VISA_FLOATING_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NUMBER_ITEM6)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_VISA_FLOATING_BALANCE>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_AVAILABLE_BALANCE)
                then <ns4:PV_ASSET_AVAILABLE_BALANCE>
                    {
                        for $PV_ASSET_NUMBER_ITEM7 in $getAccountsListRSP/ns2:PV_ASSET_AVAILABLE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NUMBER_ITEM7)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_AVAILABLE_BALANCE>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ASSET_PRODUCT_TYPE)
                then <ns4:PV_ASSET_PRODUCT_TYPE>
                    {
                        for $PV_ASSET_NAME_ITEM1 in $getAccountsListRSP/ns2:PV_ASSET_PRODUCT_TYPE/ns2:PV_ASSET_NAME_ITEM
                        return 
                        <ns4:PV_ASSET_NUMBER_ITEM>{fn:data($PV_ASSET_NAME_ITEM1)}</ns4:PV_ASSET_NUMBER_ITEM>
                    }</ns4:PV_ASSET_PRODUCT_TYPE>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ERROR_CODE)
                then <ns4:PV_ERROR_CODE>{fn:data($getAccountsListRSP/ns2:PV_ERROR_CODE)}</ns4:PV_ERROR_CODE>
                else ()
            }
            {
                if ($getAccountsListRSP/ns2:PV_ERROR_MESSAGE)
                then <ns4:PV_ERROR_MESSAGE>{fn:data($getAccountsListRSP/ns2:PV_ERROR_MESSAGE)}</ns4:PV_ERROR_MESSAGE>
                else ()
            }
        </ns4:OutputParametersCuentas>
    </ns4:OutputParameters>
};

ns1:sjGetCustomerAssetsOut($getAccountsListRSP, $getTermDepositsListRSP)