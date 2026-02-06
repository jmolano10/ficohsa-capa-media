xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$informacionTarjetaResponse1" element="ns1:InformacionTarjetaResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito1" element="ns0:consultaDatosTarjetaCredito" location="consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaCreditoResponse" location="consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoTarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoOutt/";

declare function xf:consultaDatosTarjetaCreditoOutt($informacionTarjetaResponse1 as element(ns1:InformacionTarjetaResponse),
    $consultaDatosTarjetaCredito1 as element(ns0:consultaDatosTarjetaCredito))
    as element(ns0:consultaDatosTarjetaCreditoResponse) {
        <ns0:consultaDatosTarjetaCreditoResponse>
            <ns0:consultaDatosTarjetaCreditoResponseType>
                <ns0:consultaDatosTarjetaCreditoResponseRecordType>
                    <CARD_NUMBER>{ data($consultaDatosTarjetaCredito1/CARD_NUMBER) }</CARD_NUMBER>
                    {
                        for $NombreTarjetaTitular in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:NombreTarjetaTitular
                        return
                            <ACCOUNT_HOLDER_NAME>{ data($NombreTarjetaTitular) }</ACCOUNT_HOLDER_NAME>
                    }
                    {
                        for $NombreTarjetaHabiente in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:NombreTarjetaHabiente
                        return
                            <CARD_HOLDER_NAME>{ data($NombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                    }
                    {
                        for $TipoTarjeta in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:TipoTarjeta
                        return
                            <CARD_TYPE>{ data($TipoTarjeta) }</CARD_TYPE>
                    }
                    {
                        for $CodigoClienteCuenta in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:CodigoClienteCuenta
                        return
                            <CUSTOMER_ID>{ data($CodigoClienteCuenta) }</CUSTOMER_ID>
                    }
                    {
                        for $IdentificacionCLienteTarjeta in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:IdentificacionCLienteTarjeta
                        return
                            <CARD_HOLDER_LEGAL_ID>{ data($IdentificacionCLienteTarjeta) }</CARD_HOLDER_LEGAL_ID>
                    }
                    {
                        for $IdentificacionClienteCuenta in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:IdentificacionClienteCuenta
                        return
                            <ACCOUNT_HOLDER_LEGAL_ID>{ data($IdentificacionClienteCuenta) }</ACCOUNT_HOLDER_LEGAL_ID>
                    }
                    {
                        for $NumeroCuenta in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:NumeroCuenta
                        return
                            <ACCOUNT_NUMBER>{ data($NumeroCuenta) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $Producto in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:Producto
                        return
                            <PRODUCT>{ data($Producto) }</PRODUCT>
                    }
                    {
                        for $GrupoAfinidad in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:GrupoAfinidad
                        return
                            <AFINITY_GROUP>{ data($GrupoAfinidad) }</AFINITY_GROUP>
                    }
                    {
                        for $EstadoCuenta in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:EstadoCuenta
                        return
                            <ACCOUNT_STATUS>{ data($EstadoCuenta) }</ACCOUNT_STATUS>
                    }
                    {
                        for $EstadoTarjeta in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:EstadoTarjeta
                        return
                            <CARD_STATUS>{ data($EstadoTarjeta) }</CARD_STATUS>
                    }
                    {
                        for $FechaVencimiento in $informacionTarjetaResponse1/ns1:InformacionTarjetaResult/ns1:FechaVencimiento
                        return
                            <CARD_EXPIRATION_DATE>{ data($FechaVencimiento) }</CARD_EXPIRATION_DATE>
                    }
                </ns0:consultaDatosTarjetaCreditoResponseRecordType>
            </ns0:consultaDatosTarjetaCreditoResponseType>
        </ns0:consultaDatosTarjetaCreditoResponse>
};

declare variable $informacionTarjetaResponse1 as element(ns1:InformacionTarjetaResponse) external;
declare variable $consultaDatosTarjetaCredito1 as element(ns0:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoOutt($informacionTarjetaResponse1,
    $consultaDatosTarjetaCredito1)