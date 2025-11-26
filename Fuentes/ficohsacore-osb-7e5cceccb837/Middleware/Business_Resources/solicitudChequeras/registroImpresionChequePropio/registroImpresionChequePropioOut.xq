(:: pragma bea:global-element-parameter parameter="$registrodechequerapropimpresionResponse" element="ns0:RegistrodechequerapropimpresionResponse" location="../Resources/XMLSchema_21306858.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registroImpresionChequeResponse" location="registroImpresionChequeTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroImpresionChequeTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/registroImpresionChequePropio/registroImpresionChequePropioOut/";

declare function xf:registroImpresionChequePropioOut($registrodechequerapropimpresionResponse as element(ns0:RegistrodechequerapropimpresionResponse))
    as element(ns1:registroImpresionChequeResponse) {
        <ns1:registroImpresionChequeResponse>
            {
                for $ACCOUNTNUMBER in $registrodechequerapropimpresionResponse/FICOHCHECKBOOKREQUESTType/ACCOUNTNUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $CHEQUETYPEID in $registrodechequerapropimpresionResponse/FICOHCHECKBOOKREQUESTType/CHEQUETYPEID
                return
                    <CHEQUEBOOK_TYPE>{ data($CHEQUETYPEID) }</CHEQUEBOOK_TYPE>
            }
            {
                for $CHEQUENOSTART in $registrodechequerapropimpresionResponse/FICOHCHECKBOOKREQUESTType/CHEQUENOSTART
                return
                    <FIRST_CHEQUE_NO>{ data($CHEQUENOSTART) }</FIRST_CHEQUE_NO>
            }
            {
                for $CHEQUENOEND in $registrodechequerapropimpresionResponse/FICOHCHECKBOOKREQUESTType/CHEQUENOEND
                return
                    <LAST_CHEQUE_NO>{ data($CHEQUENOEND) }</LAST_CHEQUE_NO>
            }
            {
                let $result :=
                    for $DATETIME in $registrodechequerapropimpresionResponse/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
        </ns1:registroImpresionChequeResponse>
};

declare variable $registrodechequerapropimpresionResponse as element(ns0:RegistrodechequerapropimpresionResponse) external;

xf:registroImpresionChequePropioOut($registrodechequerapropimpresionResponse)