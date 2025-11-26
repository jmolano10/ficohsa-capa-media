(:: pragma bea:global-element-parameter parameter="$sjConsultaDetalleContratoRecaudosResponse" element="ns0:sjConsultaDetalleContratoRecaudosResponse" location="../../../BusinessServices/SJS/consultaDetalleContratoRecaudos/xsd/sjConsultaDetalleContratoRecaudosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleContratoRecaudosResponse" location="../xsd/consultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaDetalleContratoRecaudosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xq/consultaDetalleContratoRecaudosOut/";

declare function xf:consultaDetalleContratoRecaudosOut($sjConsultaDetalleContratoRecaudosResponse as element(ns0:sjConsultaDetalleContratoRecaudosResponse))
    as element(ns1:consultaDetalleContratoRecaudosResponse) {
        <ns1:consultaDetalleContratoRecaudosResponse>
            {
                for $sjConsultaDetalleContratoRecaudosResponseType in $sjConsultaDetalleContratoRecaudosResponse/ns0:sjConsultaDetalleContratoRecaudosResponseType
                return
                    <ns1:consultaDetalleContratoRecaudosResponseType>
                        {
                            for $sjConsultaDetalleContratoRecaudosResponseRecordType in $sjConsultaDetalleContratoRecaudosResponseType/ns0:sjConsultaDetalleContratoRecaudosResponseRecordType
                            return
                                <ns1:consultaDetalleContratoRecaudosResponseRecordType>
                                    {
                                        for $CONTRACT_ID in $sjConsultaDetalleContratoRecaudosResponseRecordType/CONTRACT_ID
                                        return
                                            <CONTRACT_ID>{ data($CONTRACT_ID) }</CONTRACT_ID>
                                    }
                                    {
                                        for $CONTRACT_NAME in $sjConsultaDetalleContratoRecaudosResponseRecordType/CONTRACT_NAME
                                        return
                                            <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
                                    }
                                    {
                                        for $CUSTOMER_ID in $sjConsultaDetalleContratoRecaudosResponseRecordType/CUSTOMER_ID
                                        return
                                            <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
                                    }
                                    {
                                        for $INFO_EXCHANGE_TYPE in $sjConsultaDetalleContratoRecaudosResponseRecordType/INFO_EXCHANGE_TYPE
                                        return
                                            <INFO_EXCHANGE_TYPE>{ data($INFO_EXCHANGE_TYPE) }</INFO_EXCHANGE_TYPE>
                                    }
                                    {
                                        for $COLLECTION_TYPE in $sjConsultaDetalleContratoRecaudosResponseRecordType/COLLECTION_TYPE
                                        return
                                            <COLLECTION_TYPE>{ data($COLLECTION_TYPE) }</COLLECTION_TYPE>
                                    }
                                    {
                                        for $ALLOWED_BRANCHES in $sjConsultaDetalleContratoRecaudosResponseRecordType/ALLOWED_BRANCHES
                                        return
                                            <ALLOWED_BRANCHES>
                                                {
                                                    for $BRANCH_CODE in $ALLOWED_BRANCHES/BRANCH_CODE
                                                    return
                                                        <BRANCH_CODE>{ $BRANCH_CODE/@* , $BRANCH_CODE/node() }</BRANCH_CODE>
                                                }
                                            </ALLOWED_BRANCHES>
                                    }
                                    {
                                        for $PAYMENT_VALUE_CHECK in $sjConsultaDetalleContratoRecaudosResponseRecordType/PAYMENT_VALUE_CHECK
                                        return
                                            <PAYMENT_VALUE_CHECK>{ data($PAYMENT_VALUE_CHECK) }</PAYMENT_VALUE_CHECK>
                                    }
                                    {
                                        for $PAYMENT_METHODS in $sjConsultaDetalleContratoRecaudosResponseRecordType/PAYMENT_METHODS
                                        return
                                            <PAYMENT_METHODS>
                                                {
                                                    for $PAYMENT_METHOD in $PAYMENT_METHODS/PAYMENT_METHOD
                                                    return
                                                        <PAYMENT_METHOD>{ $PAYMENT_METHOD/@* , $PAYMENT_METHOD/node() }</PAYMENT_METHOD>
                                                }
                                            </PAYMENT_METHODS>
                                    }
                                    {
                                        for $PAY_OLD_BILL_FIRST in $sjConsultaDetalleContratoRecaudosResponseRecordType/PAY_OLD_BILL_FIRST
                                        return
                                            <PAY_OLD_BILL_FIRST>{ data($PAY_OLD_BILL_FIRST) }</PAY_OLD_BILL_FIRST>
                                    }
                                    {
                                        for $DUE_DATE_CHECK in $sjConsultaDetalleContratoRecaudosResponseRecordType/DUE_DATE_CHECK
                                        return
                                            <DUE_DATE_CHECK>{ data($DUE_DATE_CHECK) }</DUE_DATE_CHECK>
                                    }
                                    {
                                        for $PENALTY_TYPE in $sjConsultaDetalleContratoRecaudosResponseRecordType/PENALTY_TYPE
                                        return
                                            <PENALTY_TYPE>{ data($PENALTY_TYPE) }</PENALTY_TYPE>
                                    }
                                    {
                                        for $MULTI_CCY_CHECK in $sjConsultaDetalleContratoRecaudosResponseRecordType/MULTI_CCY_CHECK
                                        return
                                            <MULTI_CCY_CHECK>{ data($MULTI_CCY_CHECK) }</MULTI_CCY_CHECK>
                                    }
                                    {
                                        for $CONTRACT_ACCOUNTS in $sjConsultaDetalleContratoRecaudosResponseRecordType/CONTRACT_ACCOUNTS
                                        return
                                            <CONTRACT_ACCOUNTS>
                                                <CONTRACT_ACCOUNT>
                                                    {
                                                        for $CURRENCY in $CONTRACT_ACCOUNTS/CONTRACT_ACCOUNT[1]/CURRENCY
                                                        return
                                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                                    }
                                                    {
                                                        for $ACCOUNT in $CONTRACT_ACCOUNTS/CONTRACT_ACCOUNT[1]/ACCOUNT
                                                        return
                                                            <ACCOUNT>{ data($ACCOUNT) }</ACCOUNT>
                                                    }
                                                </CONTRACT_ACCOUNT>
                                            </CONTRACT_ACCOUNTS>
                                    }
                                    {
                                        for $CONTRACT_TYPE in $sjConsultaDetalleContratoRecaudosResponseRecordType/CONTRACT_TYPE
                                        return
                                            <CONTRACT_TYPE>{ data($CONTRACT_TYPE) }</CONTRACT_TYPE>
                                    }
                                </ns1:consultaDetalleContratoRecaudosResponseRecordType>
                        }
                    </ns1:consultaDetalleContratoRecaudosResponseType>
            }
        </ns1:consultaDetalleContratoRecaudosResponse>
};

declare variable $sjConsultaDetalleContratoRecaudosResponse as element(ns0:sjConsultaDetalleContratoRecaudosResponse) external;

xf:consultaDetalleContratoRecaudosOut($sjConsultaDetalleContratoRecaudosResponse)