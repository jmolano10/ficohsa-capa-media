(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns0:consultaSaldosTarjetaCreditoResponse" location="../../tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/ConsultaSaldosTCOut/";

declare function xf:ConsultaSaldosTCOut($consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse),
    $tasaCambio as xs:string)
    as element(*)* {
    	let $monedaLocal := data($consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType[1]/ns0:consultaSaldosTarjetaCreditoResponseRecordType[1]/CURRENCY)
    	let $monedaExtr  := data($consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType[1]/ns0:consultaSaldosTarjetaCreditoResponseRecordType[2]/CURRENCY)
    	let $saldoLocal  := data($consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType[1]/ns0:consultaSaldosTarjetaCreditoResponseRecordType[1]/CURRENT_BALANCE)
    	let $saldoExtr   := data($consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType[1]/ns0:consultaSaldosTarjetaCreditoResponseRecordType[2]/CURRENT_BALANCE)
    	let $saldoTotal	 := fn-bea:format-number(fn:round-half-to-even($saldoLocal + ( $saldoExtr * number($tasaCambio)), 2),"######0.00")
    	return
    	<Tarjeta>
    		<LOCAL_CURRENCY>{ $monedaLocal }</LOCAL_CURRENCY>
    		<LOCAL_BALANCE>{ $saldoLocal }</LOCAL_BALANCE>
    		<FOREIGN_CURRENCY>{ $monedaExtr }</FOREIGN_CURRENCY>
    		<FOREIGN_BALANCE>{ $saldoExtr }</FOREIGN_BALANCE>
    		{
    			if (fn:string($saldoTotal) != "NaN") then (
    				<TOTAL_AMOUNT>{ $saldoTotal }</TOTAL_AMOUNT>
    			) else (
    				<TOTAL_AMOUNT>-0.0</TOTAL_AMOUNT>
    			)
        	}
        </Tarjeta>
};

declare variable $consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse) external;
declare variable $tasaCambio as xs:string external;

xf:ConsultaSaldosTCOut($consultaSaldosTarjetaCreditoResponse,
    $tasaCambio)