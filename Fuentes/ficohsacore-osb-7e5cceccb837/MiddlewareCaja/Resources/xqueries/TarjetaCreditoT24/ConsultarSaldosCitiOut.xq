(:: pragma  parameter="$responseParameters" type="anyType" ::)
(:: pragma  parameter="$response" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultarSaldosResponse" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/ConsultarSaldosCitiOut/";

declare function xf:ConsultarSaldosCitiOut($responseParameters as element(*),
    $response as element(*))
    as element(ns0:consultarSaldosResponse) {
        <ns0:consultarSaldosResponse>
            { 
        	for $ITEM at $i in $responseParameters
			return	
			
        	<ns0:consultarSaldosResult>
        	{        	
        	if (fn:string($ITEM/errorCode)="0") then (
            	<ns0:estatusConfirmacion>00</ns0:estatusConfirmacion>
            )
            else (
            	<ns0:estatusConfirmacion>{ data($ITEM/errorCode) }</ns0:estatusConfirmacion>
            )
            }            
            <ns0:mensajeConfirmacion>{ data($ITEM/errorMessage) }</ns0:mensajeConfirmacion>
            <ns0:nombreTitular>{ data($ITEM/moreParameters/data[@fieldName='debtorName']) }</ns0:nombreTitular>
            <ns0:noTarjetaCreditoTitular>{ data($ITEM/primaryKey) }</ns0:noTarjetaCreditoTitular>
            <ns0:numeroCuenta></ns0:numeroCuenta>
            <ns0:fechaSaldos>{ data($ITEM/coreRunningDate) }</ns0:fechaSaldos>
            <ns0:puntosAcumulados></ns0:puntosAcumulados>
            <ns0:fechaUltimoCorte></ns0:fechaUltimoCorte>
            <ns0:maxFechaPago></ns0:maxFechaPago>
            <ns0:codigocliente></ns0:codigocliente>
            <ns0:saldos>
               <ns0:ArrayOfStrucSaldosConsulta>
                  <ns0:moneda>340</ns0:moneda>
                  <ns0:limiteCredito>0</ns0:limiteCredito>
                  <ns0:disponibleCompras>0</ns0:disponibleCompras>
                  <ns0:disponibleRetiros>0</ns0:disponibleRetiros>
                  <ns0:dispExtraFinanciamiento>0</ns0:dispExtraFinanciamiento>
                  <ns0:saldoExtraFinanciamiento>0</ns0:saldoExtraFinanciamiento>
                  <ns0:dispConsumoCuotas>0</ns0:dispConsumoCuotas>
                  <ns0:saldoConsumoCuotas>0</ns0:saldoConsumoCuotas>
                  <ns0:saldoActual>{ data($ITEM/totalAmount) }</ns0:saldoActual>
                  <ns0:saldoVencido>0</ns0:saldoVencido>
                  <ns0:saldoFlotante>0</ns0:saldoFlotante>
                  <ns0:pagoContado>0</ns0:pagoContado>
                  <ns0:pagoMinimo>0</ns0:pagoMinimo>
                  <ns0:pagosDia>0</ns0:pagosDia>
               </ns0:ArrayOfStrucSaldosConsulta>
               <ns0:ArrayOfStrucSaldosConsulta>
                  <ns0:moneda>840</ns0:moneda>
                  <ns0:limiteCredito>0</ns0:limiteCredito>
                  <ns0:disponibleCompras>0</ns0:disponibleCompras>
                  <ns0:disponibleRetiros>0</ns0:disponibleRetiros>
                  <ns0:dispExtraFinanciamiento>0</ns0:dispExtraFinanciamiento>
                  <ns0:saldoExtraFinanciamiento>0</ns0:saldoExtraFinanciamiento>
                  <ns0:dispConsumoCuotas>0</ns0:dispConsumoCuotas>
                  <ns0:saldoConsumoCuotas>0</ns0:saldoConsumoCuotas>
                  <ns0:saldoActual>{ data($ITEM/totalAmount) }</ns0:saldoActual>
                  <ns0:saldoVencido>0</ns0:saldoVencido>
                  <ns0:saldoFlotante>0</ns0:saldoFlotante>
                  <ns0:pagoContado>0</ns0:pagoContado>
                  <ns0:pagoMinimo>0</ns0:pagoMinimo>
                  <ns0:pagosDia>0</ns0:pagosDia>
               </ns0:ArrayOfStrucSaldosConsulta>
            </ns0:saldos>
         </ns0:consultarSaldosResult>
         }        	            
        </ns0:consultarSaldosResponse>
};

declare variable $responseParameters as element(*) external;
declare variable $response as element(*) external;

xf:ConsultarSaldosCitiOut($responseParameters,
    $response)