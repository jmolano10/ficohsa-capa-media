xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registraPagoTC1" element="ns1:registraPagoTC" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OperacionesACH/RegistraPagoTC/xsd/RegistraPagoTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistraPagoTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoTC/xq/registraPagoTC_In/";

declare function xf:registraPagoTC_In($registraPagoTC1 as element(ns1:registraPagoTC))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:GV_TICKET>{ data($registraPagoTC1/TICKET) }</ns0:GV_TICKET>
            <ns0:PN_AGENCIAORIGEN>{ data($registraPagoTC1/ORIGINATING_AGENCY) }</ns0:PN_AGENCIAORIGEN>
            <ns0:PV_MERCHANTNUMBER>{ data($registraPagoTC1/MERCHANT_NUMBER) }</ns0:PV_MERCHANTNUMBER>
            <ns0:PV_NUMEROTARJETA>{ data($registraPagoTC1/CREDIT_CARD_NUMBER) }</ns0:PV_NUMEROTARJETA>
            <ns0:PV_TIPOOPERACION>{ data($registraPagoTC1/OPERATION_TYPE) }</ns0:PV_TIPOOPERACION>
            <ns0:PN_TIPOMONEDA>{ data($registraPagoTC1/BALANCE_CURRENCY) }</ns0:PN_TIPOMONEDA>
            <ns0:PN_ORGANIZACION>{ data($registraPagoTC1/ORGANIZATIONS) }</ns0:PN_ORGANIZACION>
            <ns0:PV_MONEDATRANSACCION>{ data($registraPagoTC1/TRANSACTION_CURRENCY) }</ns0:PV_MONEDATRANSACCION>
            <ns0:PN_TASACAMBIO>{ data($registraPagoTC1/EXCHANGE_RATE) }</ns0:PN_TASACAMBIO>
            <ns0:PN_TIPOTRANSACCION>{ data($registraPagoTC1/TRANSACTION_TYPE) }</ns0:PN_TIPOTRANSACCION>
            <ns0:PV_CODIGOUSUARIO>{ data($registraPagoTC1/USER_CODE) }</ns0:PV_CODIGOUSUARIO>
            <ns0:PV_SECUENCIAMOVIMIENTO>{ data($registraPagoTC1/MOVEMENT_SEQUENCE) }</ns0:PV_SECUENCIAMOVIMIENTO>
            <ns0:PV_SECUENCIAORIGEN>{ data($registraPagoTC1/ORIGIN_SEQUENCE) }</ns0:PV_SECUENCIAORIGEN>
            <ns0:PN_VALOREFECTIVO>{ data($registraPagoTC1/CASH_VALUE) }</ns0:PN_VALOREFECTIVO>
            <ns0:PD_FECHAVALIDA>{ data($registraPagoTC1/VALID_DATE) }</ns0:PD_FECHAVALIDA>
            <ns0:PV_BANCOORIGEN>{ data($registraPagoTC1/ORIGIN_BANK) }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ data($registraPagoTC1/DESTINATION_BANK) }</ns0:PV_BANCODESTINO>
            <ns0:PV_DESCRIPCIONTRANSACCION>{ data($registraPagoTC1/TRANSACTION_DESCRIPTION) }</ns0:PV_DESCRIPCIONTRANSACCION>
            <ns0:PV_CANAL>{ data($registraPagoTC1/CHANNEL_CODE) }</ns0:PV_CANAL>
            <ns0:PV_NUMEROAUTORIZACION>{ data($registraPagoTC1/AUTHORIZATION_NUMBER) }</ns0:PV_NUMEROAUTORIZACION>
            <ns0:PV_APLICADO>{ data($registraPagoTC1/APPLIED) }</ns0:PV_APLICADO>
            <ns0:PV_APLICARENLINEA>{ data($registraPagoTC1/APPLIED_ON_LINE) }</ns0:PV_APLICARENLINEA>
        </ns0:InputParameters>
};

declare variable $registraPagoTC1 as element(ns1:registraPagoTC) external;

xf:registraPagoTC_In($registraPagoTC1)