xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaActivosClienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaListaDepositos/xq/consultaListaDepositosOut/";

declare function xf:consultaListaDepositosOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaActivosClienteResponse) {
        <ns0:consultaActivosClienteResponse>
            <ns0:consultaActivosClienteDepositosResponseType>
            {
				let $assetType := $outputParameters1/ns1:ASSET_TYPE
				let $assetNumber := $outputParameters1/ns1:ASSET_NUMBER/ns1:ASSET_NUMBER_ITEM
				let $assetName := $outputParameters1/ns1:ASSET_NAME/ns1:ASSET_NAME_ITEM
				let $assetCurrency := $outputParameters1/ns1:ASSET_CURRENCY/ns1:ASSET_NUMBER_ITEM
				let $assetTotalBalance := $outputParameters1/ns1:ASSET_TOTAL_BALANCE/ns1:ASSET_NUMBER_ITEM
				let $assetReserveBalance := $outputParameters1/ns1:ASSET_RESERVE_BALANCE/ns1:ASSET_NUMBER_ITEM
				let $assetLockedBalance := $outputParameters1/ns1:ASSET_LOCKED_BALANCE/ns1:ASSET_NUMBER_ITEM
				let $assetVisaFloatingBalance := $outputParameters1/ns1:ASSET_VISA_FLOATING_BALANCE/ns1:ASSET_NUMBER_ITEM
				let $assetAvailableBalance := $outputParameters1/ns1:ASSET_AVAILABLE_BALANCE/ns1:ASSET_NUMBER_ITEM
				            
				for $i in (1 to count($assetNumber))
				return 
                <ns0:consultaActivosClienteResponseRecordType>
	                <ASSET_TYPE>{ data($assetType) }</ASSET_TYPE>
	            	<ASSET_NUMBER>{ data($assetNumber[$i]) }</ASSET_NUMBER>
	                <ASSET_NAME>{ data($assetName[$i]) }</ASSET_NAME>
	                <ASSET_CURRENCY>{ data($assetCurrency[$i]) }</ASSET_CURRENCY>
	                <ASSET_TOTAL_BALANCE>{ data($assetTotalBalance[$i]) }</ASSET_TOTAL_BALANCE>
	                <ASSET_RESERVE_BALANCE>{ data($assetReserveBalance[$i]) }</ASSET_RESERVE_BALANCE>
	                <ASSET_LOCKED_BALANCE>{ data($assetLockedBalance[$i]) }</ASSET_LOCKED_BALANCE>
	                <ASSET_VISA_FLOATING_BALANCE>{ data($assetVisaFloatingBalance[$i]) }</ASSET_VISA_FLOATING_BALANCE>
	                <ASSET_AVAILABLE_BALANCE>{ data($assetAvailableBalance[$i]) }</ASSET_AVAILABLE_BALANCE>
                </ns0:consultaActivosClienteResponseRecordType>
            }
            </ns0:consultaActivosClienteDepositosResponseType>
            <ns0:consultaActivosClienteCorrienteResponseType/>
            <ns0:consultaActivosClienteAhorrosResponseType/>
        </ns0:consultaActivosClienteResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaListaDepositosOut($outputParameters1)