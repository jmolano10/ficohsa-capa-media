(:: pragma  parameter="$sjTransferenciaCuentaRequest" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:transferenciaCuentasRequest" location="../../../../../../Middleware/v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/TransferenciasEntreCuentaH2H/xq/sjTranferenciaCuentaIN/";

declare function xf:sjTranferenciaCuentaIN($sjTransferenciaCuentaRequest as element(*),
    $transferIndex as xs:integer)
    as element(ns0:transferenciaCuentasRequest) {
        <ns0:transferenciaCuentasRequest>
           <DEBIT_ACCOUNT>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
           <CREDIT_ACCOUNT>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>         
            <CURRENCY>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/CURRENCY) }</CURRENCY>
            <TRANSFER_AMOUNT>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/TRANSFER_AMOUNT) }</TRANSFER_AMOUNT>
            <DEBIT_CREDIT>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DEBIT_CREDIT) }</DEBIT_CREDIT>
            <DESCRIPTION>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/DESCRIPTION) }</DESCRIPTION>
            <AUTHORIZATION_TICKET>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/AUTHORIZATION_TICKET) }</AUTHORIZATION_TICKET>
            <TRANSFER_DETAILS>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/TRANSFER_DETAILS) }</TRANSFER_DETAILS>
            <INTERFACE_REFERENCE_NO>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/INTERFACE_REFERENCE_NO) }</INTERFACE_REFERENCE_NO>
            <ITEM_LEVEL_1>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/ITEM_LEVEL_1) }</ITEM_LEVEL_1>
            <ITEM_LEVEL_2>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/ITEM_LEVEL_2) }</ITEM_LEVEL_2>
            <ITEM_LEVEL_3>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/ITEM_LEVEL_3) }</ITEM_LEVEL_3>
            <ITEM_LEVEL_4>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/ITEM_LEVEL_4) }</ITEM_LEVEL_4>
            <ITEM_LEVEL_5>{ data($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/ITEM_LEVEL_5) }</ITEM_LEVEL_5>
            { 
            if(count($sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/REGIONAL_DETAILS)>0) then
           (
            <REGIONAL_DETAILS>
               <SOURCE>
            {
                for $SOURCE in $sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/REGIONAL_DETAILS/SOURCE
                return
                    <KV_PAIR>
                        <KEY> { data($SOURCE/KV_PAIR/KEY) }</KEY>
                        <VALUE>{  data($SOURCE/KV_PAIR/VALUE) } </VALUE>
                    </KV_PAIR>
            }
              </SOURCE>
              <DESTINATION>
            {
                for $DESTINATION in $sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/REGIONAL_DETAILS/DESTINATION
                return
                    <KV_PAIR>
                        <KEY> { data($DESTINATION/KV_PAIR/KEY) }</KEY>
                        <VALUE>{  data($DESTINATION/KV_PAIR/VALUE) } </VALUE>
                    </KV_PAIR>
            }
           </DESTINATION>
           </REGIONAL_DETAILS>,
           <ADDITIONAL_INFO>
            {
                for $ADDITIONAL_INFO in $sjTransferenciaCuentaRequest/TRANSFERS_INT/TRANSFER_INT[$transferIndex]/ADDITIONAL_INFO
                return
                    <INFO>
                        <KEY> { data($ADDITIONAL_INFO/INFO/KEY) }</KEY>
                        <VALUE>{  data($ADDITIONAL_INFO/INFO/VALUE) } </VALUE>
                    </INFO>
            }
            </ADDITIONAL_INFO>
              
           )
           else()
           } 
       </ns0:transferenciaCuentasRequest>
};

declare variable $sjTransferenciaCuentaRequest as element(*) external;
declare variable $transferIndex as xs:integer external;

xf:sjTranferenciaCuentaIN($sjTransferenciaCuentaRequest,
    $transferIndex)
