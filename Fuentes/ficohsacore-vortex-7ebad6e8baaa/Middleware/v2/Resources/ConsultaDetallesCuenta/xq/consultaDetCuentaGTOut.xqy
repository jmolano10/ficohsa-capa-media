xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetallesCuentaResponse" location="../xsd/consultaDetallesCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaDetallesCuenta/xq/consultaDetallesCuentaOut/";

declare function xf:consultaDetallesCuentaOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaDetallesCuentaResponse) {
        <ns0:consultaDetallesCuentaResponse>
            <ns0:consultaDetallesCuentaResponseType>
                {
                    let $OutputParameters := $outputParameters1
                    return
                        <ns0:consultaDetallesCuentaResponseRecordType>
                            <ACCOUNT_NUMBER>{ data($OutputParameters/ns1:ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                            <CUSTOMER_ID>{ data($OutputParameters/ns1:CUSTOMER_ID) }</CUSTOMER_ID>
                            <ACCOUNT_NAME>{ data($OutputParameters/ns1:ACCOUNT_NAME) }</ACCOUNT_NAME>
                            <CATEGORY>{ data($OutputParameters/ns1:CATEGORY) }</CATEGORY>
                            <CURRENCY>{ data($OutputParameters/ns1:CURRENCY) }</CURRENCY>
                            <LIMIT_REF>{ data($OutputParameters/ns1:LIMIT_REF) }</LIMIT_REF>
                            <RESTRICTIONS>{ data($OutputParameters/ns1:RESTRICTIONS) }</RESTRICTIONS>
                            <ALT_ACCOUNT>{ data($OutputParameters/ns1:ALT_ACCOUNT) }</ALT_ACCOUNT>
                            <OPENING_DATE>{ data($OutputParameters/ns1:OPENING_DATE) }</OPENING_DATE>
                            <OPERATION_TYPE>{ data($OutputParameters/ns1:OPERATION_TYPE) }</OPERATION_TYPE>
                            <ACCOUNT_OFFICER>{ data($OutputParameters/ns1:ACCOUNT_OFFICER) }</ACCOUNT_OFFICER>
                            <BRANCH_CODE>{ data($OutputParameters/ns1:BRANCH_CODE) }</BRANCH_CODE>
                            <LEGAL_ID>{ data($OutputParameters/ns1:LEGAL_ID) }</LEGAL_ID>
                            <REQUIRED_SIGNATURES>{ data($OutputParameters/ns1:REQUIRED_SIGNATURES) }</REQUIRED_SIGNATURES>
                            <SIGNATURE_DESC>{ data($OutputParameters/ns1:SIGNATURE_DESC) }</SIGNATURE_DESC>
                            <INACTIVE_MARKER>{ data($OutputParameters/ns1:INACTIVE_MARKER) }</INACTIVE_MARKER>
                        </ns0:consultaDetallesCuentaResponseRecordType>
                }
            </ns0:consultaDetallesCuentaResponseType>
        </ns0:consultaDetallesCuentaResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaDetallesCuentaOut($outputParameters1)