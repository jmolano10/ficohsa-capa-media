(:: pragma bea:global-element-parameter parameter="$pagoPrestamo1" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaPrestamoResponse1" element="ns2:sjConsultaPrestamoResponse" location="../../xsds/PagoPrestamoCaja/sjConsultaPrestamo.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/RegistrarErrorPagoPtmo/registrarErrorPagoPtmo_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarErrorPagoPtmo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/RegistrarErrorPagoPtmoIn/";

declare function xf:RegistrarErrorPagoPtmoIn($pagoPrestamo1 as element(ns0:pagoPrestamo),
    $sjConsultaPrestamoResponse1 as element(ns2:sjConsultaPrestamoResponse),
    $uuid as xs:string,
    $userName as xs:string,
    $transactionId as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_UUID>{ $uuid }</ns1:PV_UUID>
            <ns1:PV_PRESTAMO>{ data($pagoPrestamo1/LOAN_NUMBER) }</ns1:PV_PRESTAMO>
            <ns1:PV_IDTRANSACCION>{ $transactionId }</ns1:PV_IDTRANSACCION>
            <ns1:PV_FECHA>{ fn:substring(fn:string(fn:current-date()),1,10) }</ns1:PV_FECHA>            
            <ns1:PV_USUARIO>{ $userName }</ns1:PV_USUARIO>
            <ns1:PV_MONEDA>{ data($pagoPrestamo1/PAYMENT_CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PN_MONTO>{ data($pagoPrestamo1/PAYMENT_AMOUNT) }</ns1:PN_MONTO>
            {
                for $SUCCESS_INDICATOR in $sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaAplicaPagoPrestamo/SUCCESS_INDICATOR
                return
                    <ns1:PV_CODIGOERROR>{ data($SUCCESS_INDICATOR) }</ns1:PV_CODIGOERROR>
            }
            {
                for $ERROR_MESSAGE in $sjConsultaPrestamoResponse1/ns2:sjConsultaPrestamoResponseType/ns2:consultaAplicaPagoPrestamo/ERROR_MESSAGE
                return
                    <ns1:PV_MENSAJEERROR>{ data($ERROR_MESSAGE) }</ns1:PV_MENSAJEERROR>
            }
        </ns1:InputParameters>
};

declare variable $pagoPrestamo1 as element(ns0:pagoPrestamo) external;
declare variable $sjConsultaPrestamoResponse1 as element(ns2:sjConsultaPrestamoResponse) external;
declare variable $uuid as xs:string external;
declare variable $userName as xs:string external;
declare variable $transactionId as xs:string external;

xf:RegistrarErrorPagoPtmoIn($pagoPrestamo1,
    $sjConsultaPrestamoResponse1,
    $uuid,
    $userName,
    $transactionId)