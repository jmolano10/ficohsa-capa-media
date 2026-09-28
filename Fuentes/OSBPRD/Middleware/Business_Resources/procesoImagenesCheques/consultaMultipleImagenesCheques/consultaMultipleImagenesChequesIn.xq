(:: pragma bea:global-element-parameter parameter="$consultaMultipleImagenesChequesRequest1" element="ns0:consultaMultipleImagenesChequesRequest" location="../Resources/procesoImagenesChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultarImagenesCheques" location="../Resources/XMLSchema_-753785776.xsd" ::)

declare namespace ns1 = "http://services.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/consultaMultipleImagenesCheques/consultaMultipleImagenesChequesIn/";

declare function xf:consultaMultipleImagenesChequesIn($consultaMultipleImagenesChequesRequest1 as element(ns0:consultaMultipleImagenesChequesRequest),
    $cuentaT24 as xs:string,
    $cuentaAbanks as xs:string)
    as element(ns1:consultarImagenesCheques) {
        let $consultaMultipleImagenesChequesRequest := $consultaMultipleImagenesChequesRequest1
        return
            <ns1:consultarImagenesCheques>
                <consultaImagenesChequesRequest>
                    <numeroCuenta>{ $cuentaT24 }</numeroCuenta>
                    <numeroCuentaAlterno>{ $cuentaAbanks }</numeroCuentaAlterno>
                    <numeroCheque>{ data($consultaMultipleImagenesChequesRequest/CHEQUE_NUMBER) }</numeroCheque>
                    <referenciaTransaccion>{ data($consultaMultipleImagenesChequesRequest/TRANSACTION_REFERENCE) }</referenciaTransaccion>
                    <fechaInicio>{ data($consultaMultipleImagenesChequesRequest/START_DATE) }</fechaInicio>
                    <fechaFin>{ data($consultaMultipleImagenesChequesRequest/END_DATE) }</fechaFin>
                    <cantidad>{ data($consultaMultipleImagenesChequesRequest/MAX_CHEQUES) }</cantidad>
                    <posicionInicial>{ data($consultaMultipleImagenesChequesRequest/INITIAL_POSITION_RETURNED) }</posicionInicial>
                </consultaImagenesChequesRequest>
            </ns1:consultarImagenesCheques>
};

declare variable $consultaMultipleImagenesChequesRequest1 as element(ns0:consultaMultipleImagenesChequesRequest) external;
declare variable $cuentaT24 as xs:string external;
declare variable $cuentaAbanks as xs:string external;

xf:consultaMultipleImagenesChequesIn($consultaMultipleImagenesChequesRequest1,
    $cuentaT24,
    $cuentaAbanks)