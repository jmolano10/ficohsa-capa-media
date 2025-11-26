(:: pragma bea:global-element-parameter parameter="$consultaImagenChequeRequest1" element="ns0:consultaImagenChequeRequest" location="../Resources/procesoImagenesChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultarImagenesCheques" location="../Resources/XMLSchema_-753785776.xsd" ::)

declare namespace ns1 = "http://services.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/consultaImagenCheque/consultaImagenChequeIn/";

declare function xf:consultaImagenChequeIn($consultaImagenChequeRequest1 as element(ns0:consultaImagenChequeRequest),
    $cuentaT24 as xs:string,
    $cuentaAbanks as xs:string)
    as element(ns1:consultarImagenesCheques) {
        <ns1:consultarImagenesCheques>
            <consultaImagenesChequesRequest>
                <numeroCuenta>{ $cuentaT24 }</numeroCuenta>
                <numeroCuentaAlterno>{ $cuentaAbanks }</numeroCuentaAlterno>
                <numeroCheque>{ data($consultaImagenChequeRequest1/CHEQUE_NUMBER) }</numeroCheque>
                <referenciaTransaccion>{ data($consultaImagenChequeRequest1/TRANSACTION_REFERENCE) }</referenciaTransaccion>
            </consultaImagenesChequesRequest>
        </ns1:consultarImagenesCheques>
};

declare variable $consultaImagenChequeRequest1 as element(ns0:consultaImagenChequeRequest) external;
declare variable $cuentaT24 as xs:string external;
declare variable $cuentaAbanks as xs:string external;

xf:consultaImagenChequeIn($consultaImagenChequeRequest1,
    $cuentaT24,
    $cuentaAbanks)