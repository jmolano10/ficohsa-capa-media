xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ConsultaTarjetaRequest" element="ns0:InformacionTarjetaActual" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$ConsultaTarjetaResponse" element="ns0:InformacionTarjetaActualResponse" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaDatosTarjetaCreditoResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoPAOutV2/";

declare function xf:consultaDatosTarjetaCreditoPAOutV2($ConsultaTarjetaRequest as element(ns0:InformacionTarjetaActual),
    $ConsultaTarjetaResponse as element(ns0:InformacionTarjetaActualResponse))
    as element(ns1:consultaDatosTarjetaCreditoResponse) {
        <ns1:consultaDatosTarjetaCreditoResponse>
            <ns1:consultaDatosTarjetaCreditoResponseType>
                <ns1:consultaDatosTarjetaCreditoResponseRecordType>
                    {
                        for $noTarjetaCredito in $ConsultaTarjetaRequest/ns0:noTarjetaCredito
                        return
                            <CARD_NUMBER>{ data($noTarjetaCredito) }</CARD_NUMBER>
                    }
                    {
                        for $NombreTarjetaTitular in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:NombreTarjetaTitular
                        return
                            <ACCOUNT_HOLDER_NAME>{ data($NombreTarjetaTitular) }</ACCOUNT_HOLDER_NAME>
                    }
                    {
                        for $NombreTarjetaHabiente in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:NombreTarjetaHabiente
                        return
                            <CARD_HOLDER_NAME>{ data($NombreTarjetaHabiente) }</CARD_HOLDER_NAME>
                    }
                    {
                        for $TipoTarjeta in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:TipoTarjeta
                        return
                            <CARD_TYPE>{ data($TipoTarjeta) }</CARD_TYPE>
                    }
                    {
                        for $CodigoClienteCuenta in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:CodigoClienteCuenta
                        return
                            <CUSTOMER_ID>{ data($CodigoClienteCuenta) }</CUSTOMER_ID>
                    }
                    {
                        for $IdentificacionCLienteTarjeta in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:IdentificacionCLienteTarjeta
                        return
                            <CARD_HOLDER_LEGAL_ID>{ data($IdentificacionCLienteTarjeta) }</CARD_HOLDER_LEGAL_ID>
                    }
                    {
                        for $IdentificacionClienteCuenta in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:IdentificacionClienteCuenta
                        return
                            <ACCOUNT_HOLDER_LEGAL_ID>{ data($IdentificacionClienteCuenta) }</ACCOUNT_HOLDER_LEGAL_ID>
                    }
                    {
                        for $NumeroCuenta in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:NumeroCuenta
                        return
                            <ACCOUNT_NUMBER>{ data($NumeroCuenta) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $Producto in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:Producto
                        return
                            <PRODUCT>{ data($Producto) }</PRODUCT>
                    }
                    {
                        for $GrupoAfinidad in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:GrupoAfinidad
                        return
                            <AFINITY_GROUP>{ data($GrupoAfinidad) }</AFINITY_GROUP>
                    }
                    {
                        for $EstadoCuenta in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:EstadoCuenta
                        return
                            <ACCOUNT_STATUS>{ data($EstadoCuenta) }</ACCOUNT_STATUS>
                    }
                    {
                        for $EstadoTarjeta in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:EstadoTarjeta
                        return
                            <CARD_STATUS>{ data($EstadoTarjeta) }</CARD_STATUS>
                    }
                    {
                        for $FechaVencimiento in $ConsultaTarjetaResponse/ns0:InformacionTarjetaActualResult/ns0:FechaVencimiento
                        return
                            <CARD_EXPIRATION_DATE>{ data($FechaVencimiento) }</CARD_EXPIRATION_DATE>
                    }
                </ns1:consultaDatosTarjetaCreditoResponseRecordType>
            </ns1:consultaDatosTarjetaCreditoResponseType>
        </ns1:consultaDatosTarjetaCreditoResponse>
};

declare variable $ConsultaTarjetaRequest as element(ns0:InformacionTarjetaActual) external;
declare variable $ConsultaTarjetaResponse as element(ns0:InformacionTarjetaActualResponse) external;

xf:consultaDatosTarjetaCreditoPAOutV2($ConsultaTarjetaRequest,
    $ConsultaTarjetaResponse)