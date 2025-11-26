(:: pragma bea:global-element-parameter parameter="$emisiondechqdegerenciaTTResponse1" element="ns1:EmisiondechqdegerenciaTTResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../xsds/RegistrarLiqFondosExt/registrarLiqFondosExt_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:liquidacionFondosExtResponse" location="../../xsds/LiquidacionFondosExt/LiquidacionFondosExt.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/liquidacionFondosExtTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarLiqFondosExt";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/emisionChequeOut/";

declare function xf:emisionChequeOut($emisiondechqdegerenciaTTResponse1 as element(ns1:EmisiondechqdegerenciaTTResponse),
    $outputParameters1 as element(ns0:OutputParameters),
    $assetId as xs:string)
    as element(ns2:liquidacionFondosExtResponse) {
        <ns2:liquidacionFondosExtResponse>
            <ASSET_ID>{ $assetId }</ASSET_ID>
            {
                for $PV_NOMBRECONT in $outputParameters1/ns0:PV_NOMBRECONT
                return
                    <ASSET_NAME>{ data($PV_NOMBRECONT) }</ASSET_NAME>
            }
            <CURRENCY>HNL</CURRENCY>
            <ASSET_AMOUNT>{ fn:string($outputParameters1/ns2:PN_MONTOTOTAL/text()) }</ASSET_AMOUNT>
            {
                let $result :=
                    for $INPUTTER in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER),"_")[2] }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ fn:concat("20",data($DATETIME)) }</DATE_TIME>
                return
                    $result[1]
            }
            <CASHIER_CHECK>
                {
                    for $CREDITAMOUNT in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/CREDITAMOUNT
                    return
                        <CREDITAMOUNT>{ data($CREDITAMOUNT) }</CREDITAMOUNT>
                }
                {
                    for $LRCHQNOCONFRM in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/LRCHQNOCONFRM
                    return
                        <LRCHQNOCONFRM>{ data($LRCHQNOCONFRM) }</LRCHQNOCONFRM>
                }
                {
                    for $PROCESSINGDATE in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/PROCESSINGDATE
                    return
                        <PROCESSINGDATE>{ data($PROCESSINGDATE) }</PROCESSINGDATE>
                }
                {
                    for $PROCESSINGDATE in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/PROCESSINGDATE
                    return
                        <PROCESSINGDAY>{ fn:substring((data($PROCESSINGDATE)),7,2) }</PROCESSINGDAY>
                }
                {
                    for $PROCESSINGDATE in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/PROCESSINGDATE
                    return
                        <PROCESSINGMONTH>{ fn:substring((data($PROCESSINGDATE)),5,2) }</PROCESSINGMONTH>
                }
                {
                    for $PROCESSINGDATE in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/PROCESSINGDATE
                    return
                        <PROCESSINGYEAR>{ fn:substring((data($PROCESSINGDATE)),1,4) }</PROCESSINGYEAR>
                }
                {
                    for $LRBENNAME in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/LRBENNAME
                    return
                        <LRBENNAME>{ data($LRBENNAME) }</LRBENNAME>
                }
                {
                    let $result :=
                        for $LRAMTWORDS in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/gLRAMTWORDS/LRAMTWORDS
                        return
                            <LRAMTWORDS>{ data($LRAMTWORDS) }</LRAMTWORDS>
                    return
                        $result[1]
                }
                {
                    for $COCODE in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/COCODE
                    return
                        <COCODE>{ data($COCODE) }</COCODE>
                }
                {
                    let $result :=
                        for $INPUTTER in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/gINPUTTER/INPUTTER
                        return
                            <INPUTTER>{ fn:tokenize(data($INPUTTER),"_")[2] }</INPUTTER>
                    return
                        $result[1]
                }
                {
                    for $DEBITACCTNO in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/DEBITACCTNO
                    return
                        <DEBITACCTNO>{ data($DEBITACCTNO) }</DEBITACCTNO>
                }
                {
                    let $result :=
                        for $DATETIME in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/gDATETIME/DATETIME
                        return
                            <DATETIME>{ fn:concat("20",data($DATETIME)) }</DATETIME>
                    return
                        $result[1]
                }
            </CASHIER_CHECK>
        </ns2:liquidacionFondosExtResponse>
};

declare variable $emisiondechqdegerenciaTTResponse1 as element(ns1:EmisiondechqdegerenciaTTResponse) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $assetId as xs:string external;

xf:emisionChequeOut($emisiondechqdegerenciaTTResponse1,
    $outputParameters1,
    $assetId)