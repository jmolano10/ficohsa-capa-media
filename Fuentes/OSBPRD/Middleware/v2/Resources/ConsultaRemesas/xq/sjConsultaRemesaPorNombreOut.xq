(:: pragma bea:global-element-parameter parameter="$sjConsultaRemesaPorNombreResponse" element="ns1:sjConsultaRemesaPorNombreResponse" location="../../../BusinessServices/SJS/consultaRemesaPorNombre/xsd/sjConsultaRemesaPorNombre.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="../xsd/consultaRemesasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRemesaPorNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/sjConsultaRemesaPorNombreOut/";

declare function xf:sjConsultaRemesaPorNombreOut($sjConsultaRemesaPorNombreResponse as element(ns1:sjConsultaRemesaPorNombreResponse))
    as element(ns0:consultaRemesasResponse) {
        <ns0:consultaRemesasResponse>
            <ns0:consultaRemesasResponseType>
                {
                    for $consultaRemesaPorNombreResponseRecordType in $sjConsultaRemesaPorNombreResponse/ns1:consultaRemesaPorNombreResponseType/ns1:consultaRemesaPorNombreResponseRecordType
                    return
                        <ns0:consultaRemesasResponseRecordType>
                            <REMITTANCE_ID>{ data($consultaRemesaPorNombreResponseRecordType/ns1:REMITTANCE_ID) }</REMITTANCE_ID>
                            <REMITTER_ID>{ data($consultaRemesaPorNombreResponseRecordType/ns1:REMITTER_ID) }</REMITTER_ID>
                            <REMITTER_NAME>{ data($consultaRemesaPorNombreResponseRecordType/ns1:REMITTER_NAME) }</REMITTER_NAME>
                            <BENEFICIARY_NAME>{ data($consultaRemesaPorNombreResponseRecordType/ns1:BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                            <BRANCH_NAME>{ data($consultaRemesaPorNombreResponseRecordType/ns1:BRANCH_NAME) }</BRANCH_NAME>
                            <PAYMENT_DATE>{ data($consultaRemesaPorNombreResponseRecordType/ns1:PAYMENT_DATE) }</PAYMENT_DATE>
                            <CURRENCY>{ data($consultaRemesaPorNombreResponseRecordType/ns1:CURRENCY) }</CURRENCY>
                            <EXCHANGE_RATE>{ data($consultaRemesaPorNombreResponseRecordType/ns1:EXCHANGE_RATE) }</EXCHANGE_RATE>
                            <REMITTANCE_STATUS>{ data($consultaRemesaPorNombreResponseRecordType/ns1:REMITTANCE_STATUS) }</REMITTANCE_STATUS>
                            <REMITTANCE_AMOUNT>{ data($consultaRemesaPorNombreResponseRecordType/ns1:REMITTANCE_AMOUNT) }</REMITTANCE_AMOUNT>
                        </ns0:consultaRemesasResponseRecordType>
                }
            </ns0:consultaRemesasResponseType>
        </ns0:consultaRemesasResponse>
};

declare variable $sjConsultaRemesaPorNombreResponse as element(ns1:sjConsultaRemesaPorNombreResponse) external;

xf:sjConsultaRemesaPorNombreOut($sjConsultaRemesaPorNombreResponse)