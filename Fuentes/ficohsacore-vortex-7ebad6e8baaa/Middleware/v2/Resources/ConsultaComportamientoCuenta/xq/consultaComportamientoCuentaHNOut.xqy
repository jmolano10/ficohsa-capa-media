xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDatoComportamientoCuenta/xsd/conDatoComportamientoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComportamientoCuentaResponse" location="../xsd/consultaComportamientoCuentaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComportamientoCuenta/xq/consultaComportamientoCuentaHNOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComportamientoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoComportamientoCuenta";

declare function xf:consultaComportamientoCuentaHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaComportamientoCuentaResponse) {
        <ns0:consultaComportamientoCuentaResponse>
        {
        	for $accountNumber in $outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[lower-case(@name) = 'numcuenta']
        	return
        	<ACCOUNT_NUMBER>{ data($accountNumber) }</ACCOUNT_NUMBER>,
        	<CYCLES_SUMMARY>
        	{
        		for $row in $outputParameters/ns1:RowSet/ns1:Row
        		return(
        			<CYCLE_SUMMARY>
        			{
        				for $org in $row/ns1:Column[lower-case(@name) = 'org']
        				return
        				<ORG>{ data($org) }</ORG>,
        			
        				for $pastCycleIndex in $row/ns1:Column[lower-case(@name) = 'ciclosatras']
        				return
        				<PAST_CYCLE_INDEX>{ data($pastCycleIndex) }</PAST_CYCLE_INDEX>,
        			
        				for $purchaseAmount in $row/ns1:Column[lower-case(@name) = 'montocompra']
        				return
        				<PURCHASE_AMOUNT>{ data($purchaseAmount) }</PURCHASE_AMOUNT>,
        			
        				for $withDrawalAmount in $row/ns1:Column[lower-case(@name) = 'montoretiro']
        				return
        				<WITHDRAWAL_AMOUNT>{ data($withDrawalAmount) }</WITHDRAWAL_AMOUNT>
        			}
        			</CYCLE_SUMMARY>
        		)
        	}
        	</CYCLES_SUMMARY>
        }
        </ns0:consultaComportamientoCuentaResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaComportamientoCuentaHNOut($outputParameters)