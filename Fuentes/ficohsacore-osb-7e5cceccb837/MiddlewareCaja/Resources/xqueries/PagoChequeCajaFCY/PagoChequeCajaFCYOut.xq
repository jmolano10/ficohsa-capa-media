(:: pragma bea:global-element-parameter parameter="$cambioestadochqgerenciaFCYResponse" element="ns0:CambioestadochqgerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagodechequedegerenciaFCYResponse" element="ns0:PagodechequedegerenciaFCYResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoChequeCajaFCYResponse" location="../../xsds/PagoChequeCajaFCY/PagoChequeCajaFCY.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoChequeCajaFCYTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoChequeCajaFCY/PagoChequeCajaFCYOut/";

declare function xf:PagoChequeCajaFCYOut($cambioestadochqgerenciaFCYResponse as element(ns0:CambioestadochqgerenciaFCYResponse),
    $pagodechequedegerenciaFCYResponse as element(ns0:PagodechequedegerenciaFCYResponse),
    $branchName as xs:string)
    as element(ns1:pagoChequeCajaFCYResponse) {
        <ns1:pagoChequeCajaFCYResponse>
            {
                let $result :=
                    for $DATETIME in $pagodechequedegerenciaFCYResponse/TELLERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",$DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            {
                for $TELLERID1 in $pagodechequedegerenciaFCYResponse/TELLERType/TELLERID1
                return
                    <TELLER_ID>{ data($TELLERID1) }</TELLER_ID>
            }
            {
                for $ACCOUNT1 in $pagodechequedegerenciaFCYResponse/TELLERType/gACCOUNT1/mACCOUNT1[1]/ACCOUNT1
                return
                    <CHECK_ACCOUNT>{ data($ACCOUNT1) }</CHECK_ACCOUNT>
            }
            {
                for $AMOUNTLOCAL1 in $pagodechequedegerenciaFCYResponse/TELLERType/gACCOUNT1/mACCOUNT1[1]/AMOUNTLOCAL1
                return
                    <AMOUNT_LOCAL>{ data($AMOUNTLOCAL1) }</AMOUNT_LOCAL>
            }
            {
                for $AMOUNTFCY1 in $pagodechequedegerenciaFCYResponse/TELLERType/gACCOUNT1/mACCOUNT1[1]/AMOUNTFCY1
                return
                    <AMOUNT_FCY>{ data($AMOUNTFCY1) }</AMOUNT_FCY>
            }
            {
                for $NETAMOUNT in $pagodechequedegerenciaFCYResponse/TELLERType/NETAMOUNT
                return
                    <AMOUNT>{ data($NETAMOUNT) }</AMOUNT>
            }
            {
                for $RATE1 in $pagodechequedegerenciaFCYResponse/TELLERType/RATE1
                return
                    <EXCHAGE_RATE>{ data($RATE1) }</EXCHAGE_RATE>
            }
            {
                for $CURRENCY1 in $pagodechequedegerenciaFCYResponse/TELLERType/CURRENCY1
                return
                    <TRX_CURRENCY>{ data($CURRENCY1) }</TRX_CURRENCY>
            }
            {
                for $CURRENCY2 in $pagodechequedegerenciaFCYResponse/TELLERType/CURRENCY2
                return
                    <ACCOUNT_CURRENCY>{ data($CURRENCY2) }</ACCOUNT_CURRENCY>
            }
            {
                for $ACCOUNT2 in $pagodechequedegerenciaFCYResponse/TELLERType/ACCOUNT2
                return
                    <INTERNAL_ACCOUNT>{ data($ACCOUNT2) }</INTERNAL_ACCOUNT>
            }
            {
                for $CHEQUENUMBER in $pagodechequedegerenciaFCYResponse/TELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUENUMBER
                return
                    <CHECK_NUMBER>{ data($CHEQUENUMBER) }</CHECK_NUMBER>
            }
            {
                for $CHEQTYPE in $pagodechequedegerenciaFCYResponse/TELLERType/CHEQTYPE
                return
                    <CHECK_TYPE>{ data($CHEQTYPE) }</CHECK_TYPE>
            }
            {
                for $BENEFICIARYNAME in $cambioestadochqgerenciaFCYResponse/FICOFCYDRAFTDETAILSType/BENEFICIARYNAME
                return
                    <BENEFICIARY>{ data($BENEFICIARYNAME) }</BENEFICIARY>
            }
            {
                for $CHEQUEBANKCDE in $pagodechequedegerenciaFCYResponse/TELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUEBANKCDE
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
        </ns1:pagoChequeCajaFCYResponse>
};

declare variable $cambioestadochqgerenciaFCYResponse as element(ns0:CambioestadochqgerenciaFCYResponse) external;
declare variable $pagodechequedegerenciaFCYResponse as element(ns0:PagodechequedegerenciaFCYResponse) external;
declare variable $branchName as xs:string external;

xf:PagoChequeCajaFCYOut($cambioestadochqgerenciaFCYResponse,
    $pagodechequedegerenciaFCYResponse,
    $branchName)