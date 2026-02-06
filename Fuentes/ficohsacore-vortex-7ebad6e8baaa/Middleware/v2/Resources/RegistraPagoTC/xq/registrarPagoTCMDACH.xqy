xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registraPagoTC1" element="ns1:registraPagoTC" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/MasterData/conRegistraPagoTCRG/xsd/conRegistraPagoTCRG_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conRegistraPagoTCRG";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoTC/xq/registrarPagoTCMDACH/";

declare function generarUUID()
as xs:string {
    let $uuid := fn-bea:uuid()
    let $cadena :=fn:tokenize($uuid,"-")
    return
    	(fn:concat($cadena[3],'-',$cadena[4],'-',$cadena[5]))
};

declare function xf:registrarPagoTCMDACH($registraPagoTC1 as element(ns1:registraPagoTC))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ 'HND' }</ns0:Pais>
            <ns0:AgenciaOrigen>{ data($registraPagoTC1/ORIGINATING_AGENCY) }</ns0:AgenciaOrigen>
            <ns0:MerchantNumber>{ data($registraPagoTC1/MERCHANT_NUMBER) }</ns0:MerchantNumber>
            <ns0:NumTarjeta>{ data($registraPagoTC1/CREDIT_CARD_NUMBER) }</ns0:NumTarjeta>
            <ns0:TipoOperacion>{ data($registraPagoTC1/OPERATION_TYPE) }</ns0:TipoOperacion>
            <ns0:TipoMoneda>{ data($registraPagoTC1/BALANCE_CURRENCY) }</ns0:TipoMoneda>
            <ns0:Organizacion>{ data($registraPagoTC1/ORGANIZATIONS) }</ns0:Organizacion>
            <ns0:MonedaTransaccion>{ data($registraPagoTC1/TRANSACTION_CURRENCY) }</ns0:MonedaTransaccion>
            <ns0:TasaCambio>{ data($registraPagoTC1/EXCHANGE_RATE) }</ns0:TasaCambio>
            <ns0:TipoTransaccion>{ data($registraPagoTC1/TRANSACTION_TYPE) }</ns0:TipoTransaccion>
            <ns0:CodigoUsuario>{ data($registraPagoTC1/USER_CODE) }</ns0:CodigoUsuario>
            <ns0:SecuenciaMovimiento>{ generarUUID() }</ns0:SecuenciaMovimiento>
            <ns0:SecuenciaOrigen>{ data($registraPagoTC1/ORIGIN_SEQUENCE) }</ns0:SecuenciaOrigen>
            <ns0:ValorEfectivo>{ data($registraPagoTC1/CASH_VALUE) }</ns0:ValorEfectivo>
            <ns0:FechaValida>{ data($registraPagoTC1/VALID_DATE) }</ns0:FechaValida>
            <ns0:BancoOrigen>{ data($registraPagoTC1/ORIGIN_BANK) }</ns0:BancoOrigen>
            <ns0:BancoDestino>{ data($registraPagoTC1/DESTINATION_BANK) }</ns0:BancoDestino>
            <ns0:DescripcionTXN>{ data($registraPagoTC1/TRANSACTION_DESCRIPTION) }</ns0:DescripcionTXN>
            <ns0:Canal>{ data($registraPagoTC1/CHANNEL_CODE) }</ns0:Canal>
            <ns0:NoAutorizacion>{ data($registraPagoTC1/AUTHORIZATION_NUMBER) }</ns0:NoAutorizacion>
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>temp</ns0:MensajeError>
        </ns0:InputParameters>
};

declare variable $registraPagoTC1 as element(ns1:registraPagoTC) external;

xf:registrarPagoTCMDACH($registraPagoTC1)