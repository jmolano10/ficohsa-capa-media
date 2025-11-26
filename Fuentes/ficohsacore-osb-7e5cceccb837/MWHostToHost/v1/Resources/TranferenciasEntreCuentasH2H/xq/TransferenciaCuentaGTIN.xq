(:: pragma bea:global-element-parameter parameter="$transferenciaEntreCuentaH2HIN" element="ns2:transferenciaEntreCuentaH2H" location="../xsd/transferenciaCuentasH2HType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjTransferenciaEntreCuentas" location="../../../BusinessServices/SJS/TransferenciasEntreCuentaH2H/xsd/sjTransferenciaEntreCuentasH2H.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjTransfersH2HTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciaEntreCuentaH2HType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TranferenciasEntreCuentasH2H/xq/TransferenciaCuentaIN/";

declare function xf:TransferenciaCuentaIN($UserName as xs:string,
    $Password as xs:string,
    $SourceBank as xs:string,
    $transferenciaEntreCuentaH2HIN as element(ns2:transferenciaEntreCuentaH2H))
    as element(ns0:sjTransferenciaEntreCuentas) {
        <ns0:sjTransferenciaEntreCuentas>
            <CUSTOMER_ID>{ data($transferenciaEntreCuentaH2HIN/CUSTOMER_ID) }</CUSTOMER_ID>
            <USER_NAME>{ $UserName }</USER_NAME>
            <PASSWORD>{ $Password }</PASSWORD>
            <SOURCE_BANK>{ $SourceBank }</SOURCE_BANK>
            {
		<TRANSFERS_INT>
			{
			for $transferInt in $transferenciaEntreCuentaH2HIN/TRANSFERS_INT/TRANSFER_INT
			return
			<TRANSFER_INT>
			    <TRACE>{ data($transferInt/TRACE) }</TRACE>
				<DEBIT_ACCOUNT>{ data($transferInt/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                <CREDIT_ACCOUNT>{ data($transferInt/CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>         
                <CURRENCY>{ data($transferInt/CURRENCY) }</CURRENCY>
                <TRANSFER_AMOUNT>{ data($transferInt/TRANSFER_AMOUNT) }</TRANSFER_AMOUNT>
                <DEBIT_CREDIT>{ data($transferInt/DEBIT_CREDIT) }</DEBIT_CREDIT>
                <DESCRIPTION>{ data($transferInt/DESCRIPTION) }</DESCRIPTION>
               <AUTHORIZATION_TICKET>{ data($transferInt/AUTHORIZATION_TICKET) }</AUTHORIZATION_TICKET>
               <TRANSFER_DETAILS>{ data($transferInt/TRANSFER_DETAILS) }</TRANSFER_DETAILS>
               <INTERFACE_REFERENCE_NO>{ data($transferInt/INTERFACE_REFERENCE_NO) }</INTERFACE_REFERENCE_NO>
              <ITEM_LEVEL_1>{ data($transferInt/ITEM_LEVEL_1) }</ITEM_LEVEL_1>
              <ITEM_LEVEL_2>{ data($transferInt/ITEM_LEVEL_2) }</ITEM_LEVEL_2>
              <ITEM_LEVEL_3>{ data($transferInt/ITEM_LEVEL_3) }</ITEM_LEVEL_3>
              <ITEM_LEVEL_4>{ data($transferInt/ITEM_LEVEL_4) }</ITEM_LEVEL_4>
              <ITEM_LEVEL_5>{ data($transferInt/ITEM_LEVEL_5) }</ITEM_LEVEL_5>
               { 
            if(count($transferInt/REGIONAL_DETAILS)>0) then
           (
            <REGIONAL_DETAILS>
               <SOURCE>
            {
                for $SOURCE in $transferInt/REGIONAL_DETAILS/SOURCE
                return
                    <KV_PAIR>
                        <KEY> { data($SOURCE/KV_PAIR/KEY) }</KEY>
                        <VALUE>{  data($SOURCE/KV_PAIR/VALUE) } </VALUE>
                    </KV_PAIR>
            }
              </SOURCE>
              <DESTINATION>
            {
                for $DESTINATION in $transferInt/REGIONAL_DETAILS/DESTINATION
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
                for $ADDITIONAL_INFO in $transferInt/ADDITIONAL_INFO
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
            </TRANSFER_INT>
			}
		</TRANSFERS_INT>
		}
        </ns0:sjTransferenciaEntreCuentas>
};

declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $SourceBank as xs:string external;
declare variable $transferenciaEntreCuentaH2HIN as element(ns2:transferenciaEntreCuentaH2H) external;

xf:TransferenciaCuentaIN($UserName,
    $Password,
    $SourceBank,
    $transferenciaEntreCuentaH2HIN)
