(:: pragma bea:global-element-parameter parameter="$consultarImagenesChequesResponse1" element="ns1:consultarImagenesChequesResponse" location="../Resources/XMLSchema_-753785776.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaImagenChequeResponse" location="../Resources/procesoImagenesChequesTypes.xsd" ::)

declare namespace ns1 = "http://services.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/consultaImagenCheque/consultaImagenChequeOut/";

declare function xf:consultaImagenChequeOut($consultarImagenesChequesResponse1 as element(ns1:consultarImagenesChequesResponse))
    as element(ns0:consultaImagenChequeResponse) {
        <ns0:consultaImagenChequeResponse>
            <ACCOUNT_NUMBER>{ data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/numeroCuenta) }</ACCOUNT_NUMBER>
            <CHEQUE_NUMBER>{ data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/consultaImagenesChequesArrayResponse/consultaImagenesChequesArrayDetailResponse[1]/numeroCheque) }</CHEQUE_NUMBER>
            <TRANSACTION_DATE>{ data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/consultaImagenesChequesArrayResponse/consultaImagenesChequesArrayDetailResponse[1]/fechaTransaccion) }</TRANSACTION_DATE>
            <CHEQUE_IMAGE_FRONT>{ data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/consultaImagenesChequesArrayResponse/consultaImagenesChequesArrayDetailResponse[1]/anversoCheque) }</CHEQUE_IMAGE_FRONT>
            <CHEQUE_IMAGE_BACK>{ data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/consultaImagenesChequesArrayResponse/consultaImagenesChequesArrayDetailResponse[1]/reversoCheque) }</CHEQUE_IMAGE_BACK>
            <FILE_EXTENSION>{ data($consultarImagenesChequesResponse1/consultaImagenesChequesResponse/consultaImagenesChequesArrayResponse/consultaImagenesChequesArrayDetailResponse[1]/formatoImagen) }</FILE_EXTENSION>
        </ns0:consultaImagenChequeResponse>
};

declare variable $consultarImagenesChequesResponse1 as element(ns1:consultarImagenesChequesResponse) external;

xf:consultaImagenChequeOut($consultarImagenesChequesResponse1)