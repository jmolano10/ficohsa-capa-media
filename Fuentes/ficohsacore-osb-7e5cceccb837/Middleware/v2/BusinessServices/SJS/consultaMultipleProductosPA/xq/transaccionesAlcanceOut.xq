(:: pragma bea:global-element-parameter parameter="$consultarSaldosVasaResponse" element="ns1:ConsultarSaldosVasaResponse" location="../../../ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultiplesProductosPAResponse/ns0:LIABILITIES/ns0:LIABILITY" location="../xsd/sjConsultaMultipleProductosPA.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultiplesProductosPA";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/transaccionesAlcanceOut/";

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string?
{
	if ($codigoMoneda = "840") then "USD"
	else("")

};

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};

declare function xf:transaccionesAlcanceOut($consultarSaldosVasaResponse as element(ns1:ConsultarSaldosVasaResponse),
    $ID as xs:string,$Type as xs:string)
    as element() 
{
    if(data($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:estatusConfirmacion) = '00') then (

        let $valMoneda := string($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta/ns1:moneda[ text() ='840']/text())
        let $valMonedaHNL := string($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta/ns1:moneda[ text() ='340']/text())
        let $valMonedaGTQ := string($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta/ns1:moneda[ text() ='320']/text())
        return
        if($valMoneda != '' and $valMonedaHNL = '' and $valMonedaGTQ = '')then(
            <ns0:LIABILITY> 
                <ns0:ID>{ $ID }</ns0:ID>
                <ns0:PRODUCT_NAME>{ data($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:nombreTitular) }</ns0:PRODUCT_NAME>
                {
                    for $saldos in $consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos
                    return
                    <ns0:BALANCES>
                    {
                        for $ArrayOfStrucSaldosConsulta in $saldos/ns1:ArrayOfStrucSaldosConsulta[ns1:moneda='840']
                        return
                        <ns0:BALANCE>
                            <ns0:CURRENCY>{ local:getMoneda(data($ArrayOfStrucSaldosConsulta/ns1:moneda)) }</ns0:CURRENCY>
                            <ns0:PRINCIPAL>{ numIsNull($ArrayOfStrucSaldosConsulta/ns1:saldoActual) }</ns0:PRINCIPAL>
                            <ns0:INT_COMM>0.0</ns0:INT_COMM>
                            <ns0:TOTAL>{ numIsNull($ArrayOfStrucSaldosConsulta/ns1:saldoActual) }</ns0:TOTAL>
                        </ns0:BALANCE>
                    }
                    </ns0:BALANCES>
                }
                {
                    if (data($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:maxFechaPago) != '' ) then (
                        <ns0:NEXT_PAYMENT_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd',data($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:maxFechaPago)) }</ns0:NEXT_PAYMENT_DATE>
                    )
                    else 
                        ()
                }
                <ns0:TSTANDING_TOTAL>{ numIsNull($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta[ ns1:moneda = '840' ]/ns1:saldoActual) }</ns0:TSTANDING_TOTAL>
                <ns0:CANCELATION_TOTAL>0.0</ns0:CANCELATION_TOTAL>
                <ns0:TOTAL_AMOUNT>0.0</ns0:TOTAL_AMOUNT>  
                <ns0:TYPE>{ $Type }</ns0:TYPE>
                <ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>
                <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>
                <ns0:SUCCESS_INDICATOR>SUCCESS</ns0:SUCCESS_INDICATOR>
            </ns0:LIABILITY>
        )else(
            <ns0:LIABILITY>
                <ns0:ID>{ $ID }</ns0:ID>,
                <ns0:TYPE>{ $Type }</ns0:TYPE>,
                <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>,
                <ns0:SUCCESS_INDICATOR>NO RECORDS</ns0:SUCCESS_INDICATOR>,
                <ns0:ERROR_MESSAGE>PRODUCTO NO ENCONTRADO</ns0:ERROR_MESSAGE>
            </ns0:LIABILITY>
        )    
    )
    else (
        <ns0:LIABILITY>
            <ns0:ID>{ $ID }</ns0:ID>,
            <ns0:TYPE>{ $Type }</ns0:TYPE>,
            <ns0:SOURCE_BANK>PA01</ns0:SOURCE_BANK>,
            <ns0:SUCCESS_INDICATOR>ERROR</ns0:SUCCESS_INDICATOR>,
            <ns0:ERROR_MESSAGE>{ data($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:mensajeConfirmacion) }</ns0:ERROR_MESSAGE>
        </ns0:LIABILITY>
    )
};

declare variable $consultarSaldosVasaResponse as element(ns1:ConsultarSaldosVasaResponse) external;
declare variable $ID as xs:string external;
declare variable $Type as xs:string external;

xf:transaccionesAlcanceOut($consultarSaldosVasaResponse,
    $ID,
    $Type)