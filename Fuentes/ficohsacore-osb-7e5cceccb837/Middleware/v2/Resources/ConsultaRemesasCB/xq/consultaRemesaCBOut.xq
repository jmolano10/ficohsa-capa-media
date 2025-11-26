(:: pragma bea:global-element-parameter parameter="$consultaRemesasResponse" element="ns0:consultaRemesasResponse" location="../../ConsultaRemesas/xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRemesasResponse" location="../xsd/consultaRemesasCBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesasCB/xq/consultaRemesaCBOut/";

declare function xf:consultaRemesaCBOut($consultaRemesasResponse as element(ns0:consultaRemesasResponse))
    as element(ns1:consultaRemesasResponse) {
        <ns1:consultaRemesasResponse>
            {
                for $consultaRemesasResponseType in $consultaRemesasResponse/ns0:consultaRemesasResponseType
                return
                    <ns1:consultaRemesasResponseType>
                        {
                            for $consultaRemesasResponseRecordType in $consultaRemesasResponseType/ns0:consultaRemesasResponseRecordType
                            return
                                <ns1:consultaRemesasResponseRecordType>
                                    {
                                        for $REMITTANCE_ID in $consultaRemesasResponseRecordType/REMITTANCE_ID
                                        return
                                            <REMITTANCE_ID>{ data($REMITTANCE_ID) }</REMITTANCE_ID>
                                    }
                                    {
                                        for $REMITTER_ID in $consultaRemesasResponseRecordType/REMITTER_ID
                                        return
                                            <REMITTER_ID>{ data($REMITTER_ID) }</REMITTER_ID>
                                    }
                                    {
                                        for $REMITTER_NAME in $consultaRemesasResponseRecordType/REMITTER_NAME
                                        return
                                            <REMITTER_NAME>{ data($REMITTER_NAME) }</REMITTER_NAME>
                                    }
                                    {
                                        for $BENEFICIARY_NAME in $consultaRemesasResponseRecordType/BENEFICIARY_NAME
                                        return
                                            <BENEFICIARY_NAME>{ data($BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                                    }
                                    {
                                        for $BRANCH_NAME in $consultaRemesasResponseRecordType/BRANCH_NAME
                                        return
                                            <BRANCH_NAME>{ data($BRANCH_NAME) }</BRANCH_NAME>
                                    }
                                    {
                                        for $PAYMENT_DATE in $consultaRemesasResponseRecordType/PAYMENT_DATE
                                        return
                                            <PAYMENT_DATE>{ data($PAYMENT_DATE) }</PAYMENT_DATE>
                                    }
                                    {
                                        for $CURRENCY in $consultaRemesasResponseRecordType/CURRENCY
                                        return
                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                    }
                                    {
                                        for $EXCHANGE_RATE in $consultaRemesasResponseRecordType/EXCHANGE_RATE
                                        return
                                            <EXCHANGE_RATE>{ data($EXCHANGE_RATE) }</EXCHANGE_RATE>
                                    }
                                    {
                                        for $REMITTANCE_STATUS in $consultaRemesasResponseRecordType/REMITTANCE_STATUS
                                        return
                                            <REMITTANCE_STATUS>{ data($REMITTANCE_STATUS) }</REMITTANCE_STATUS>
                                    }
                                    {
                                        for $REMITTANCE_AMOUNT in $consultaRemesasResponseRecordType/REMITTANCE_AMOUNT
                                        return
                                            <REMITTANCE_AMOUNT>{ data($REMITTANCE_AMOUNT) }</REMITTANCE_AMOUNT>
                                    }
                                    {
                                        for $REMITTANCE_SOURCE_AMOUNT in $consultaRemesasResponseRecordType/REMITTANCE_SOURCE_AMOUNT
                                        return
                                            <REMITTANCE_SOURCE_AMOUNT>{ data($REMITTANCE_SOURCE_AMOUNT) }</REMITTANCE_SOURCE_AMOUNT>
                                    }
                                    {
                                        for $ORIGIN_COUNTRY in $consultaRemesasResponseRecordType/ORIGIN_COUNTRY
                                        return
                                            <ORIGIN_COUNTRY>{ data($ORIGIN_COUNTRY) }</ORIGIN_COUNTRY>
                                    }
                                </ns1:consultaRemesasResponseRecordType>
                        }
                    </ns1:consultaRemesasResponseType>
            }
        </ns1:consultaRemesasResponse>
};

declare variable $consultaRemesasResponse as element(ns0:consultaRemesasResponse) external;

xf:consultaRemesaCBOut($consultaRemesasResponse)
