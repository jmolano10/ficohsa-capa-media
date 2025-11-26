(:: pragma bea:local-element-parameter parameter="$PT_CAMPOSPORSERVICIO" type="ns1:OutputParameters/ns1:PT_CAMPOSPORSERVICIO" location="../../../ABKHN/consultaParametrosCBR/xsd/consultaParametrosCBR_sp.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$DEBTOR" type="ns0:sjConsultaCobranzas/SERVICES/SERVICE/DEBTORS/DEBTOR" location="../xsd/sjConsultaCobranzasH2H.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaRecaudo" location="../../../OSB/consultaRecaudo_v2/xsd/XMLSchema_-844801591.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaParametrosCBR";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/consultaCobranzasH2H/xq/InfoFieldValidationByDebtor/";

declare function xf:InfoFieldValidationByDebtor($PT_CAMPOSPORSERVICIO as element(),
    $DEBTOR as element(),
    $contractId as xs:string,
    $localCurrency as xs:string)
    as element(ns2:consultaRecaudo) {
        <ns2:consultaRecaudo>
        {
        	if ( count($PT_CAMPOSPORSERVICIO/ns1:PT_CAMPOSPORSERVICIO_ITEM) = 0 ) then (
        		<CONTRACT_ID>{ $contractId }</CONTRACT_ID>,
	            <DEBTOR_CODE>{ data($DEBTOR/CODE) }</DEBTOR_CODE>,
	            <CURRENCY>
	            { 
	            	let $currency := data($DEBTOR/CURRENCY) 
            		return
	            		if ($currency = '') then(
	            			$localCurrency
	            		)else(
	            			$currency
	            		)	
	            }
	            </CURRENCY>,
	            <BILL_RETURN_TYPE>{ data($DEBTOR/RETURN_TYPE) }</BILL_RETURN_TYPE>,
	            <EXTENDED_COLLECTION_YES_NO>{ data($DEBTOR/EXTENDED_COLLECTION) }</EXTENDED_COLLECTION_YES_NO>
        	) else (
        		let $maxPosicion := xs:int(max($PT_CAMPOSPORSERVICIO/ns1:PT_CAMPOSPORSERVICIO_ITEM/ns1:POSICION_DESTINO))
        		let $data := for $posicion in 1 to $maxPosicion
        			let $campoOrigen := string($PT_CAMPOSPORSERVICIO/ns1:PT_CAMPOSPORSERVICIO_ITEM[ ns1:POSICION_DESTINO = $posicion ]/ns1:CAMPO_ORIGEN/text())
	        		return
	        			if( $campoOrigen = '' ) then (
	        				<DATA></DATA>
	        			)else (
	        				let $fieldValue := string($DEBTOR/ADDITIONAL_INFO/INFO[ FIELD_NAME = $campoOrigen ]/FIELD_VALUE/text())
	        				return
	        					if ( $fieldValue = '' ) then (
	        						<DATA>ERROR</DATA>
	        					) else (
	        						<DATA>{ $fieldValue }</DATA>
	        					)
	        			)
	        	let $errorData := $data[text() = 'ERROR'][1]
	        	return
	        		if ( string($errorData/text()) = '' )then (
	        			<CONTRACT_ID>{ $contractId }</CONTRACT_ID>,
					    <DEBTOR_CODE>{ data($DEBTOR/CODE) }</DEBTOR_CODE>,
					    <CURRENCY>
			            { 
			            	let $currency := fn:string($DEBTOR/CURRENCY/text()) 
		            		return
			            		if ($currency = '') then(
			            			$localCurrency
			            		)else(
			            			$currency
			            		)	
			            }
					    </CURRENCY>,
					    <BILL_RETURN_TYPE>{ data($DEBTOR/RETURN_TYPE) }</BILL_RETURN_TYPE>,
					    <EXTENDED_COLLECTION_YES_NO>{ data($DEBTOR/EXTENDED_COLLECTION) }</EXTENDED_COLLECTION_YES_NO>,
					    <ADDITIONAL_INFO>{ $data }</ADDITIONAL_INFO>
	        		)else()
	        )
        }
        </ns2:consultaRecaudo>
};

declare variable $PT_CAMPOSPORSERVICIO as element() external;
declare variable $DEBTOR as element() external;
declare variable $contractId as xs:string external;
declare variable $localCurrency as xs:string external;

xf:InfoFieldValidationByDebtor($PT_CAMPOSPORSERVICIO,
    $DEBTOR,
    $contractId,
    $localCurrency)