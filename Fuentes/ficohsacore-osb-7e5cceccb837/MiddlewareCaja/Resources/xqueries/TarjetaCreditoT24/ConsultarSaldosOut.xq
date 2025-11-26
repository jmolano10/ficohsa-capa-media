(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/ConsultarSaldoTCAbanks/ORA_BANK_OSB_CON_RESCUENTATC.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarSaldosResponse" location="../../wsdls/Alcance.wsdl" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_RESCUENTATC/";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/ConsultarSaldosOut/";

declare function xf:ConsultarSaldosOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultarSaldosResponse) {
        <ns0:consultarSaldosResponse>
            <ns0:consultarSaldosResult>
	            {
	                for $GV_ESTATUSCONFIRMACION in $outputParameters/ns1:GV_ESTATUSCONFIRMACION
	                return
	                    <ns0:estatusConfirmacion>{ data($GV_ESTATUSCONFIRMACION) }</ns0:estatusConfirmacion>
	            }
	            {
	                for $GV_MENSAJECONFIRMACION in $outputParameters/ns1:GV_MENSAJECONFIRMACION
	                return
	                    <ns0:mensajeConfirmacion>{ data($GV_MENSAJECONFIRMACION) }</ns0:mensajeConfirmacion>
	            }
	            {
	                for $GV_NOMBRETITULAR in $outputParameters/ns1:GV_NOMBRETITULAR
	                return
	                    <ns0:nombreTitular>{ data($GV_NOMBRETITULAR) }</ns0:nombreTitular>
	            }
	            <ns0:noTarjetaCreditoTitular>{ data($outputParameters/ns1:GN_NOTARJETA) }</ns0:noTarjetaCreditoTitular>
	            <ns0:numeroCuenta>{ data($outputParameters/ns1:GN_NUMEROCUENTA) }</ns0:numeroCuenta>
	            {
	                for $GV_FECHASALDOS in $outputParameters/ns1:GV_FECHASALDOS
	                return
	                    <ns0:fechaSaldos>{ data($GV_FECHASALDOS) }</ns0:fechaSaldos>
	            }
	            <ns0:puntosAcumulados>{ data($outputParameters/ns1:GN_PUNTOSACUMULADOS) }</ns0:puntosAcumulados>
	            {
	                for $GV_FECHAULTIMOCORTE in $outputParameters/ns1:GV_FECHAULTIMOCORTE
	                return
	                    <ns0:fechaUltimoCorte>{ data($GV_FECHAULTIMOCORTE) }</ns0:fechaUltimoCorte>
	            }
	            {
	                for $GV_FECHAMAXPAGO in $outputParameters/ns1:GV_FECHAMAXPAGO
	                return
	                    <ns0:maxFechaPago>{ data($GV_FECHAMAXPAGO) }</ns0:maxFechaPago>
	            }
	            <ns0:codigocliente>{ data($outputParameters/ns1:GN_CODIGOCLIENTE) }</ns0:codigocliente>
	            <ns0:saldos>
	                <ns0:ArrayOfStrucSaldosConsulta>
	                	<ns0:moneda>340</ns0:moneda>
	                    <ns0:limiteCredito>{ data($outputParameters/ns1:GN_LIMITECREDITOLPS) }</ns0:limiteCredito>
	                    <ns0:disponibleCompras>{ data($outputParameters/ns1:GN_DISPONIBLECOMPRASLPS) }</ns0:disponibleCompras>
	                    <ns0:disponibleRetiros>{ data($outputParameters/ns1:GN_DISPONIBLERETIROSLPS) }</ns0:disponibleRetiros>
	                    <ns0:dispExtraFinanciamiento>{ data($outputParameters/ns1:GN_DISPEXTRAFINANLPS) }</ns0:dispExtraFinanciamiento>
	                    <ns0:saldoExtraFinanciamiento>{ data($outputParameters/ns1:GN_SALDOEXTRAFINANLPS) }</ns0:saldoExtraFinanciamiento>
	                    <ns0:dispConsumoCuotas>{ data($outputParameters/ns1:GN_DISPCONSUMOCUOTASLPS) }</ns0:dispConsumoCuotas>
	                    <ns0:saldoConsumoCuotas>{ data($outputParameters/ns1:GN_SALDOCONSUMOCUOTASLPS) }</ns0:saldoConsumoCuotas>
	                    <ns0:saldoActual>{ data($outputParameters/ns1:GN_SALDOACTUALLPS) }</ns0:saldoActual>
	                    <ns0:saldoVencido>{ data($outputParameters/ns1:GN_SALDOVENCIDOLPS) }</ns0:saldoVencido>
	                    <ns0:saldoFlotante>{ data($outputParameters/ns1:GN_SALDOFLOTANTELPS) }</ns0:saldoFlotante>
	                    <ns0:pagoContado>{ data($outputParameters/ns1:GN_PAGOCONTADOLPS) }</ns0:pagoContado>
	                    <ns0:pagoMinimo>{ data($outputParameters/ns1:GN_PAGOMINIMOLPS) }</ns0:pagoMinimo>
	                    <ns0:pagosDia>{ data($outputParameters/ns1:GN_PAGOSDIALPS) }</ns0:pagosDia>
	                </ns0:ArrayOfStrucSaldosConsulta>
	                <ns0:ArrayOfStrucSaldosConsulta>
	                    <ns0:moneda>840</ns0:moneda>
	                    <ns0:limiteCredito>{ data($outputParameters/ns1:GN_LIMITECREDITOUSD) }</ns0:limiteCredito>
	                    <ns0:disponibleCompras>{ data($outputParameters/ns1:GN_DISPONIBLECOMPRASUSD) }</ns0:disponibleCompras>
	                    <ns0:disponibleRetiros>{ data($outputParameters/ns1:GN_DISPONIBLERETIROSUSD) }</ns0:disponibleRetiros>
	                    <ns0:dispExtraFinanciamiento>{ data($outputParameters/ns1:GN_DISPEXTRAFINANUSD) }</ns0:dispExtraFinanciamiento>
	                    <ns0:saldoExtraFinanciamiento>{ data($outputParameters/ns1:GN_SALDOEXTRAFINANUSD) }</ns0:saldoExtraFinanciamiento>
	                    <ns0:dispConsumoCuotas>{ data($outputParameters/ns1:GN_DISPCONSUMOCUOTASUSD) }</ns0:dispConsumoCuotas>
	                    <ns0:saldoConsumoCuotas>{ data($outputParameters/ns1:GN_SALDOCONSUMOCUOTASUSD) }</ns0:saldoConsumoCuotas>
	                    <ns0:saldoActual>{ data($outputParameters/ns1:GN_SALDOACTUALUSD) }</ns0:saldoActual>
	                    <ns0:saldoVencido>{ data($outputParameters/ns1:GN_SALDOVENCIDOUSD) }</ns0:saldoVencido>
	                    <ns0:saldoFlotante>{ data($outputParameters/ns1:GN_SALDOFLOTANTEUSD) }</ns0:saldoFlotante>
	                    <ns0:pagoContado>{ data($outputParameters/ns1:GN_PAGOCONTADOUSD) }</ns0:pagoContado>
	                    <ns0:pagoMinimo>{ data($outputParameters/ns1:GN_PAGOMINIMOUSD) }</ns0:pagoMinimo>
	                    <ns0:pagosDia>{ data($outputParameters/ns1:GN_PAGOSDIAUSD) }</ns0:pagosDia>
	                </ns0:ArrayOfStrucSaldosConsulta>
	            </ns0:saldos>
            </ns0:consultarSaldosResult>
        </ns0:consultarSaldosResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultarSaldosOut($outputParameters)