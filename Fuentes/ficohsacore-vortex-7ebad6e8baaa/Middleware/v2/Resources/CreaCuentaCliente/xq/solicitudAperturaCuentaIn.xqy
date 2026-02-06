xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaCuentaCliente" element="ns0:creaCuentaCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:solicitudAperturaCuenta" location="../../SolicitudAperturaCuenta/xsd/solicitudAperturaCuentaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudAperturaCuentaTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/solicitudAperturaCuentaIn/";

declare function xf:solicitudAperturaCuentaIn($creaCuentaCliente as element(ns0:creaCuentaCliente),
    $processType as xs:string,
    $branchCode as xs:string,
    $operationType as xs:string,
    $customer as xs:string)
    as element(ns1:solicitudAperturaCuenta) {
        <ns1:solicitudAperturaCuenta>
            <PROCESS_TYPE>{ $processType }</PROCESS_TYPE>
            <INTERFACE_USER>{ data($creaCuentaCliente/INTERFACE_USER) }</INTERFACE_USER>
            <BRANCH_CODE>{ $branchCode }</BRANCH_CODE>
            <ACCOUNT_DETAILS>
                {
                    let $ACCOUNT_INFORMATION := $creaCuentaCliente/ACCOUNT_INFORMATION
                    return
                        <ACCOUNT_DETAIL>
                            <CUSTOMER_CODE>{ data( $customer) }</CUSTOMER_CODE>
                            <CATEGORY>{ data($ACCOUNT_INFORMATION/CATEGORY) }</CATEGORY>
                            <CURRENCY>{ data($ACCOUNT_INFORMATION/CURRENCY) }</CURRENCY>
                            <OPERATION_TYPE>{ $operationType }</OPERATION_TYPE>
                            <REFERRED_TYPE>{ data($ACCOUNT_INFORMATION/REFERRED_TYPE) }</REFERRED_TYPE>
                            <PAYROLL_GROUP>{ data($ACCOUNT_INFORMATION/PAYROLL_GROUP) }</PAYROLL_GROUP>
                            <INITIAL_DEPOSIT>{ data($ACCOUNT_INFORMATION/INITIAL_DEPOSIT) }</INITIAL_DEPOSIT>
                            <PURPOSE>{ data($ACCOUNT_INFORMATION/PURPOSE) }</PURPOSE>
                            <ORIGEN_OF_FUNDS>{ data($ACCOUNT_INFORMATION/ORIGEN_OF_FUNDS) }</ORIGEN_OF_FUNDS>
                            <MONTHLY_TXN_VOLUME>{ data($ACCOUNT_INFORMATION/MONTHLY_TXN_VOLUME) }</MONTHLY_TXN_VOLUME>
                            <ADDRESS_TYPE>{ data($ACCOUNT_INFORMATION/ADDRESS_TYPE) }</ADDRESS_TYPE>
                            {
                                let $BENEFICIARY_DETAILS := $ACCOUNT_INFORMATION/BENEFICIARY_DETAILS
                                return
                                    <BENEFICIARY_DETAILS>
                                        {
                                            for $BENEFICIARY_DETAIL in $BENEFICIARY_DETAILS/BENEFICIARY_DETAIL
                                            return
                                                <BENEFICIARY_DETAIL>
                                                    <BENEFICIARY_NAME>{ data($BENEFICIARY_DETAIL/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                                                    <RELATION>{ data($BENEFICIARY_DETAIL/RELATION_CODE) }</RELATION>
                                                    <DOCUMENT_TYPE>{ data($BENEFICIARY_DETAIL/DOCUMENT_TYPE) }</DOCUMENT_TYPE>
                                                    <LEGAL_ID>{ data($BENEFICIARY_DETAIL/LEGAL_ID) }</LEGAL_ID>
                                                    <BENEFICIARY_PERCENTAGE>{ data($BENEFICIARY_DETAIL/BENEFICIARY_PERCENTAGE) }</BENEFICIARY_PERCENTAGE>
                                                </BENEFICIARY_DETAIL>
                                        }
                                    </BENEFICIARY_DETAILS>
                            }
                            {
                                let $SIGNATORY_DETAILS := $ACCOUNT_INFORMATION/SIGNATORY_DETAILS
                                return
                                    <SIGNATORY_DETAILS>
                                        <REGISTERED_SIGNATORY>{ data($SIGNATORY_DETAILS/REGISTERED_SIGNATORY) }</REGISTERED_SIGNATORY>
                                        <REQUIRED_SIGNATORY>{ data($SIGNATORY_DETAILS/REQUIRED_SIGNATORY) }</REQUIRED_SIGNATORY>
                                        <SIGNATORY_DESCRIPTION>{ data($SIGNATORY_DETAILS/SIGNATORY_DESCRIPTION) }</SIGNATORY_DESCRIPTION>
                                    </SIGNATORY_DETAILS>
                            }
                        </ACCOUNT_DETAIL>
                }
            </ACCOUNT_DETAILS>
        </ns1:solicitudAperturaCuenta>
};

declare variable $creaCuentaCliente as element(ns0:creaCuentaCliente) external;
declare variable $processType as xs:string external;
declare variable $branchCode as xs:string external;
declare variable $operationType as xs:string external;
declare variable $customer as xs:string external;

xf:solicitudAperturaCuentaIn($creaCuentaCliente,
    $processType,
    $branchCode,
    $operationType,
    $customer)