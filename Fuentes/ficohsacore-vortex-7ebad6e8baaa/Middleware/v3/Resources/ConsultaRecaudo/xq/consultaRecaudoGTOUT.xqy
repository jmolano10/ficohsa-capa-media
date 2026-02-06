xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/ConsultaRecaudo/xsd/ConsultaRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudoResponse" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/consultaRecaudoGTOUT/";

declare function xf:consultaRecaudoGTOUT($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaRecaudoResponse) {
        <ns0:consultaRecaudoResponse>
            {
                for $PV_CONTRACT_ID_OUT in $outputParameters1/ns1:PV_CONTRACT_ID_OUT
                return
                    <CONTRACT_ID>{ data($PV_CONTRACT_ID_OUT) }</CONTRACT_ID>
            }
            {
                for $PV_CONTRACT_NAME in $outputParameters1/ns1:PV_CONTRACT_NAME
                return
                    <CONTRACT_NAME>{ data($PV_CONTRACT_NAME) }</CONTRACT_NAME>
            }
            {
                for $PV_DEBTOR_CODE_OUT in $outputParameters1/ns1:PV_DEBTOR_CODE_OUT
                return
                    <DEBTOR_CODE>{ data($PV_DEBTOR_CODE_OUT) }</DEBTOR_CODE>
            }
            {
                for $PV_DEBTOR_NAME in $outputParameters1/ns1:PV_DEBTOR_NAME
                return
                    <DEBTOR_NAME>{ data($PV_DEBTOR_NAME) }</DEBTOR_NAME>
            }
            {
                for $PV_BILL_DETAIL in $outputParameters1/ns1:PV_BILL_DETAIL
                return
                    <BILL_DETAIL>{ data($PV_BILL_DETAIL) }</BILL_DETAIL>
            }
            <BILLS>
                <BILL_RECORD>
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_BILL_NUMBER/ns1:PV_BILL_NUMBER_ITEM
                            return
                                <BILL_NUMBER>{ data($PV_BILL_NUMBER_ITEM) }</BILL_NUMBER>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_CURRENCY_ITEM in $outputParameters1/ns1:PV_BILL_CURRENCY/ns1:PV_BILL_CURRENCY_ITEM
                            return
                                <BILL_CURRENCY>{ data($PV_BILL_CURRENCY_ITEM) }</BILL_CURRENCY>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_BILL_DATE_OUT/ns1:PV_BILL_NUMBER_ITEM
                            return
                                <BILL_DATE>{ data($PV_BILL_NUMBER_ITEM) }</BILL_DATE>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_DUE_DATE/ns1:PV_BILL_NUMBER_ITEM
                            return
                                <DUE_DATE>{ data($PV_BILL_NUMBER_ITEM) }</DUE_DATE>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_BILL_AMOUNT_OUT/ns1:PV_BILL_NUMBER_ITEM
                            return
                                <BILL_AMOUNT>{ data($PV_BILL_NUMBER_ITEM) }</BILL_AMOUNT>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_LATE_FEE/ns1:PV_BILL_NUMBER_ITEM
                            return
                                <LATE_FEE>{ data($PV_BILL_NUMBER_ITEM) }</LATE_FEE>
                        return
                            $result[1]
                    }
                    {
                        let $result :=
                            for $PV_BILL_NUMBER_ITEM in $outputParameters1/ns1:PV_TOTAL_AMOUNT/ns1:PV_BILL_NUMBER_ITEM
                            return
                                <TOTAL_AMOUNT>{ data($PV_BILL_NUMBER_ITEM) }</TOTAL_AMOUNT>
                        return
                            $result[1]
                    }
                </BILL_RECORD>
            </BILLS>
        </ns0:consultaRecaudoResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaRecaudoGTOUT($outputParameters1)