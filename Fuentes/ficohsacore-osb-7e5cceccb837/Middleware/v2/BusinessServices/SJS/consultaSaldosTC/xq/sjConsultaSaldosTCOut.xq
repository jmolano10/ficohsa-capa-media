(:: pragma bea:global-element-parameter parameter="$informacionTarjetaResponse1" element="ns0:InformacionTarjetaResponse" location="../../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$consultarSaldosResponse1" element="ns0:consultarSaldosResponse" location="../../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaSaldosTCResponse" location="../xsd/sjConsultaSaldosTC.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xq/sjConsultaSaldosTCOut/";

declare function xf:sjConsultaSaldosTCOut($informacionTarjetaResponse1 as element(ns0:InformacionTarjetaResponse),
    $consultarSaldosResponse1 as element(ns0:consultarSaldosResponse),
    $NumeroTarjetaCredito as xs:string)
    as element(ns1:sjConsultaSaldosTCResponse) {
        <ns1:sjConsultaSaldosTCResponse>
          <consultaDatosTCResponse>
                <CARD_NUMBER>{ $NumeroTarjetaCredito }</CARD_NUMBER>
                {
                    for $NombreTarjetaTitular in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:NombreTarjetaTitular
                    return
                        <ACCOUNT_HOLDER_NAME>{ data($NombreTarjetaTitular) }</ACCOUNT_HOLDER_NAME>
                }
                {
                    for $NombreTarjetaHabiente in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:NombreTarjetaHabiente
                    return
                        <CARD_HOLDER_NAME>{ data($NombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                }
                {
                    for $TipoTarjeta in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:TipoTarjeta
                    return
                        <CARD_TYPE>{ data($TipoTarjeta) }</CARD_TYPE>
                }
                {
                    for $CodigoClienteCuenta in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:CodigoClienteCuenta
                    return
                        <CUSTOMER_ID>{ data($CodigoClienteCuenta) }</CUSTOMER_ID>
                }
                {
                    for $IdentificacionCLienteTarjeta in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:IdentificacionCLienteTarjeta
                    return
                        <CARD_HOLDER_LEGAL_ID>{ data($IdentificacionCLienteTarjeta) }</CARD_HOLDER_LEGAL_ID>
                }
                {
                    for $IdentificacionClienteCuenta in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:IdentificacionClienteCuenta
                    return
                        <ACCOUNT_HOLDER_LEGAL_ID>{ data($IdentificacionClienteCuenta) }</ACCOUNT_HOLDER_LEGAL_ID>
                }
                {
                    for $NumeroCuenta in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:NumeroCuenta
                    return
                        <ACCOUNT_NUMBER>{ data($NumeroCuenta) }</ACCOUNT_NUMBER>
                }
                {
                    for $Producto in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:Producto
                    return
                        <PRODUCT>{ data($Producto) }</PRODUCT>
                }
                {
                    for $Producto_descripcion in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:Producto_descripcion
                    return
                        <PRODUCT_DESCRIPTION>{ data($Producto_descripcion) }</PRODUCT_DESCRIPTION>
                }
                {
                    for $GrupoAfinidad in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:GrupoAfinidad
                    return
                        <AFINITY_GROUP>{ data($GrupoAfinidad) }</AFINITY_GROUP>
                }
                {
                    for $EstadoCuenta in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:EstadoCuenta
                    return
                        <ACCOUNT_STATUS>{ data($EstadoCuenta) }</ACCOUNT_STATUS>
                }
                {
                    for $EstadoTarjeta in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:EstadoTarjeta
                    return
                        <CARD_STATUS>{ data($EstadoTarjeta) }</CARD_STATUS>
                }
                {
                    for $FechaVencimiento in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:FechaVencimiento
                    return
                        <CARD_EXPIRATION_DATE>{ data($FechaVencimiento) }</CARD_EXPIRATION_DATE>
                }
                {
                    for $EstatusConfirmacion in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:EstatusConfirmacion
                    return
                        <STATUS>{ data($EstatusConfirmacion) }</STATUS>
                }
                {
                    for $MensajeConfirmacion in $informacionTarjetaResponse1/ns0:InformacionTarjetaResult/ns0:MensajeConfirmacion
                    return
                        <MESSAGES>{ data($MensajeConfirmacion) }</MESSAGES>
                }
            </consultaDatosTCResponse>
            <consultarSaldosResponse>
                <consultarSaldosResult>
                    {
                        for $estatusConfirmacion in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:estatusConfirmacion
                        return
                            <estatusConfirmacion>{ data($estatusConfirmacion) }</estatusConfirmacion>
                    }
                    {
                        for $mensajeConfirmacion in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:mensajeConfirmacion
                        return
                            <mensajeConfirmacion>{ data($mensajeConfirmacion) }</mensajeConfirmacion>
                    }
                    {
                        for $nombreTitular in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:nombreTitular
                        return
                            <nombreTitular>{ data($nombreTitular) }</nombreTitular>
                    }
                    {
                        for $noTarjetaCreditoTitular in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:noTarjetaCreditoTitular
                        return
                            <noTarjetaCreditoTitular>{ data($noTarjetaCreditoTitular) }</noTarjetaCreditoTitular>
                    }
                    {
                        for $numeroCuenta in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:numeroCuenta
                        return
                            <numeroCuenta>{ data($numeroCuenta) }</numeroCuenta>
                    }
                    {
                        for $fechaSaldos in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:fechaSaldos
                        return
                            <fechaSaldos>{ data($fechaSaldos) }</fechaSaldos>
                    }
                    {
                        for $puntosAcumulados in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:puntosAcumulados
                        return
                            <puntosAcumulados>{ data($puntosAcumulados) }</puntosAcumulados>
                    }
                    {
                        for $fechaUltimoCorte in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:fechaUltimoCorte
                        return
                            <fechaUltimoCorte>{ data($fechaUltimoCorte) }</fechaUltimoCorte>
                    }
                    {
                        for $maxFechaPago in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:maxFechaPago
                        return
                            <maxFechaPago>{ data($maxFechaPago) }</maxFechaPago>
                    }
                    {
                        for $codigocliente in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:codigocliente
                        return
                            <codigocliente>{ data($codigocliente) }</codigocliente>
                    }
                    {
                        for $saldos in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:saldos
                        return
                            <saldos>
                                {
                                    for $ArrayOfStrucSaldosConsulta in $saldos/ns0:ArrayOfStrucSaldosConsulta
                                    return
                                        <ArrayOfStrucSaldosConsulta>
                                            {
                                                for $moneda in $ArrayOfStrucSaldosConsulta/ns0:moneda
                                                return
                                                    <moneda>{ data($moneda) }</moneda>
                                            }
                                            <limiteCredito>{ data($ArrayOfStrucSaldosConsulta/ns0:limiteCredito) }</limiteCredito>
                                            <disponibleCompras>{ data($ArrayOfStrucSaldosConsulta/ns0:disponibleCompras) }</disponibleCompras>
                                            <disponibleRetiros>{ data($ArrayOfStrucSaldosConsulta/ns0:disponibleRetiros) }</disponibleRetiros>
                                            <dispExtraFinanciamiento>{ data($ArrayOfStrucSaldosConsulta/ns0:dispExtraFinanciamiento) }</dispExtraFinanciamiento>
                                            <saldoExtraFinanciamiento>{ data($ArrayOfStrucSaldosConsulta/ns0:saldoExtraFinanciamiento) }</saldoExtraFinanciamiento>
                                            <dispConsumoCuotas>{ data($ArrayOfStrucSaldosConsulta/ns0:dispConsumoCuotas) }</dispConsumoCuotas>
                                            <saldoConsumoCuotas>{ data($ArrayOfStrucSaldosConsulta/ns0:saldoConsumoCuotas) }</saldoConsumoCuotas>
                                            <saldoActual>{ data($ArrayOfStrucSaldosConsulta/ns0:saldoActual) }</saldoActual>
                                            <saldoVencido>{ data($ArrayOfStrucSaldosConsulta/ns0:saldoVencido) }</saldoVencido>
                                            <saldoFlotante>{ data($ArrayOfStrucSaldosConsulta/ns0:saldoFlotante) }</saldoFlotante>
                                            <pagoContado>{ data($ArrayOfStrucSaldosConsulta/ns0:pagoContado) }</pagoContado>
                                            <pagoMinimo>{ data($ArrayOfStrucSaldosConsulta/ns0:pagoMinimo) }</pagoMinimo>
                                            <pagosDia>{ data($ArrayOfStrucSaldosConsulta/ns0:pagosDia) }</pagosDia>
                                        </ArrayOfStrucSaldosConsulta>
                                }
                            </saldos>
                    }
                </consultarSaldosResult>
            </consultarSaldosResponse>

        </ns1:sjConsultaSaldosTCResponse>
};

declare variable $informacionTarjetaResponse1 as element(ns0:InformacionTarjetaResponse) external;
declare variable $consultarSaldosResponse1 as element(ns0:consultarSaldosResponse) external;
declare variable $NumeroTarjetaCredito as xs:string external;

xf:sjConsultaSaldosTCOut($informacionTarjetaResponse1,
    $consultarSaldosResponse1,
    $NumeroTarjetaCredito)