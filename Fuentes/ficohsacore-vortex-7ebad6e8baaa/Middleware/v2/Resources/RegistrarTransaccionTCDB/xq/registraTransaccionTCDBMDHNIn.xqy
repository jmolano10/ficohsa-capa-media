xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registrarTransaccionTCDB" element="ns1:registrarTransaccionTCDB" location="../xsd/registrarTransaccionTCDBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/MasterData/conRegistraPagoTCRG/xsd/conRegistraPagoTCRG_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registrarTransaccionTCDBTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conRegistraPagoTCRG";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarTransaccionTCDB/xq/registraPagosTCMDHNIn/";

declare function xf:registraPagosTCMDHNIn($registrarTransaccionTCDB as element(ns1:registrarTransaccionTCDB),
    $merchantNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>HND</ns0:Pais>
            <ns0:AgenciaOrigen>{ data($registrarTransaccionTCDB/AGENCIAORIGEN) }</ns0:AgenciaOrigen>
            <ns0:MerchantNumber>{ data($merchantNumber) }</ns0:MerchantNumber>
            {
                for $NUMEROTARJETA in $registrarTransaccionTCDB/NUMEROTARJETA
                return
                    <ns0:NumTarjeta>{ data($NUMEROTARJETA) }</ns0:NumTarjeta>
            }
            {
                for $TIPOOPERACION in $registrarTransaccionTCDB/TIPOOPERACION
                return
                    <ns0:TipoOperacion>{ data($TIPOOPERACION) }</ns0:TipoOperacion>
            }
            <ns0:TipoMoneda>{ data($registrarTransaccionTCDB/TIPOMONEDA) }</ns0:TipoMoneda>
            <ns0:Organizacion>{ data($registrarTransaccionTCDB/ORGANIZACION) }</ns0:Organizacion>
            {
                for $MONEDATRANSACCION in $registrarTransaccionTCDB/MONEDATRANSACCION
                return
                    <ns0:MonedaTransaccion>{ data($MONEDATRANSACCION) }</ns0:MonedaTransaccion>
            }
            <ns0:TasaCambio>{ data($registrarTransaccionTCDB/TASACAMBIO) }</ns0:TasaCambio>
            <ns0:TipoTransaccion>{ data($registrarTransaccionTCDB/TIPOTRANSACCION) }</ns0:TipoTransaccion>
            {
                for $CODIGOUSUARIO in $registrarTransaccionTCDB/CODIGOUSUARIO
                return
                    <ns0:CodigoUsuario>{ data($CODIGOUSUARIO) }</ns0:CodigoUsuario>
            }
            <ns0:SecuenciaMovimiento>{ data($registrarTransaccionTCDB/SECUENCIAMOVIMIENTO) }</ns0:SecuenciaMovimiento>
            {
                for $SECUENCIAORIGEN in $registrarTransaccionTCDB/SECUENCIAORIGEN
                return
                    <ns0:SecuenciaOrigen>{ data($SECUENCIAORIGEN) }</ns0:SecuenciaOrigen>
            }
            <ns0:ValorEfectivo>{ data($registrarTransaccionTCDB/VALOREFECTIVO) }</ns0:ValorEfectivo>
            <ns0:ValorCheques>{ data($registrarTransaccionTCDB/VALORCHEQUES) }</ns0:ValorCheques>
            <ns0:NumDocumento>{ data($registrarTransaccionTCDB/NUMERODOCUMENTO) }</ns0:NumDocumento>
            <ns0:FechaValida>{ data($registrarTransaccionTCDB/FECHAVALIDA) }</ns0:FechaValida>
            <ns0:TipoCheque>{ data($registrarTransaccionTCDB/TIPOCHEQUE) }</ns0:TipoCheque>
            {
                for $BANCOORIGEN in $registrarTransaccionTCDB/BANCOORIGEN
                return
                    <ns0:BancoOrigen>{ data($BANCOORIGEN) }</ns0:BancoOrigen>
            }
            {
                for $BANCODESTINO in $registrarTransaccionTCDB/BANCODESTINO
                return
                    <ns0:BancoDestino>{ data($BANCODESTINO) }</ns0:BancoDestino>
            }
            <ns0:Canal>{ data($registrarTransaccionTCDB/CANAL) }</ns0:Canal>
            <ns0:NoAutorizacion>{ data($registrarTransaccionTCDB/NUMEROAUTORIZACION) }</ns0:NoAutorizacion>
            {
                if(data($registrarTransaccionTCDB/APLICADO) != "")then(
                    <ns0:Aplicado>{ data($registrarTransaccionTCDB/APLICADO) }</ns0:Aplicado>
                )else(
                    <ns0:Aplicado>N</ns0:Aplicado>
                )
            }
            {
                if(data($registrarTransaccionTCDB/APLICARENLINEA) != "")then(
                    <ns0:AplicarEnLinea>{ data($registrarTransaccionTCDB/APLICARENLINEA) }</ns0:AplicarEnLinea>
                )else(
                    <ns0:AplicarEnLinea>S</ns0:AplicarEnLinea>
                )
            }
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>temp</ns0:MensajeError>
        </ns0:InputParameters>
};

declare variable $registrarTransaccionTCDB as element(ns1:registrarTransaccionTCDB) external;
declare variable $merchantNumber as xs:string external;

xf:registraPagosTCMDHNIn($registrarTransaccionTCDB,
    $merchantNumber)