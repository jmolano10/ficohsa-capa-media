xquery version "2004-draft";
(:: pragma  parameter="$ResponseXml" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultaMultipleImagenesChequesResponse" location="../xsd/procesoImagenesChequesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleImagenesCheques/xq/consultaMultipleImagenesChequesGTOut/";

declare function xf:consultaMultipleImagenesChequesGTOut($ResponseXml as element(*))
    as element(ns0:consultaMultipleImagenesChequesResponse) {
        <ns0:consultaMultipleImagenesChequesResponse>
            <ACCOUNT_NUMBER>{ $ResponseXml/respuesta/no_cuenta/text() }</ACCOUNT_NUMBER>
            <TOTAL_CHEQUES_FOUND>1</TOTAL_CHEQUES_FOUND>
            <TOTAL_CHEQUES_RETURNED>1</TOTAL_CHEQUES_RETURNED>
            <INITIAL_POSITION_RETURNED>1</INITIAL_POSITION_RETURNED>
            <LAST_POSITION_RETURNED>1</LAST_POSITION_RETURNED>
            <ns0:consultaMultipleImagenesChequesResponseType>
                <CHEQUE_NUMBER>{ $ResponseXml/respuesta/no_cheque/text() }</CHEQUE_NUMBER>
                <TRANSACTION_DATE>{ $ResponseXml/respuesta/fecha/text()  }</TRANSACTION_DATE>
                <CHEQUE_IMAGE_FRONT>{ $ResponseXml/respuesta/img_adelante/text() }</CHEQUE_IMAGE_FRONT>
                <CHEQUE_IMAGE_BACK>{ $ResponseXml/respuesta/img_atras/text() }</CHEQUE_IMAGE_BACK>
            </ns0:consultaMultipleImagenesChequesResponseType>
        </ns0:consultaMultipleImagenesChequesResponse>
};

declare variable $ResponseXml as element(*) external;

xf:consultaMultipleImagenesChequesGTOut($ResponseXml)