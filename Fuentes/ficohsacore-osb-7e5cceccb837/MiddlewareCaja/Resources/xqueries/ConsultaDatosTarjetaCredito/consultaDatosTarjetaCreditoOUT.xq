(:: pragma bea:global-element-parameter parameter="$informacionTarjetaResponse1" element="ns0:InformacionTarjetaResponse" location="../../wsdls/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito1" element="ns1:consultaDatosTarjetaCredito" location="../../xsds/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDatosTarjetaCreditoResponse" location="../../xsds/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xsds/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoOUT/";

declare function xf:consultaDatosTarjetaCreditoOUT($informacionTarjetaResponse1 as element(ns0:InformacionTarjetaResponse),
    $consultaDatosTarjetaCredito1 as element(ns1:consultaDatosTarjetaCredito))
    as element(ns1:consultaDatosTarjetaCreditoResponse) {
        <ns1:consultaDatosTarjetaCreditoResponse>
            <ns1:consultaDatosTarjetaCreditoResponseType>
                <ns1:consultaDatosTarjetaCreditoResponseRecordType>
                    <CARD_NUMBER>{ data($consultaDatosTarjetaCredito1/CARD_NUMBER) }</CARD_NUMBER>
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
                </ns1:consultaDatosTarjetaCreditoResponseRecordType>
            </ns1:consultaDatosTarjetaCreditoResponseType>
        </ns1:consultaDatosTarjetaCreditoResponse>
};

declare variable $informacionTarjetaResponse1 as element(ns0:InformacionTarjetaResponse) external;
declare variable $consultaDatosTarjetaCredito1 as element(ns1:consultaDatosTarjetaCredito) external;

xf:consultaDatosTarjetaCreditoOUT($informacionTarjetaResponse1,
    $consultaDatosTarjetaCredito1)
