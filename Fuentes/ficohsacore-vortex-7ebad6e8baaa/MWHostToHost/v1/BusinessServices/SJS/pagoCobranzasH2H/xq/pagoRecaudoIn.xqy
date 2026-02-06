xquery version "2004-draft";
(:: pragma bea:local-element-parameter parameter="$PT_CAMPOSPORSERVICIO" type="ns2:OutputParameters/ns2:PT_CAMPOSPORSERVICIO" location="../../../ABKHN/consultaParametrosCBR/xsd/consultaParametrosCBR_sp.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$PAYMENT_INFORMATION" type="ns0:sjPagoCobranzas/SERVICES/SERVICE/PAYMENT_INFORMATION" location="../xsd/sjPagoCobranzasH2H.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$DEBTOR" type="ns0:sjPagoCobranzas/SERVICES/SERVICE/DEBTORS/DEBTOR" location="../xsd/sjPagoCobranzasH2H.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudo" location="../../../OSB/pagoRecaudo_v2/xsd/XMLSchema_-909699091.xsd" ::)

declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/pagoCobranzasH2H/xq/pagoRecaudoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaParametrosCBR";

declare function xf:pagoRecaudoIn($PT_CAMPOSPORSERVICIO as element(),
    $PAYMENT_INFORMATION as element(),
    $DEBTOR as element(),
    $contractID as xs:string)
    as element(ns1:pagoRecaudo) {
        <ns1:pagoRecaudo>
        {
            if ( count($PT_CAMPOSPORSERVICIO/ns2:PT_CAMPOSPORSERVICIO_ITEM) = 0 ) then (
                <CONTRACT_ID>{ $contractID }</CONTRACT_ID>,
            	<DEBTOR_CODE>{ data($DEBTOR/CODE) }</DEBTOR_CODE>,
           		 <PAYMENT_INFORMATION>
                	<PAYMENT_METHOD>{ data($PAYMENT_INFORMATION/PYMT_METHOD) }</PAYMENT_METHOD>
                	<PAYMENT_CURRENCY>{ data($PAYMENT_INFORMATION/PYMT_CURRENCY) }</PAYMENT_CURRENCY>
                	<PAYMENT_AMOUNT>{ data($DEBTOR/AMOUNT) }</PAYMENT_AMOUNT>
                	<DEBIT_ACCOUNT>{ data($PAYMENT_INFORMATION/PYMT_ID) }</DEBIT_ACCOUNT>
           		 </PAYMENT_INFORMATION>,
           		<EXTENDED_COLLECTION_YES_NO>{ data($DEBTOR/EXTENDED_COLLECTION) }</EXTENDED_COLLECTION_YES_NO>            
            )else(
            	let $maxPosicion := xs:int(max($PT_CAMPOSPORSERVICIO/ns2:PT_CAMPOSPORSERVICIO_ITEM/ns2:POSICION_DESTINO))
        		let $data := for $posicion in 1 to $maxPosicion
        			let $campoOrigen := string($PT_CAMPOSPORSERVICIO/ns2:PT_CAMPOSPORSERVICIO_ITEM[ ns2:POSICION_DESTINO = $posicion ]/ns2:CAMPO_ORIGEN/text())
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
	        			<CONTRACT_ID>{ $contractID }</CONTRACT_ID>,
            			<DEBTOR_CODE>{ data($DEBTOR/CODE) }</DEBTOR_CODE>,
            			<PAYMENT_INFORMATION>
                			<PAYMENT_METHOD>{ data($PAYMENT_INFORMATION/PYMT_METHOD) }</PAYMENT_METHOD>
                			<PAYMENT_CURRENCY>{ data($PAYMENT_INFORMATION/PYMT_CURRENCY) }</PAYMENT_CURRENCY>
                			<PAYMENT_AMOUNT>{ data($DEBTOR/AMOUNT) }</PAYMENT_AMOUNT>
                			<DEBIT_ACCOUNT>{ data($PAYMENT_INFORMATION/PYMT_ID) }</DEBIT_ACCOUNT>
           		 		</PAYMENT_INFORMATION>,
           				<EXTENDED_COLLECTION_YES_NO>{ data($DEBTOR/EXTENDED_COLLECTION) }</EXTENDED_COLLECTION_YES_NO>,  
					    <ADDITIONAL_INFO>{ $data }</ADDITIONAL_INFO>
	        		)else()
            )
        }
        </ns1:pagoRecaudo>
};

declare variable $PT_CAMPOSPORSERVICIO as element() external;
declare variable $PAYMENT_INFORMATION as element() external;
declare variable $DEBTOR as element() external;
declare variable $contractID as xs:string external;

xf:pagoRecaudoIn($PT_CAMPOSPORSERVICIO,
    $PAYMENT_INFORMATION,
    $DEBTOR,
    $contractID)