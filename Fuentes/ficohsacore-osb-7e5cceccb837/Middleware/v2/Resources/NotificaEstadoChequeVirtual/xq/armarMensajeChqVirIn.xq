(:: pragma bea:global-element-parameter parameter="$notificaEstadoChequeVirtual" element="ns1:notificaEstadoChequeVirtual" location="../xsd/notificaEstadoChequeVirtualTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ArmarMensajeNotificaChqVir/xsd/armarMensajeChqVir_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/armarMensajeChqVir";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoChequeVirtualTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoChequeVirtual/xq/armarMensajeChqVirIn/";

declare function xf:armarMensajeChqVirIn($notificaEstadoChequeVirtual as element(ns1:notificaEstadoChequeVirtual))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BANCOORIGEN>{ data($notificaEstadoChequeVirtual/ISSUING_BANK) }</ns0:PV_BANCOORIGEN>
            <ns0:PN_NOCHEQUE>{ xs:integer(data($notificaEstadoChequeVirtual/CHEQUE_NO)) }</ns0:PN_NOCHEQUE>
            <ns0:PV_MONEDA>{ data($notificaEstadoChequeVirtual/CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PN_MONTO>{ fn:replace((data($notificaEstadoChequeVirtual/AMOUNT)), ",", "") }</ns0:PN_MONTO>
            <ns0:PT_FECHA>{ fn-bea:dateTime-from-string-with-format("yyMMddHHmm", data($notificaEstadoChequeVirtual/DATE_TIME)) }</ns0:PT_FECHA>
            <ns0:PN_ESTADO>{ xs:integer(data($notificaEstadoChequeVirtual/STATUS)) }</ns0:PN_ESTADO>
            <ns0:PV_MENSAJEERROR>{ data($notificaEstadoChequeVirtual/MESSAGE) }</ns0:PV_MENSAJEERROR>
        </ns0:InputParameters>
};

declare variable $notificaEstadoChequeVirtual as element(ns1:notificaEstadoChequeVirtual) external;

xf:armarMensajeChqVirIn($notificaEstadoChequeVirtual)
