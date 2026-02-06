xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMultipleImagenesChequesRequestIN" element="ns0:consultaMultipleImagenesChequesRequest" location="../xsd/procesoImagenesChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:verCheque" location="../../../BusinessServices/ABKGT/vercheques/wsdl/consultaCapturaChequeGTPS.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleImagenesCheques/xq/consultaImagenChequesGTIN/";

declare function xf:consultaImagenChequesGTIN($consultaMultipleImagenesChequesRequestIN as element(ns0:consultaMultipleImagenesChequesRequest))
    as element(ns1:verCheque) {
        <ns1:verCheque>
            <ns1:numeroCuenta>{ data($consultaMultipleImagenesChequesRequestIN/ACCOUNT_NUMBER) }</ns1:numeroCuenta>
            <ns1:numeroCheque>{ data($consultaMultipleImagenesChequesRequestIN/CHEQUE_NUMBER) }</ns1:numeroCheque>
            {
                for $AMOUNT in $consultaMultipleImagenesChequesRequestIN/AMOUNT
                return
                    <ns1:monto>{ data($AMOUNT) }</ns1:monto>
            }
        </ns1:verCheque>
};

declare variable $consultaMultipleImagenesChequesRequestIN as element(ns0:consultaMultipleImagenesChequesRequest) external;

xf:consultaImagenChequesGTIN($consultaMultipleImagenesChequesRequestIN)