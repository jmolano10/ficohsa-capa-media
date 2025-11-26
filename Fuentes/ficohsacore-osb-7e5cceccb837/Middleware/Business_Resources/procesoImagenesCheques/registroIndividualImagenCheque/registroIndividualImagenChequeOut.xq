(:: pragma bea:global-element-parameter parameter="$registrarImagenesChequesResponse1" element="ns1:registrarImagenesChequesResponse" location="../Resources/XMLSchema_-753785776.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registroIndividualImagenChequeResponse" location="../Resources/procesoImagenesChequesTypes.xsd" ::)

declare namespace ns1 = "http://services.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/registroIndividualImagenCheque/registroIndividualImagenChequeOut/";

declare function xf:registroIndividualImagenChequeOut($registrarImagenesChequesResponse1 as element(ns1:registrarImagenesChequesResponse))
    as element(ns0:registroIndividualImagenChequeResponse) {
        <ns0:registroIndividualImagenChequeResponse>
            <ACCOUNT_NUMBER>{ data($registrarImagenesChequesResponse1/registroImagenesChequesResponse[1]/numeroCuenta) }</ACCOUNT_NUMBER>
            <CHEQUE_NUMBER>{ data($registrarImagenesChequesResponse1/registroImagenesChequesResponse[1]/numeroCheque) }</CHEQUE_NUMBER>
        </ns0:registroIndividualImagenChequeResponse>
};

declare variable $registrarImagenesChequesResponse1 as element(ns1:registrarImagenesChequesResponse) external;

xf:registroIndividualImagenChequeOut($registrarImagenesChequesResponse1)