(:: pragma bea:global-element-parameter parameter="$cambioestadochqgerenciaFCYResponse" element="ns1:CambioestadochqgerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositodechequedegerenciaFCYResponse" element="ns1:DepositodechequedegerenciaFCYResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:depositoChequeCajaFCYResponse" location="../../xsds/DepositoChequeCajaFCY/DepositoChequeCajaFCY.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeCajaFCYTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCajaFCY/DepositoChequeCajaFCYOut/";

declare function xf:DepositoChequeCajaFCYOut($cambioestadochqgerenciaFCYResponse as element(ns1:CambioestadochqgerenciaFCYResponse),
    $depositodechequedegerenciaFCYResponse as element(ns1:DepositodechequedegerenciaFCYResponse),
    $branchName as xs:string)
    as element(ns0:depositoChequeCajaFCYResponse) {
        <ns0:depositoChequeCajaFCYResponse>
            {
                let $result :=
                    for $DATETIME in $depositodechequedegerenciaFCYResponse/TELLERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",$DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            {
                for $TELLERID1 in $depositodechequedegerenciaFCYResponse/TELLERType/TELLERID1
                return
                    <TELLER_ID>{ data($TELLERID1) }</TELLER_ID>
            }
            {
                for $ACCOUNT1 in $depositodechequedegerenciaFCYResponse/TELLERType/gACCOUNT1/mACCOUNT1[1]/ACCOUNT1
                return
                    <CHECK_ACCOUNT>{ data($ACCOUNT1) }</CHECK_ACCOUNT>
            }
            {
                for $AMOUNTLOCAL1 in $depositodechequedegerenciaFCYResponse/TELLERType/gACCOUNT1/mACCOUNT1[1]/AMOUNTLOCAL1
                return
                    <AMOUNT_LOCAL>{ data($AMOUNTLOCAL1) }</AMOUNT_LOCAL>
            }
            {
                for $AMOUNTFCY1 in $depositodechequedegerenciaFCYResponse/TELLERType/gACCOUNT1/mACCOUNT1[1]/AMOUNTFCY1
                return
                    <AMOUNT_FCY>{ data($AMOUNTFCY1) }</AMOUNT_FCY>
            }
            {
                for $NETAMOUNT in $depositodechequedegerenciaFCYResponse/TELLERType/NETAMOUNT
                return
                    <AMOUNT>{ data($NETAMOUNT) }</AMOUNT>
            }
            {
                for $RATE1 in $depositodechequedegerenciaFCYResponse/TELLERType/RATE1
                return
                    <EXCHAGE_RATE>{ data($RATE1) }</EXCHAGE_RATE>
            }
            {
                for $CURRENCY1 in $depositodechequedegerenciaFCYResponse/TELLERType/CURRENCY1
                return
                    <TRX_CURRENCY>{ data($CURRENCY1) }</TRX_CURRENCY>
            }
            {
                for $CURRENCY2 in $depositodechequedegerenciaFCYResponse/TELLERType/CURRENCY2
                return
                    <ACCOUNT_CURRENCY>{ data($CURRENCY2) }</ACCOUNT_CURRENCY>
            }
            {
                for $ACCOUNT2 in $depositodechequedegerenciaFCYResponse/TELLERType/ACCOUNT2
                return
                    <INTERNAL_ACCOUNT>{ data($ACCOUNT2) }</INTERNAL_ACCOUNT>
            }
            {
                for $CHEQUENUMBER in $depositodechequedegerenciaFCYResponse/TELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUENUMBER
                return
                    <CHECK_NUMBER>{ data($CHEQUENUMBER) }</CHECK_NUMBER>
            }
            {
                for $CHEQTYPE in $depositodechequedegerenciaFCYResponse/TELLERType/CHEQTYPE
                return
                    <CHECK_TYPE>{ data($CHEQTYPE) }</CHECK_TYPE>
            }
            {
                for $BENEFICIARYNAME in $cambioestadochqgerenciaFCYResponse/FICOFCYDRAFTDETAILSType/BENEFICIARYNAME
                return
                    <BENEFICIARY>{ data($BENEFICIARYNAME) }</BENEFICIARY>
            }
            {
                for $CHEQUEBANKCDE in $depositodechequedegerenciaFCYResponse/TELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUEBANKCDE
                return
                    <BANK_CODE>{ data($CHEQUEBANKCDE) }</BANK_CODE>
            }
            <BRANCH_NAME>{ fn:string($branchName) }</BRANCH_NAME>
            {
                let $result :=
                    for $INPUTTER in $cambioestadochqgerenciaFCYResponse/FICOFCYDRAFTDETAILSType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_")[2] }</INPUTTER>
                return
                    $result[1]
            }
        </ns0:depositoChequeCajaFCYResponse>
};

declare variable $cambioestadochqgerenciaFCYResponse as element(ns1:CambioestadochqgerenciaFCYResponse) external;
declare variable $depositodechequedegerenciaFCYResponse as element(ns1:DepositodechequedegerenciaFCYResponse) external;
declare variable $branchName as xs:string external;

xf:DepositoChequeCajaFCYOut($cambioestadochqgerenciaFCYResponse,
    $depositodechequedegerenciaFCYResponse,
    $branchName)