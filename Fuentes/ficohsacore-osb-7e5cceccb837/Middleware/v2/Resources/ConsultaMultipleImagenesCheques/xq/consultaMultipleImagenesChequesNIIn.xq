(:: pragma bea:global-element-parameter parameter="$consultaMultipleImagenesChequesRequest" element="ns0:consultaMultipleImagenesChequesRequest" location="../xsd/procesoImagenesChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaImagenesCheques" location="../../../BusinessServices/ConsultaMultipleImagenesChequesNI/wsdl/ConsultaMultipleImagenesChequesNI.wsdl" ::)

declare namespace ns1 = "http://schemas.xmlsoap.org/soap/http";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleImagenesCheques/xq/consultaMultipleImagenesChequesNIIn/";

declare function xf:consultaMultipleImagenesChequesNIIn($consultaMultipleImagenesChequesRequest as element(ns0:consultaMultipleImagenesChequesRequest))
    as element(ns1:ConsultaImagenesCheques) {
        <ns1:ConsultaImagenesCheques>
            <ns1:ACCOUNT_NUMBER>{ data($consultaMultipleImagenesChequesRequest/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
            <ns1:CHEQUE_NUMBER>{ data($consultaMultipleImagenesChequesRequest/CHEQUE_NUMBER) }</ns1:CHEQUE_NUMBER>
            {
                for $AMOUNT in $consultaMultipleImagenesChequesRequest/AMOUNT
                return
                    <ns1:AMOUNT>{ data($AMOUNT) }</ns1:AMOUNT>
            }
        </ns1:ConsultaImagenesCheques>
};

declare variable $consultaMultipleImagenesChequesRequest as element(ns0:consultaMultipleImagenesChequesRequest) external;

xf:consultaMultipleImagenesChequesNIIn($consultaMultipleImagenesChequesRequest)